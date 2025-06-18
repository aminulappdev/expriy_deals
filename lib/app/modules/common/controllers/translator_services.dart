import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';

class TranslationsService extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {};

  Future<void> loadTranslations() async {
    final enJson = await rootBundle.loadString('assets/translations/en.json');
    final esJson = await rootBundle.loadString('assets/translations/es.json');
    final hiJson = await rootBundle.loadString('assets/translations/hi.json');

    keys.addAll({
      'en_US': json.decode(enJson) as Map<String, String>,
      'es_ES': json.decode(esJson) as Map<String, String>,
      'hi_IN': json.decode(hiJson) as Map<String, String>,
    });
  }
}