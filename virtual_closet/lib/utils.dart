import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:hive/hive.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

late Box shirtsBox;

Future<void> initializeHive() async {
  try {
    Directory? dir = await getExternalStorageDirectory();
    Hive.init(dir!.path);
  } catch (e) {
    // do nothing. on web you don't need to initialize
  }

  shirtsBox = await Hive.openBox('shirts');
}

Future<String> convertImageToString(String imagePath) async {
  ByteData bytes = await rootBundle.load(imagePath);
  var buffer = bytes.buffer;
  return base64.encode(Uint8List.view(buffer));
}
