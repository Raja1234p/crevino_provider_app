import 'package:flutter/material.dart';
import 'package:handyman_provider_flutter/locale/base_language.dart';
import 'package:handyman_provider_flutter/locale/language_ar.dart';
import 'package:handyman_provider_flutter/locale/language_de.dart';
import 'package:handyman_provider_flutter/locale/language_en.dart';
import 'package:handyman_provider_flutter/locale/language_fr.dart';
import 'package:handyman_provider_flutter/locale/language_hi.dart';
import 'package:nb_utils/nb_utils.dart';

import 'language_br.dart';

class AppLocalizations extends LocalizationsDelegate<Languages> {
  const AppLocalizations();

  @override
  Future<Languages> load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguageEn();
      case 'hi':
        return LanguageHi();
      case 'ar':
        return LanguageAr();
      case 'de':
        return LanguageDe();
      case 'fr':
        return LanguageFr();
      case 'pt':
        return LanguageBr();
      default:
        return LanguageEn();
    }
  }

  @override
  bool isSupported(Locale locale) => LanguageDataModel.languages().contains(locale.languageCode);

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}
