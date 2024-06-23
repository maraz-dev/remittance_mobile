import 'dart:io';

import 'package:image_picker/image_picker.dart';

/// Select/Upload an Image from Device Gallery
Future<File> pickImageFromGallery() async {
  final returnImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
  if (returnImage == null) return File('');
  File imagePath = File(returnImage.path);
  return imagePath;
}

/// Select/Upload an Image Using Device Camera
Future<File> pickImageFromCamera() async {
  final returnImage = await ImagePicker().pickImage(source: ImageSource.camera);
  if (returnImage == null) return File('');
  File imagePath = File(returnImage.path);
  return imagePath;
}
