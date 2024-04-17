import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class UserLocalDataSource {
  final ImagePicker imagePicker;

  UserLocalDataSource({required this.imagePicker});

  Future<File> pickImage([PickImageSource imageSource = PickImageSource.gallery]) async {
    try {
      final pickedFile = await imagePicker.pickImage(
        source: imageSource == PickImageSource.gallery ? ImageSource.gallery : ImageSource.camera,
        maxWidth: 1080,
        maxHeight: 1080,
      );

      if (pickedFile == null) throw "No image selected";

      return File(pickedFile.path);
    } on PlatformException catch (e) {
      throw e.message ?? "An error occured";
    } catch (e) {
      rethrow;
    }
  }
}

enum PickImageSource {
  gallery,
  camera,
}
