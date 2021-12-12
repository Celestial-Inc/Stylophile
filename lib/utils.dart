import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:Stylophile/outfit.dart';
import 'package:flutter_simple_image_utils/flutter_simple_image_utils.dart';

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 12, kToday.day);
final today = DateTime(kToday.year, kToday.month, kToday.day);
final tomorrow = DateTime(kToday.year, kToday.month, kToday.day + 1);

Future<void> initializeHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(OutfitAdapter());

  await Hive.openBox('shirts');
  await Hive.openBox('bottoms');
  await Hive.openBox('shoes');
  await Hive.openBox('calendar');

  Box shirtsBox = Hive.box('shirts');
  if (shirtsBox.isEmpty) {
    shirtsBox.put('shirt1',
        await convertImageAssetToString('assets/images/noClothes.png'));
  }

  Box bottomsBox = Hive.box('bottoms');
  if (bottomsBox.isEmpty) {
    bottomsBox.put('bottoms1',
        await convertImageAssetToString('assets/images/noClothes.png'));
  }

  Box shoesBox = Hive.box('shoes');
  if (shoesBox.isEmpty) {
    shoesBox.put('shoes1',
        await convertImageAssetToString('assets/images/noClothes.png'));
  }
}

String createCalendarKey(DateTime date) {
  return date.year.toString() +
      '-' +
      date.month.toString() +
      '-' +
      date.day.toString();
}
