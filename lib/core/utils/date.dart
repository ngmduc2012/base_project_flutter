import 'package:flutter/material.dart';
import 'package:quiver/time.dart';
import 'dart:core';
import 'package:intl/intl.dart';

import 'time.dart';

extension DateTimeExtension on DateTime {
  DateTime applyTimeOfDay(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }
}

abstract class DateUtils2 {
  static String twoDigit(int number) {
    return number < 10 ? "0$number" : "$number";
  }

  /// Transmission Time UTC to Time Zone, All of time get from server is UTC,
  /// Transmission them to Time Zone on phone.
  /// Chuyển từ thời gian UTC sang định dạng thời gian của máy, Tất cả thời gian
  /// nhận về từ máy chủ là dạng UTC, cần chuyển đổi chúng thành thời gian trên
  /// thiết bị.
  /// Follow: https://stackoverflow.com/a/65581347/10621168
  static DateTime utcToTimeZone(DateTime dateTime) {
    return dateTime.subtract(
        Duration(microseconds: -DateTime.now().timeZoneOffset.inMicroseconds));
  }

  static DateTime timeZoneToUTC(DateTime dateTime) {
    return dateTime.subtract(
        Duration(microseconds: DateTime.now().timeZoneOffset.inMicroseconds));
  }

  static DateTime mergeTime(DateTime dateTime, String? hour) {
    try {
      return DateTime.parse(
          "${dateTime.year}-${dateTime.month < 10 ? '0${dateTime.month}' : month}-${dateTime.day < 10 ? '0${dateTime.day}' : dateTime.day}T$hour:00.000Z");
    } catch (e) {
      return dateTime;
    }
  }

  static DateTime? createDayTime(int year, int month, int day) {
    return DateTime.tryParse(
        "$year-${twoDigit(month)}-${twoDigit(day)}T00:00:00+00:00");
  }

  static String utcString(DateTime dateTime) {
    return "${dateTime.year}-${twoDigit(dateTime.month)}-${twoDigit(dateTime.day)}T00:00:00+00:00";
  }

  static DateTime create(int year, int month, {int day = 1}) {
    return DateTime.parse(
            "$year-${month < 10 ? '0$month' : month}-${day < 10 ? '0$day' : day}T00:00:00${TimeHelper.timeZoneOffset}")
        .toLocal();
  }

  static DateTime createTimeZ(
      int year, int month, int day, int hour, int minute, int second) {
    return DateTime.parse(
        "$year-${month < 10 ? '0$month' : month}-${day < 10 ? '0$day' : day}T${hour < 10 ? '0$hour' : hour}:${minute < 10 ? '0$minute' : minute}:${second < 10 ? '0$second' : second}Z");
  }

  static DateTime today() {
    var now = DateTime.now().toLocal();
    return DateUtils2.create(now.year, now.month, day: now.day);
  }

  static DateTime month() {
    var now = DateTime.now().toLocal();
    return DateUtils2.create(now.year, now.month);
  }

  static DateTime getPreviousMonth(DateTime dateTime) {
    if (dateTime.month == 1) {
      return create(dateTime.year - 1, 12);
    } else {
      return create(dateTime.year, dateTime.month - 1);
    }
  }

  static DateTime getNextMonth(DateTime dateTime) {
    if (dateTime.month == 12) {
      return create(dateTime.year + 1, 1);
    } else {
      return create(dateTime.year, dateTime.month + 1);
    }
  }

  static DateFormat get monthDayYear =>
      DateFormat.MMMd().addPattern(",").add_y();

  static DateFormat get hourMinute => DateFormat.Hm();
}
