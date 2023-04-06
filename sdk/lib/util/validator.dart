import 'package:sdk/language.dart';
import 'package:sdk/xlocal.dart';
import 'package:get/get.dart';

class Validator {
  static final Validator _instance = Validator._internal();

  factory Validator() {
    return _instance;
  }

  Validator._internal() {
    appLanguge.addLocal(_XLocal());
  }

  String? notEmpty(String? string) {
    if (string == "" || string == null) {
      return 'util_validator_must_input'.tr; //"Le champ ne peut pas etre vide";
    } else {
      return null;
    }
  }

  static RegExp postcodeRegex = RegExp(r"^(([0-8][0-9])|(9[0-5]))[0-9]{3}$");
  String? isPostcode(String? string, {bool canEmpty = false}) {
    String? r;
    if (string == null || string.isEmpty) return null;
    if (r == null) {
      if (postcodeRegex.hasMatch(string)) {
        return null;
      } else {
        return 'util_validator_postcode_format_incorrect'.tr; //"Le format de C.P. n\'est pas correcte";
      }
    } else {
      return r;
    }
  }

  String? isPostcodeNotEmpty(String? string) {
    String? r;

    r = notEmpty(string);

    if (r == null) {
      if (postcodeRegex.hasMatch(string!) == true) {
        return null;
      } else {
        return 'util_validator_postcode_format_incorrect'.tr; //"Le format de C.P. n\'est pas correcte";
      }
    } else {
      return r;
    }
  }

  String? isEmail(String? string, {bool canEmpty = false}) {
    String? r;
    if (string == null || string.isEmpty) return null;
    if (r == null) {
      if (!GetUtils.isEmail(string)) {
        return 'util_validator_email_format_incorrect';
      } else {
        return null;
      }
    } else {
      return r;
    }
  }

  String? isEmailNotEmpty(String? string) {
    String? r;

    r = notEmpty(string);

    if (r == null) {
      if (!GetUtils.isEmail(string!)) {
        return 'util_validator_email_format_incorrect';
      } else {
        return null;
      }
    } else {
      return r;
    }
  }

  String? isNumeric(String? string) {
    String? r;
    if (string == null || string.isEmpty) return null;
    if (r == null) {
      if (!GetUtils.isNumericOnly(string)) {
        return 'util_validator_num_format_incorrect';
      } else {
        return null;
      }
    } else {
      return r;
    }
  }

  String? isNumericNotEmpty(String? string) {
    String? r;
    r = notEmpty(string);

    if (r == null) {
      if (!GetUtils.isNumericOnly(string!)) {
        return 'util_validator_num_format_incorrect';
      } else {
        return null;
      }
    } else {
      return r;
    }
  }

  String? isNum(String? string) {
    String? r;
    if (string == null || string.isEmpty) return null;
    if (r == null) {
      if (!GetUtils.isNum(string)) {
        return 'util_validator_num_format_incorrect';
      } else {
        return null;
      }
    } else {
      return r;
    }
  }

  String? isNumNotEmpty(String? string) {
    String? r;
    r = notEmpty(string);

    if (r == null) {
      if (!GetUtils.isNumericOnly(string!)) {
        return 'util_validator_postcode_format_incorrect';
      } else {
        return null;
      }
    } else {
      return r;
    }
  }

  String? isPhone(String? string, {bool canEmpty = false}) {
    String? r;
    if (string == null || string.isEmpty) return null;
    if (r == null) {
      if (!GetUtils.isPhoneNumber(string)) {
        return 'util_validator_phone_format_incorrect';
      } else {
        return null;
      }
    } else {
      return r;
    }
  }

  String? isPhoneNotEmpty(String? string) {
    String? r;

    r = notEmpty(string);

    if (r == null) {
      if (!GetUtils.isPhoneNumber(string!)) {
        return 'util_validator_phone_format_incorrect';
      } else {
        return null;
      }
    } else {
      return r;
    }
  }
}

class _XLocal extends XBaseLocal {
  final _dict = {
    AppLanguge.en: {
      'util_validator_postcode_format_incorrect': 'Incorrect',
      'util_validator_must_input': 'Can\'t empty',
    },
    AppLanguge.fr: {
      'util_validator_postcode_format_incorrect': 'Incorrect',
      'util_validator_must_input': 'Obligatoire',
    },
    AppLanguge.zh: {
      'util_validator_postcode_format_incorrect': '不正确',
      'util_validator_must_input': '不能为空',
    },
    AppLanguge.ko: {
      'util_validator_postcode_format_incorrect': 'Incorrect',
      'util_validator_must_input': 'Can\'t empty',
    }
  };
  Map<String, Map<String, String>> get keys => _dict;

  @override
  // TODO: implement name
  String get name => 'util_validator_';
}
