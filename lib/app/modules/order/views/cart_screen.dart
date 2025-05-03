import 'package:expriy_deals/app/modules/order/widgets/cart_product_card.dart';
import 'package:expriy_deals/app/utils/app_colors.dart';
import 'package:expriy_deals/app/utils/assets_path.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:expriy_deals/app/widgets/costom_app_bar.dart';
import 'package:expriy_deals/app/widgets/gradiant_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heightBox24,
          CustomAppBar(name: 'My Cart'),
          heightBox12,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (value) {},
                  ),
                  widthBox4,
                  Text(
                    'Select all',
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.iconButtonThemeColor),
                    // ignore: deprecated_member_use
                    color: AppColors.iconButtonThemeColor.withOpacity(0.1)),
                child: Icon(
                  Icons.delete,
                  color: AppColors.iconButtonThemeColor,
                  size: 24,
                ),
              )
            ],
          ),
          heightBox10,
          SizedBox(
            height: 530.h,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (value) {},
                      ),
                      CartProductCard(
                        imagePath: AssetsPath.headphone,
                        title: 'SonicPulse Pro Over-Ear Headphones',
                        brand: 'SonicPulse all image ar',
                        color: 'Matte black',
                        quantity: '1',
                        price: '500',
                        ontap: () {},
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          heightBox10,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Subtotal'),
                        widthBox8,
                        Text(
                          '300',
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.w600,fontSize: 15),
                        ),
                      ],
                    ),
                    heightBox8,
                    Row(
                      children: [
                        Text('Shipping fee'),
                        widthBox8,
                        Text(
                          '300',
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.w600,fontSize: 15),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 48,
                  width: 200,
                  child: CustomElevatedButton(
                      onPressed: () {}, text: 'Check out (1)'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
