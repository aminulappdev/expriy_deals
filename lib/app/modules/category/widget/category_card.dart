import 'package:expriy_deals/app/utils/app_colors.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryCard extends StatelessWidget {
  final String image;
  final String name;
  final VoidCallback? onTap;
  const CategoryCard({
    super.key,
    required this.image,
    this.onTap,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60.h,
            width: 60.w,
            decoration: BoxDecoration(
              color: AppColors.iconButtonThemeColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: image == '' || image == null
                ? const Icon(
                    Icons.category,
                    color: Colors.white,
                    size: 30,
                  )
                : Container(
                    height: 20.h,
                    width: 20.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(image),
                        fit: BoxFit.fill,
                      ),
                    )),
          ),
          heightBox4,
          SizedBox(
            width: 70.w,
            child: Text(
              name,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
