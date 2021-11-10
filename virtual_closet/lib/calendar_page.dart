import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:hive/hive.dart';
import 'package:virtual_closet/utils.dart';
import 'dart:convert';

import 'outfit.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late final ValueNotifier<List<Outfit>> _selectedEvents;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Outfit> _getEventsForDay(DateTime day) {
    // Implementation example
    List<String> allOutfitNames = kEvents[day] ?? [];
    Box outfitsBox = Hive.box('outfits');
    List<Outfit> allOutfits = [];
    // loop over all out names
    for (var x = 0; x < allOutfitNames.length; x++) {
      // for-each outfit name, look up the outfit in Hive
      String outfitName = allOutfitNames.elementAt(x);
      Outfit outfit = outfitsBox.get(outfitName);
      // add the outfit from hive into the allOutfits list
      allOutfits.add(outfit);
    }

    return allOutfits;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  List<Widget> getOutfitImages(Outfit myOutfit) {
    Box shirtsBox = Hive.box('shirts');
    Box bottomsBox = Hive.box('bottoms');
    Box shoesBox = Hive.box('shoes');

    String shirtImageAsString = shirtsBox.get(myOutfit.top);
    String bottomImageAsString = bottomsBox.get(myOutfit.bottom);
    String shoesImageAsString = shoesBox.get(myOutfit.shoe);

    return [
      Image.memory(base64Decode(shirtImageAsString), fit: BoxFit.cover),
      Image.memory(base64Decode(bottomImageAsString), fit: BoxFit.cover),
      Image.memory(base64Decode(shoesImageAsString), fit: BoxFit.cover)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        TableCalendar(
          firstDay: kFirstDay,
          lastDay: kLastDay,
          focusedDay: _focusedDay,
          calendarFormat: CalendarFormat.month,
          eventLoader: _getEventsForDay,
          selectedDayPredicate: (day) {
            // Use `selectedDayPredicate` to determine which day is currently selected.
            // If this returns true, then `day` will be marked as selected.

            // Using `isSameDay` is recommended to disregard
            // the time-part of compared DateTime objects.
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: _onDaySelected,
          onPageChanged: (focusedDay) {
            // No need to call `setState()` here
            _focusedDay = focusedDay;
          },
        ),
        const SizedBox(height: 8.0),
        Expanded(
          child: ValueListenableBuilder<List<Outfit>>(
            valueListenable: _selectedEvents,
            builder: (context, value, _) {
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: getOutfitImages(value[index]),
                  );
                },
              );
            },
          ),
        )
      ]),
    );
  }
}
