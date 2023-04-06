import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk/xlocal.dart';

class AppLanguge extends Translations {
  static List<String> supportedLanguages = ['en', 'fr', 'zh', 'ko', 'ja'];
  // 支持的Locales列表
  static Iterable<Locale> supportedLocales() => supportedLanguages.map<Locale>((lang) => Locale(lang, ''));
  static const String en = 'en_US';
  static const String fr = 'fr_FR';
  static const String zh = 'zh';
  static const String ko = 'ko';
  static const String ja = 'ja';
  static Map<String, Map<String, String>> _dict = {
    en: {
      'dialog_yes': 'Yes',
      'dialog_no': 'No',
      'dialog_OK': 'OK',
      'dialog_pick_color': 'Pick color',
    },
    fr: {
      'dialog_yes': 'Oui',
      'dialog_no': 'Non',
      'dialog_OK': 'OK',
      'dialog_pick_color': 'Choisir couleur',
    },
    zh: {
      'dialog_yes': '是',
      'dialog_no': '否',
      'dialog_OK': '确认',
      'dialog_pick_color': '选择颜色',
    },
    ko: {
      'dialog_yes': 'Yes',
      'dialog_no': 'No',
      'dialog_OK': 'OK',
      'dialog_pick_color': 'Pick color',
    },
    ja: {
      'dialog_yes': 'Yes',
      'dialog_no': 'No',
      'dialog_OK': 'OK',
      'dialog_pick_color': 'Pick color',
    }
  };
  Map<String, XBaseLocal> locals = {};
  addLocal(XBaseLocal local) {
    if (!locals.containsKey(local.name)) {
      locals[local.name] = local;
      for (var key in local.keys.keys) {
        if (_dict[key] != null) {
          _dict[key]?.addAll(local.keys[key]!);
        }
      }
    }
  }

  Map<String, Map<String, String>> get keys => _dict;
}

AppLanguge appLanguge = AppLanguge();
