import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

/// Select/Upload an Image from Device Gallery
Future<File> pickImageFromGallery() async {
  try {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage != null) {
      File imagePath = File(returnImage.path);
      return imagePath;
    } else {
      throw 'An Error Occured';
    }
  } catch (e) {
    throw e.toString();
  }
}

/// Select/Upload an Image Using Device Camera
Future<File> pickImageFromCamera() async {
  try {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage != null) {
      File imagePath = File(returnImage.path);
      return imagePath;
    } else {
      throw 'An Error Occured';
    }
  } catch (e) {
    throw e.toString();
  }
}

/// Select/Upload a File From Target Platform Files
Future<File> pickFileFromPlatform() async {
  try {
    final result = await FilePicker.platform.pickFiles(
      withData: true,
      allowedExtensions: ['pdf', 'png', 'jpg'],
      type: FileType.custom,
    );

    if (result != null) {
      File docFile = File(result.files.single.path ?? '');
      return docFile;
    } else {
      throw 'An Error Occured';
    }
  } catch (e) {
    throw e.toString();
  }
}
