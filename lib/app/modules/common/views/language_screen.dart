import 'package:expriy_deals/app/modules/common/controllers/translator_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    final TranslationController controller = Get.put(TranslationController());

    return Scaffold(
      appBar: AppBar(title: Text('app_title'.tr)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('greeting'.tr, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            Text('description'.tr, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 40),
            const Text('Select Language:', style: TextStyle(fontSize: 18)),
            Obx(() => DropdownButton<String>(
                  value: controller.locale.value.languageCode,
                  items: [
                    DropdownMenuItem(value: 'en', child: Text('english'.tr)),
                    DropdownMenuItem(value: 'es', child: Text('spanish'.tr)),
                    DropdownMenuItem(value: 'hi', child: Text('hindi'.tr)),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      switch (value) {
                        case 'en':
                          controller.changeLanguage('en', 'US');
                          break;
                        case 'es':
                          controller.changeLanguage('es', 'ES');
                          break;
                        case 'hi':
                          controller.changeLanguage('hi', 'IN');
                          break;
                      }
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}