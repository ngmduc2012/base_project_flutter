import 'package:flutter/material.dart';

import '../../app/data/services/localization.dart';
import '../values/languages/translations.dart';

abstract class TimeHelper {
  static String get timeZoneOffset {
    final _ = DateTime.now().toLocal().timeZoneOffset;
    int hour = (_.inMinutes / 60).floor();
    int minute = _.inMinutes % 60;
    return "${_.isNegative ? "-" : "+"}${toText(hour, minute)}";
  }

  static String toDurationText(int hour, int minute) {
    final langCode = LocalizationService.to.locale.value.languageCode;
    List<String> strings = [];
    if (hour > 0) {
      if (hour > 1 && langCode == 'en') {
        strings.add("$hour ${AppTranslations.h}s");
      } else {
        strings.add("$hour ${AppTranslations.h}");
      }
    }
    if (minute > 0 || hour == 0) {
      if (minute > 1 && langCode == 'en') {
        strings.add("$minute ${AppTranslations.m}s");
      } else {
        strings.add("$minute ${AppTranslations.m}");
      }
    }
    return strings.join(", ");
  }

  static String toDurationTextByDuration(Duration duration) {
    int hour = (duration.inMinutes / 60).floor();
    int minute = duration.inMinutes % 60;
    return toDurationText(hour, minute);
  }

  static String toText(int? hour, int? minute) {
    return "${twoDigit(hour)}:${twoDigit(minute)}";
  }

  static String twoDigit(int? digit) {
    if (digit == null) {
      return "";
    }
    if (digit.abs() < 10) {
      return "0${digit.abs()}";
    } else
      return "${digit.abs()}";
  }

  static DateTime toDate(TimeOfDay timeOfDay, DateTime day) {
    return DateTime(
        day.year, day.month, day.day, timeOfDay.hour, timeOfDay.minute);
  }
}
