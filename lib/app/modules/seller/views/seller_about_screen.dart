import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';

class SellerAboutScreen extends StatefulWidget {
  
  const SellerAboutScreen({
    super.key,
  });

  @override
  State<SellerAboutScreen> createState() => _SellerAboutScreenState();
}

class _SellerAboutScreenState extends State<SellerAboutScreen> {
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  text: 'Strore Name : ',
                  children: [
                TextSpan(
                    text: 'Toy store',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black))
              ])),
              heightBox12,
               RichText(
              text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  text: 'Owner name : ',
                  children: [
                TextSpan(
                    text: 'Aminul Islam',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black))
              ])),
               heightBox12,
               RichText(
              text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  text: 'Description : ',
                  children: [
                TextSpan(
                    text: 'Aminul Islam',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black))
              ])),
               heightBox12,
               RichText(
              text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  text: 'Name : ',
                  children: [
                TextSpan(
                    text: 'Aminul Islam',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black))
              ])),
        ],
      ),
    );
  }
}
