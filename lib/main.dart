import 'package:expriy_deals/app/modules/common/controllers/translator_services.dart';
import 'package:expriy_deals/app/modules/common/views/main_bottom_nav_bar.dart';
import 'package:expriy_deals/app/modules/onboarding/views/onboarding_screen.dart';
import 'package:expriy_deals/app/utils/get_storage.dart';
import 'package:expriy_deals/app_binding.dart';
import 'package:expriy_deals/get_storage.dart';
import 'package:expriy_deals/translator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  await requestStoragePermission(); // Request storage permission
  Get.testMode = true; // Enable for debugging
  runApp(const ExpriyDeals());
}

Future<void> requestStoragePermission() async {
  if (await Permission.storage.request().isGranted) {
    print("Storage permission granted");
  } else {
    print("Storage permission denied");
  }
}

class ExpriyDeals extends StatelessWidget {
  const ExpriyDeals({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = TranslationsService();
    String langCode = box.read('language_code') ?? 'en'; // Default to English
    String countryCode = box.read('country_code') ?? 'US'; // Default to US
    return FutureBuilder(
      future: translations.loadTranslations(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ScreenUtilInit(
            designSize: const Size(393, 852),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return GetMaterialApp(
                initialBinding: ControllerBinder(),
                debugShowCheckedModeBanner: false,
                title: 'expriy-deals',
                translations: AppTranslations(),
                locale: Locale(langCode, countryCode), // Default: English
                fallbackLocale: const Locale('en', 'US'), // Fallback to English
                theme: ThemeData(
                  scaffoldBackgroundColor: Colors.white,
                  primaryColor: const Color(0xffA57EA5).withOpacity(0.1),
                  inputDecorationTheme: inputDecoration(),
                  useMaterial3: true,
                  fontFamily: 'Poppins',
                  textTheme: const TextTheme(),
                ),
                home: StorageUtil.getData(StorageUtil.userAccessToken) != null
                    ? const MainButtonNavbarScreen()
                    : const OnboardingScreen(),
              );
            },
          );
        }
        return const MaterialApp(
          home: Scaffold(body: Center(child: CircularProgressIndicator())),
        );
      },
    );
  }
}

InputDecorationTheme inputDecoration() {
  return const InputDecorationTheme(
    hintStyle: TextStyle(fontWeight: FontWeight.w300),
    fillColor: Colors.transparent,
    filled: true,
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffCACACA), width: 1),
      borderRadius: BorderRadius.all(Radius.circular(14)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffCACACA), width: 1),
      borderRadius: BorderRadius.all(Radius.circular(14)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffCACACA), width: 1), // Fixed typo: 0ffCACACA -> 0xffCACACA
      borderRadius: BorderRadius.all(Radius.circular(14)),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffCACACA), width: 1),
      borderRadius: BorderRadius.all(Radius.circular(14)),
    ),
  );
}