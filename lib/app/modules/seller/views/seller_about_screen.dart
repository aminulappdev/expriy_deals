import 'package:expriy_deals/app/modules/product/model/product_details_model.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SellerAboutScreen extends StatefulWidget {
  final ProductDetailsData productDetailsData;

  const SellerAboutScreen({
    super.key,
    required this.productDetailsData,
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
                    text: widget.productDetailsData.author?.shop?.name ?? '',
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
                    text: widget.productDetailsData.author?.name ?? '',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black))
              ])),
          heightBox12,
          RichText(
              text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  text: 'Store Description : ',
                  children: [
                TextSpan(
                    text: widget.productDetailsData.author?.shop?.description ??
                        '',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black))
              ])),
          heightBox12,
          Text(
            'Location',
            style: GoogleFonts.poppins(
                fontSize: 12.sp, fontWeight: FontWeight.w600),
          ),
          heightBox12,
          Text(
            widget.productDetailsData.author?.shop?.address ?? '',
            style: GoogleFonts.poppins(
                fontSize: 12.sp, fontWeight: FontWeight.w400),
          ),
          heightBox12,
          Text(
            'Contact information',
            style: GoogleFonts.poppins(
                fontSize: 12.sp, fontWeight: FontWeight.w600),
          ),
          heightBox12,
          Text(
            widget.productDetailsData.author?.phoneNumber ?? '',
            style: GoogleFonts.poppins(
                fontSize: 12.sp, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
