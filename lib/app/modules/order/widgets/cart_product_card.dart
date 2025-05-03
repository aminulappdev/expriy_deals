import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartProductCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String brand;
  final String color;
  final String quantity;
  final String price;
  final VoidCallback ontap;
  const CartProductCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.brand,
    required this.color,
    required this.quantity,
    required this.price,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 91.h,
        width: 317.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xffF9F9F9),
            // ignore: deprecated_member_use
            border: Border.all(color: Colors.black.withOpacity(0.05))),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 75.h,
                width: 77.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage(imagePath), fit: BoxFit.fill)),
              ),
              widthBox4,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      title,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    heightBox4,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100.w,
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            'Brand: $brand',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        Text(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          'Colour: $color',
                          style: TextStyle(fontSize: 13),
                        )
                      ],
                    ),
                    heightBox4,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          'product quantity: $quantity',
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          'Price : \$$price',
                          style: TextStyle(fontSize: 13),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
