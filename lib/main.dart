import 'package:expriy_deals/app/modules/common/controllers/translator_controller.dart';
import 'package:expriy_deals/app/modules/common/controllers/translator_services.dart';
import 'package:expriy_deals/app/modules/common/views/main_bottom_nav_bar.dart';
import 'package:expriy_deals/app/modules/onboarding/views/onboarding_screen.dart';
import 'package:expriy_deals/app_binding.dart';
import 'package:expriy_deals/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  runApp(ExpriyDeals());
}

class ExpriyDeals extends StatelessWidget {
  ExpriyDeals({super.key});

  final TranslationsService translations = TranslationsService();

  @override
  Widget build(BuildContext context) {
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
                translations: translations,
                locale: Get.put(TranslationController()).locale.value,
                fallbackLocale: const Locale('en', 'US'),
                theme: ThemeData(
                  scaffoldBackgroundColor: Colors.white,
                  primaryColor: Color(0xffA57EA5).withOpacity(0.1),
                  inputDecorationTheme: inputDecoration(),
                  useMaterial3: true,
                  fontFamily: 'Poppins',
                  textTheme: TextTheme(),
                ),
                home: StorageUtil.getData(StorageUtil.userAccessToken) != null
                    ? MainButtonNavbarScreen()
                    : OnboardingScreen(),
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
  return InputDecorationTheme(
    hintStyle: const TextStyle(fontWeight: FontWeight.w300),
    fillColor: Colors.transparent,
    filled: true,
    border: inputBorder(),
    enabledBorder: inputBorder(),
    focusedBorder: inputBorder(),
    errorBorder: inputBorder(),
  );
}

OutlineInputBorder inputBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide(color: const Color(0xffCACACA), width: 1),
    borderRadius: BorderRadius.circular(14),
  );
}