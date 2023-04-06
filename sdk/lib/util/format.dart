import 'package:sdk/language.dart';
import 'package:sdk/xlocal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:get/get.dart';

class Format {
  static final Format _format = new Format._internal();

  NumberFormat? _percentFixed; //固定格式的百分比,比如10,00%
  NumberFormat? _percentDynamic; //动态格式的百分比,比如10%,19.96%
  NumberFormat? _currency;
  NumberFormat? _currencyDynamic;
  NumberFormat? _numberFixed;
  NumberFormat? _numberDynamic;
  NumberFormat? _int;
  DateFormat? _date;
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  RegExp phoneRegex = RegExp(r"^((\+)33|0|0033)[1-9](\d{2}){4}$");
  RegExp alphanumeric = RegExp(r"^[a-zA-Z0-9_\.+\-\*\/:\{\}\,\?\=]*$");
  DateFormat? _fullTime;
  DateFormat? _shortTime;
  Parser? _expressParser;

  factory Format() {
    return _format;
  }

  Format._internal() {
    appLanguge.addLocal(_XLocal());
    _percentFixed = NumberFormat('0.00%', 'fr');
    _percentDynamic = NumberFormat('0.##%', 'fr');
    _currency = NumberFormat('0.00€', 'fr');
    _currencyDynamic = NumberFormat('0.##€', 'fr');
    _numberFixed = NumberFormat('0.00', 'fr');
    _numberDynamic = NumberFormat('0.###', 'fr');
    _int = NumberFormat('##', 'fr');
    _date = DateFormat('dd/MM/yyyy', 'fr');
    _shortTime = DateFormat('HH:mm:ss', 'fr');
    _fullTime = DateFormat('dd/MM/yyyy HH:mm:ss', 'fr');
    _expressParser = Parser();
  }

  String weekDay(int day) {
    switch (day) {
      case 1:
        return 'format_monday'.tr;
      case 2:
        return 'format_tuesday'.tr;
      case 3:
        return 'format_wednesday'.tr;
      case 4:
        return 'format_thursday'.tr;
      case 5:
        return 'format_friday'.tr;
      case 6:
        return 'format_saturday'.tr;
      case 7:
        return 'format_sunday'.tr;
      default:
        return '';
    }
  }

  TimeOfDay? toTimeOfDay(String time) {
    try {
      var tmp = time.split(':');
      if (tmp.length == 1) {
        return TimeOfDay(hour: int.parse(tmp[0]), minute: 0);
      } else if (tmp.length == 2) {
        return TimeOfDay(hour: int.parse(tmp[0]), minute: int.parse(tmp[1]));
      } else {
        return null;
      }
    } catch (ex) {
      return null;
    }
  }

  String timeOfDayFormat(TimeOfDay day) {
    var format = NumberFormat('00', 'fr');
    return "${format.format(day.hour)}:${format.format(day.minute)}";
  }

  bool isAlphanumeric(String? text) {
    if (text == null) return false;
    return alphanumeric.hasMatch(text);
  }

  String currency(number, {bool isFixed = true, String nullValue = ""}) {
    if (number != null) {
      if (isFixed) {
        return _currency!.format(number);
      } else {
        return _currencyDynamic!.format(number);
      }
    } else {
      return nullValue;
    }
  }

  bool verifyPhone(String phone) {
    return phoneRegex.hasMatch(phone);
  }

  String distance(double distance) {
    if (distance >= 1000) {
      return "${distance / 1000}km";
    } else {
      return '${distance}m';
    }
  }

  String? yearOfDate(date) {
    DateTime? dt;
    if (date is String) {
      try {
        dt = DateTime.parse(date).toLocal();
      } catch (ex) {
        return "";
      }
    } else if (date is DateTime) {
      dt = date;
    }
    return dt?.year.toString();
  }

  String? monthOfDate(date) {
    DateTime? dt;
    if (date is String) {
      try {
        dt = DateTime.parse(date).toLocal();
      } catch (ex) {
        return "";
      }
    } else if (date is DateTime) {
      dt = date;
    }
    return dt?.month.toString();
  }

  String? dayOfDate(date) {
    DateTime? dt;
    if (date is String) {
      try {
        dt = DateTime.parse(date).toLocal();
      } catch (ex) {
        return "";
      }
    } else if (date is DateTime) {
      dt = date;
    }
    return dt?.day.toString();
  }

  String intlDate(DateTime date) {
    return _dateFormat.format(date);
  }

  String? date(date) {
    DateTime? dt;
    if (date is String) {
      try {
        dt = DateTime.parse(date).toLocal();
      } catch (ex) {
        return "";
      }
    } else if (date is DateTime) {
      dt = date;
    }
    if (date != null) {
      return _date?.format(dt!);
    } else {
      return 'null';
    }
  }

  String? shortTime(date) {
    DateTime? dt;
    if (date is String) {
      try {
        dt = DateTime.parse(date).toLocal();
      } catch (ex) {
        return "";
      }
    } else if (date is DateTime) {
      dt = date;
    }
    if (date != null) {
      return _shortTime?.format(dt!);
    } else {
      return 'null';
    }
  }

  String duration(Duration duration) {
    if (duration.inDays > 1) {
      return '${duration.inDays} ${'format_days'.tr}';
    } else if (duration.inHours > 1) {
      return '${duration.inHours} ${'format_hours'.tr}';
    } else if (duration.inMinutes > 1) {
      return '${duration.inMinutes} ${'format_minutes'.tr}';
    } else {
      return "0 minute";
    }
  }

  String? fullTimeExceptToday(date) {
    DateTime? dt;
    if (date is String) {
      try {
        dt = DateTime.parse(date).toLocal();
      } catch (ex) {
        return "";
      }
    } else if (date is DateTime) {
      dt = date;
    }
    if (dt != null) {
      if (this.date(dt) == this.date(DateTime.now())) {
        return shortTime(dt);
      }
      return _fullTime?.format(dt);
    } else {
      return 'null';
    }
  }

  String? fullTime(date) {
    DateTime? dt;
    if (date is String) {
      try {
        dt = DateTime.parse(date).toLocal();
      } catch (ex) {
        return "";
      }
    } else if (date is DateTime) {
      dt = date;
    }
    if (dt != null) {
      return _fullTime?.format(dt);
    } else {
      return 'null';
    }
  }

  String fileSize(double size) {
    size = size / 1024;
    if (size <= 1024) {
      return '${number(size, isFixed: true)!}K';
    } else {
      size = size / 1024;
      if (size <= 1024) {
        return "${number(size, isFixed: true)!}M";
      } else {
        size = size / 1024;
        return '${number(size, isFixed: true)!}G';
      }
    }
  }

  String? number(number, {bool isFixed = false, String nullValue = ""}) {
    if (number != null) {
      if (isFixed) {
        return _numberFixed?.format(number);
      } else {
        return _numberDynamic?.format(number);
      }
    } else {
      return nullValue;
    }
  }

  String? intString(number) {
    if (number != null) {
      return _int?.format(number);
    } else {
      return 'null';
    }
  }

  String get decimalSymbol => ',';

  String? percent(number, {bool isFixed = true, bool withSymbol = true}) {
    if (number != null) {
      if (withSymbol) {
        if (isFixed) {
          return _percentFixed?.format(number);
        } else {
          return _percentDynamic?.format(number);
        }
      } else {
        return _numberDynamic?.format(number * 100);
      }
    } else {
      return 'null';
    }
  }

  double? toNumber(String? source) {
    if (source == null) {
      return 0;
    } else {
      var exp = num.parse(source.replaceAll(decimalSymbol, '.'));
      return exp.toDouble();
      //return double.tryParse(source.replaceAll(decimalSymbol, '.'));
    }
  }

  double? parse(String? source) {
    if (source == null) {
      return 0;
    } else {
      var exp = _expressParser?.parse(source.replaceAll(decimalSymbol, '.'));
      ContextModel cm = new ContextModel();
      return exp?.evaluate(EvaluationType.REAL, cm);
      //return double.tryParse(source.replaceAll(decimalSymbol, '.'));
    }
  }

  Color calculateTextColor(Color background) {
    return background.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }

  Color getColorFromHex(String hexColor, {Color defaultColor: Colors.white}) {
    if (hexColor == null) {
      return defaultColor;
    }
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    } else {
      return defaultColor;
    }
  }
}

Format format = Format();

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue? oldValue, TextEditingValue? newValue) {
    return TextEditingValue(
      text: newValue!.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class _XLocal extends XBaseLocal {
  final _dict = {
    AppLanguge.en: {
      'format_monday': 'Monday',
      'format_tuesday': 'Tuesday',
      'format_wednesday': 'Wednesday',
      'format_thursday': 'Thursday',
      'format_friday': 'Friday',
      'format_saturday': 'Saturday',
      'format_sunday': 'Sunday',
      'format_days': 'Days',
      'format_hours': 'Hours',
      'format_minuts': 'Minuts',
    },
    AppLanguge.fr: {
      'format_monday': 'Lundi',
      'format_tuesday': 'Mardi',
      'format_wednesday': 'Mecredi',
      'format_thursday': 'Jeudi',
      'format_friday': 'Vendredi',
      'format_saturday': 'Samedi',
      'format_sunday': 'Dimanche',
      'format_days': 'Jours',
      'format_hours': 'Heures',
      'format_minuts': 'Minutes',
    },
    AppLanguge.zh: {
      'format_monday': '周一',
      'format_tuesday': '周二',
      'format_wednesday': '周三',
      'format_thursday': '周四',
      'format_friday': '周五',
      'format_saturday': '周六',
      'format_sunday': '周日',
      'format_days': '天',
      'format_hours': '小时',
      'format_minuts': '分',
    },
    AppLanguge.ko: {
      'format_monday': 'Monday',
      'format_tuesday': 'Tuesday',
      'format_wednesday': 'Wednesday',
      'format_thursday': 'Thursday',
      'format_friday': 'Friday',
      'format_saturday': 'Saturday',
      'format_sunday': 'Sunday',
      'format_days': 'Days',
      'format_hours': 'Hours',
      'format_minuts': 'Minuts',
    }
  };
  Map<String, Map<String, String>> get keys => _dict;

  @override
  // TODO: implement name
  String get name => 'format_';
}
