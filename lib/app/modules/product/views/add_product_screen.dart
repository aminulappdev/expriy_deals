import 'package:expriy_deals/app/modules/common/views/main_bottom_nav_bar.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:expriy_deals/app/widgets/costom_app_bar.dart';
import 'package:expriy_deals/app/widgets/gradiant_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController detailsCtrl = TextEditingController();
  final TextEditingController categoryCtrl = TextEditingController();
  final TextEditingController priceCtrl = TextEditingController();
  final TextEditingController quantityCtrl = TextEditingController();
  final TextEditingController expiryDateCtrl = TextEditingController();
  final TextEditingController daysCtrl = TextEditingController();
  final TextEditingController discountCtrl = TextEditingController();

  bool _obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightBox20,
              CustomAppBar(name: 'add_product.app_bar_title'.tr), // Localized "Add product"
              heightBox16,
              Text('add_product.upload_image_label'.tr, style: GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.w400, color: const Color(0xff626262))), // Localized "Upload image"
              heightBox12,
              InkWell(
                onTap: () {},
                child: Container(
                  height: 140,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add, size: 40),
                      Text(
                        'add_product.add_product_label'.tr, // Localized "Add product"
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              heightBox8,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 63,
                      width: 115,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add, size: 20),
                          Text(
                            'add_product.add_product_label'.tr, // Localized "Add product"
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 63,
                      width: 115,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add, size: 20),
                          Text(
                            'add_product.add_product_label'.tr, // Localized "Add product"
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 63,
                      width: 115,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add, size: 20),
                          Text(
                            'add_product.add_product_label'.tr, // Localized "Add product"
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              heightBox12,
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'add_product.item_name_label'.tr, // Localized "Item Name"
                      style: GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.w400, color: const Color(0xff626262)),
                    ),
                    heightBox8,
                    TextFormField(
                      controller: nameCtrl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.text,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'add_product.error_messages.enter_item_name'.tr; // Localized "Enter item name"
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintStyle: const TextStyle(color: Colors.grey)),
                    ),
                    heightBox8,
                    Text(
                      'add_product.item_details_label'.tr, // Localized "Item Details"
                      style: GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.w400, color: const Color(0xff626262)),
                    ),
                    heightBox8,
                    TextFormField(
                      controller: detailsCtrl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'add_product.error_messages.enter_item_details'.tr; // Localized "Enter item details"
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintStyle: const TextStyle(color: Colors.grey)),
                    ),
                    heightBox8,
                    Text(
                      'add_product.category_label'.tr, // Localized "Category"
                      style: GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.w400, color: const Color(0xff626262)),
                    ),
                    heightBox8,
                    TextFormField(
                      controller: categoryCtrl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.text,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'add_product.error_messages.enter_category'.tr; // Localized "Enter category"
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintStyle: const TextStyle(color: Colors.grey)),
                    ),
                    heightBox8,
                    Text(
                      'add_product.item_price_label'.tr, // Localized "Item Price"
                      style: GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.w400, color: const Color(0xff626262)),
                    ),
                    heightBox8,
                    TextFormField(
                      controller: priceCtrl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'add_product.error_messages.enter_item_price'.tr; // Localized "Enter item price"
                        }
                        if (double.tryParse(value) == null || double.parse(value) <= 0) {
                          return 'add_product.error_messages.invalid_price'.tr; // Localized "Enter a valid price"
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintStyle: const TextStyle(color: Colors.grey)),
                    ),
                    heightBox8,
                    Text(
                      'add_product.item_quantity_label'.tr, // Localized "Item Quantity"
                      style: GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.w400, color: const Color(0xff626262)),
                    ),
                    heightBox8,
                    TextFormField(
                      controller: quantityCtrl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'add_product.error_messages.enter_item_quantity'.tr; // Localized "Enter item quantity"
                        }
                        if (int.tryParse(value) == null || int.parse(value) <= 0) {
                          return 'add_product.error_messages.invalid_quantity'.tr; // Localized "Enter a valid quantity"
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintStyle: const TextStyle(color: Colors.grey)),
                    ),
                    heightBox8,
                    Text(
                      'add_product.expiry_date_label'.tr, // Localized "Expiry date"
                      style: GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.w400, color: const Color(0xff626262)),
                    ),
                    heightBox8,
                    TextFormField(
                      controller: expiryDateCtrl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.datetime,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'add_product.error_messages.enter_expiry_date'.tr; // Localized "Enter expiry date"
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintStyle: const TextStyle(color: Colors.grey)),
                    ),
                    heightBox12,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 170,
                          child: TextFormField(
                            controller: daysCtrl,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.number,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'add_product.error_messages.enter_days'.tr; // Localized "Enter days"
                              }
                              if (int.tryParse(value) == null || int.parse(value) <= 0) {
                                return 'add_product.error_messages.invalid_days'.tr; // Localized "Enter a valid number of days"
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'add_product.days_label'.tr, // Localized "Days"
                              hintStyle: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 170,
                          child: TextFormField(
                            controller: discountCtrl,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.number,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'add_product.error_messages.enter_discount'.tr; // Localized "Enter discount"
                              }
                              if (int.tryParse(value) == null || int.parse(value) < 0 || int.parse(value) > 100) {
                                return 'add_product.error_messages.invalid_discount'.tr; // Localized "Enter a valid discount (0-100)"
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'add_product.discount_label'.tr, // Localized "Discount %"
                              hintStyle: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                    heightBox12,
                    CustomElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Get.to(() => const MainButtonNavbarScreen());
                        }
                      },
                      text: 'add_product.save_button'.tr, // Localized "Save"
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void clearTextField() {
    nameCtrl.clear();
    detailsCtrl.clear();
    categoryCtrl.clear();
    priceCtrl.clear();
    quantityCtrl.clear();
    expiryDateCtrl.clear();
    daysCtrl.clear();
    discountCtrl.clear();
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    detailsCtrl.dispose();
    categoryCtrl.dispose();
    priceCtrl.dispose();
    quantityCtrl.dispose();
    expiryDateCtrl.dispose();
    daysCtrl.dispose();
    discountCtrl.dispose();
    super.dispose();
  }
}