import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckoutUserInfo extends StatelessWidget {
  final String name;
  final String number;
  final String status;
  final String address;
  final VoidCallback editOntap;
  final VoidCallback addressArrowOntap;
  const CheckoutUserInfo({
    super.key,
    required this.name,
    required this.number,
    required this.status,
    required this.address,
    required this.editOntap,
    required this.addressArrowOntap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: GoogleFonts.poppins(fontSize: 14.sp),
        ),
        Text(
          number,
          style: GoogleFonts.poppins(fontSize: 12.sp, color: Color(0xff626262)),
        ),
        heightBox8,
         
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.location_on_rounded,size: 18,),
                widthBox4,
                SizedBox(
                    width: 170,
                    child: Text(
                      address,
                      style: GoogleFonts.poppins(fontSize: 10.sp),
                    )),
                
              ],
            ),
          ],
        ),
      ],
    );
  }
}
