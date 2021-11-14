import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:virtual_closet/outfit.dart';

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
  await Hive.openBox('outfits');
  await Hive.openBox('calendar');

  Box shirtsBox = Hive.box('shirts');
  if (shirtsBox.isEmpty) {
    shirtsBox.put('shirt1', await convertImageToString('assets/images/shirt01.jpg'));
    shirtsBox.put('shirt2', await convertImageToString('assets/images/shirt02.jpg'));
    shirtsBox.put('shirt3', await convertImageToString('assets/images/shirt03.jpg'));
  }

  Box bottomsBox = Hive.box('bottoms');
  if (bottomsBox.isEmpty) {
    bottomsBox.put('bottoms1', await convertImageToString('assets/images/pants01.jpg'));
    bottomsBox.put('bottoms2', await convertImageToString('assets/images/pants02.jpeg'));
    bottomsBox.put('bottoms3', await convertImageToString('assets/images/pants03.jpg'));
  }

  Box shoesBox = Hive.box('shoes');
  if (shoesBox.isEmpty) {
    shoesBox.put('shoes1', await convertImageToString('assets/images/shoes01.jpg'));
    shoesBox.put('shoes2', await convertImageToString('assets/images/shoes02.png'));
    shoesBox.put('shoes3', await convertImageToString('assets/images/shoes03.jpg'));
  }
  Box outfitsBox = Hive.box('outfits');
  Outfit outfit1 = Outfit('shirt1', 'bottoms2', 'shoes3');
  Outfit outfit2 = Outfit('shirt3', 'bottoms1', 'shoes3');
  if (outfitsBox.isEmpty) {
    outfitsBox.put('outfit1', outfit1);
    outfitsBox.put('outfit2', outfit2);
  }
  Box calendarBox = Hive.box('calendar');
  if (calendarBox.isEmpty) {
    calendarBox.put(createCalendarKey(today), [outfit2]);
    calendarBox.put(createCalendarKey(tomorrow), [outfit1, outfit2]);
  }
}

String createCalendarKey(DateTime date) {
  return date.year.toString() + '-' + date.month.toString() + '-' + date.day.toString();
}

Future<String> convertImageToString(String imagePath) async {
  ByteData bytes = await rootBundle.load(imagePath);
  var buffer = bytes.buffer;
  return base64.encode(Uint8List.view(buffer));
}
