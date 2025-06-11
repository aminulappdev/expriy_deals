
import 'package:expriy_deals/app/utils/app_colors.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';


class DeliveryInformationCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget widget;
  const DeliveryInformationCard({
    super.key,
    required this.title,
    required this.icon,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 1,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.iconButtonThemeColor,
                    child: Icon(
                      icon,
                      color: Colors.white,
                    ),
                  ),
                  widthBox10,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          title,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      widget
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
