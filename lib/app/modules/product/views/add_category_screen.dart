import 'package:expriy_deals/app/modules/common/views/main_bottom_nav_bar.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:expriy_deals/app/widgets/costom_app_bar.dart';
import 'package:expriy_deals/app/widgets/gradiant_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameCtrl = TextEditingController();

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
              CustomAppBar(name: 'add_category.app_bar_title'.tr), // Localized "Add category"
              heightBox16,
              Text(
                'add_category.item_name_label'.tr, // Localized "Item Name"
                style: GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.w400, color: const Color(0xff626262)),
              ),
              heightBox8,
              TextFormField(
                controller: nameCtrl,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.text,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'add_category.error_messages.enter_category_name'.tr; // Localized "Enter category name"
                  }
                  return null;
                },
                decoration: InputDecoration(hintStyle: const TextStyle(color: Colors.grey)),
              ),
              heightBox8,
              Text(
                'add_category.upload_image_label'.tr, // Localized "Upload image"
                style: GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.w400, color: const Color(0xff626262)),
              ),
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
                        'add_category.add_product_label'.tr, // Localized "Add category"
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              heightBox8,
              CustomElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Get.to(() => const MainButtonNavbarScreen());
                  }
                },
                text: 'add_category.save_button'.tr, // Localized "Save"
              ),
            ],
          ),
        ),
      ),
    );
  }

  void clearTextField() {
    nameCtrl.clear();
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    super.dispose();
  }
}