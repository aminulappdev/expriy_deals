import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class RoutePage extends StatefulWidget {
  final double lat;
  final double long;

  const RoutePage({super.key, required this.lat, required this.long});

  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  late GoogleMapController mapController;
  late LatLng _destination = LatLng(widget.lat, widget.long);
  LatLng? _currentLocation;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  bool _isLoading = true; // Flag to manage loading state

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  // Request permissions when the app starts
  Future<void> _checkPermission() async {
    // Request location permission
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      // If permission is granted, get the location
      _getCurrentLocation();
    } else if (status.isDenied) {
      // If permission is denied, show an error message
      _showPermissionDeniedDialog();
    } else if (status.isPermanentlyDenied) {
      // If permission is permanently denied, open app settings to allow the user to change the permission
      // openAppSettings();
      _showPermissionDeniedDialog(); // Handle it by showing dialog if needed
    }
  }

  // Show a dialog if the location permission is denied
  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Location Permission Denied"),
        content: Text("We need location access to show the route. Please enable it in the settings."),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  // Get current location of the device
  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _addMarkers();
        _addRoute();
        _isLoading = false; // Stop loading once location is retrieved
      });
    } catch (e) {
      setState(() {
        _isLoading = false; // Stop loading if there's an error
      });
      // Show an error if location is not available
      _showErrorDialog();
    }
  }

  // Show error dialog if location fetching fails
  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error"),
        content: Text("Unable to fetch location. Please try again later."),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  // Add markers to the map
  void _addMarkers() {
    _markers.add(Marker(
      markerId: MarkerId('currentLocation'),
      position: _currentLocation!,
      infoWindow: InfoWindow(title: 'Current Location'),
    ));

    _markers.add(Marker(
      markerId: MarkerId('destination'),
      position: _destination,
      infoWindow: InfoWindow(title: 'Destination'),
    ));
  }

  // Add polyline (route) to the map
  void _addRoute() {
    _polylines.add(Polyline(
      polylineId: PolylineId('route'),
      points: [_currentLocation!, _destination],
      color: Colors.blue,
      width: 5,
    ));
  }

  // Google map controller initialization
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route to Destination'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _currentLocation == null
          ? Center(child: Text("Unable to fetch location"))
          : GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _currentLocation!,
          zoom: 12,
        ),
        markers: _markers,
        polylines: _polylines,
      ),
    );
  }
}
