import 'dart:io';

import 'package:Stylophile/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  group('Hive based widget tests', () {
    Box? box;

    setUp(() async {
      final temp = await Directory.systemTemp.createTemp();
      Hive.init(temp.path);
      box = await Hive.openBox('calendar');
      await box?.clear();
    });

    tearDown(() async {
      await box?.deleteFromDisk();
    });

    testWidgets('Test calendar widget 2 Weeks button visibility', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      await tester.tap(find.byIcon(Icons.date_range));
      await tester.pump();

      expect(find.byType(TableCalendar), findsOneWidget);
      expect(find.text("2 Weeks"), findsNothing);
    });
  });
}
