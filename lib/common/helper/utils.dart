import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../utils/constants/colors.dart';
import '../constants/endpoints.dart';

class Utils {
  static void removeSnackBar(BuildContext context) {
    return ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    BuildContext context, {
    required String content,
    Color? backgroundColor,
    SnackBarAction? action,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration ?? const Duration(seconds: 7),
        padding: const EdgeInsets.all(18),
        margin: const EdgeInsets.all(8),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: backgroundColor ?? ConstantColors.kPrimaryColor.withOpacity(1),
        content: Text(
          content,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Colors.white,
              ),
        ),
        action: action,
      ),
    );
  }

  static Future<String> uploadFile(File file, String token) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(EndPoints.uplaodImageUrl));
      // request.fields['key1'] = 'value1'; // Add form fields
      // request.fields['key2'] = 'value2';
      request.headers['authorization'] = "Bearer $token";
      // Add files
      request.files.add(
        await http.MultipartFile.fromPath(
          'file', // The field name for the file
          file.path, // Path to the file on your device
        ),
      );
      var response = await request.send();
      var url = (jsonDecode(await response.stream.bytesToString()))['data'][0]['Location'];
      return url;
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> uploadRx(String? endpoint, File file, String token, String email, String name) async {
    try {
      String newUrl = endpoint ?? EndPoints.uplaodImageUrl;
      var request = http.MultipartRequest('POST', Uri.parse(newUrl));
      request.fields['name'] = name; // Add form fields
      request.fields['email'] = email;
      request.headers['authorization'] = "Bearer $token";
      // Add files
      request.files.add(
        await http.MultipartFile.fromPath(
          'file', // The field name for the file
          file.path, // Path to the file on your device
        ),
      );
      var response = await request.send();
      var url = (jsonDecode(await response.stream.bytesToString()))['data'][0]['Location'];
      return url;
    } catch (e) {
      rethrow;
    }
  }
}
