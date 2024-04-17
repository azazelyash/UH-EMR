import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeParser {
  DateTimeParser._();

  static String parseDate(String date) {
    // Split the date string into year, month, and day components
    List<String> dateComponents = date.split('-');

    // Extract year, month, and day from the components
    String month = dateComponents[1];
    String day = dateComponents[2];

    // Return the parsed date in the "dd/mm" format
    return '$day/$month';
  }

  static String fetchDateFromUtc(DateTime utcDateTime) {
    // Format the UTC date in dd/MM/yyyy format
    log("Input Date - $utcDateTime");
    return DateFormat('dd/MM/yyyy').format(utcDateTime.toLocal());
  }

  static String fetchTimeFromUtc(DateTime utcDateTime) {
    // Format the UTC time in 12-hour format
    log("Input Time - $utcDateTime");
    return DateFormat('hh:mm a').format(utcDateTime.toLocal());
  }

  static String formatTime(TimeOfDay timeOfDay) {
    // Create a DateTime object with today's date and the selected time
    DateTime dateTime = DateTime(1, 1, 1, timeOfDay.hour, timeOfDay.minute);

    // Format the DateTime object to 12-hour format
    return DateFormat.jm().format(dateTime);
  }

  static DateTime convertDateToUtc(String dateTimeString) {
    // Parse the string into a DateTime object
    DateTime dateTime = DateTime.parse(dateTimeString);

    // Convert the DateTime object to UTC
    return dateTime.toUtc();
  }

  static DateTime parseCustomDate(String dateString) {
    List<String> parts = dateString.split('/');

    int day = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int year = int.parse(parts[2]);

    return DateTime(year, month, day);
  }

  static DateTime? constructDateTimeFromString({required String date, required String time}) {
    try {
      // Extract date components
      List<String> dateParts = date.split('/');
      int day = int.parse(dateParts[0]);
      int month = int.parse(dateParts[1]);
      int year = int.parse(dateParts[2]);

      // Extract time components
      List<String> timeParts = time.split(':');
      int hour = int.parse(timeParts[0]);
      int minute = int.parse(timeParts[1].substring(0, 2)); // Remove AM/PM suffix

      // Determine if it's AM or PM
      bool isPM = timeParts[1].substring(2).trim().toUpperCase() == 'PM';

      // Convert hour to 24-hour format if it's PM
      if (isPM && hour < 12) {
        hour += 12;
      }

      // Construct the DateTime object
      return DateTime(year, month, day, hour, minute);
    } catch (e) {
      // Handle parsing errors
      log("Error parsing date or time: $e");
      return null;
    }
  }
}
