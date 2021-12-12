import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:hive/hive.dart';
import 'package:Stylophile/utils.dart';
import 'dart:convert';

import 'outfit.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late final ValueNotifier<List<dynamic>> _selectedEvents;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  bool _forceRefresh = false;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getOutfitsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<dynamic> _getOutfitsForDay(DateTime date) {
    var box = Hive.box('calendar');
    var outfitList = box.get(createCalendarKey(date));
    if (outfitList == null) {
      return [];
    } else {
      return outfitList;
    }
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getOutfitsForDay(selectedDay);
    }
  }

  List<Widget> getOutfitImages(Outfit myOutfit) {
    Box shirtsBox = Hive.box('shirts');
    Box bottomsBox = Hive.box('bottoms');
    Box shoesBox = Hive.box('shoes');

    String? shirtImageAsString = shirtsBox.get(myOutfit.top);
    String? bottomImageAsString = bottomsBox.get(myOutfit.bottom);
    String? shoesImageAsString = shoesBox.get(myOutfit.shoe);

    return [
      tryToMakeImage(shirtImageAsString),
      tryToMakeImage(bottomImageAsString),
      tryToMakeImage(shoesImageAsString),
      makeDeleteButton(myOutfit)
    ];
  }

  Widget makeDeleteButton(Outfit myOutfit) {
    Icon trashIcon = const Icon(
      FontAwesomeIcons.trashAlt,
      size: 60.0,
      color: Colors.purple,
    );
    return IconButton(
      icon: trashIcon,
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Warning!'),
          content: const Text('Do you wish to delete this Outfit?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => {Navigator.pop(context, 'No')},
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'Yes');
                var box = Hive.box('calendar');
                List<dynamic> outfitList =
                    box.get(createCalendarKey(_selectedDay!));
                outfitList.remove(myOutfit);
                box.put(createCalendarKey(_selectedDay!), outfitList);
                setState(() {
                  // set forceRefresh to the opposite of whatever it is. It just flips between true and false.
                  _forceRefresh = !_forceRefresh;
                });
              },
              child: const Text('Yes'),
            ),
          ],
        ),
      ),
    );
  }

  Widget tryToMakeImage(String? base64ImageString) {
    if (base64ImageString == null) {
      return Text('Missing', style: TextStyle(fontSize: 40));
    }
    return Image.memory(base64Decode(base64ImageString), fit: BoxFit.cover);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(children: [
        TableCalendar(
          firstDay: kFirstDay,
          lastDay: kLastDay,
          focusedDay: _focusedDay,
          calendarFormat: CalendarFormat.month,
          eventLoader: _getOutfitsForDay,
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
          child: ValueListenableBuilder<List<dynamic>>(
            valueListenable: _selectedEvents,
            builder: (context, value, _) {
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  return CarouselSlider(
                    items: getOutfitImages(value[index]),
                    options: CarouselOptions(
                        autoPlay: true, autoPlayInterval: Duration(seconds: 2)),
                  );
                },
              );
            },
          ),
        )
      ]),
    ));
  }
}
