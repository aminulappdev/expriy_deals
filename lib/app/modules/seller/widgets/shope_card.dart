import 'package:expriy_deals/app/modules/product/views/product_datails_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopCard extends StatefulWidget {
  final String shopId;
  final String? image;
  final String? title;
  const ShopCard({
    super.key,
    
    this.image,
    this.title,
    required this.shopId,
  });

  @override
  State<ShopCard> createState() => _ShopCardState();
}

class _ShopCardState extends State<ShopCard> {
  @override
  void initState() {
    // print('Product card theke: ${widget.productId}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // print('Product card theke: ${widget.productId}');
        Get.to(ProductDetailScreen(
          productId: widget.shopId,
        ));
      },
      child: Card(
        elevation: 1,
        child: Container(
          height: 185.h,
          width: 156.w,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(widget.image ??
                                    'https://fastly.picsum.photos/id/471/200/300.jpg?hmac=N_ZXTRU2OGQ7b_1b8Pz2X8e6Qyd84Q7xAqJ90bju2WU'),
                                fit: BoxFit.fill),
                          ),
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: SingleChildScrollView(
                  child: Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    widget.title ?? 'name',
                    style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
