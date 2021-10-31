import 'dart:collection';
import 'package:table_calendar/table_calendar.dart';

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 12, kToday.day);
final today = DateTime(kToday.year, kToday.month, kToday.day);
final tomorrow = DateTime(kToday.year, kToday.month, kToday.day + 1);

class Outfit {
  final String top;
  final String bottom;
  final String shoe;

  const Outfit(this.top, this.bottom, this.shoe);
}

const outfit1 = Outfit(
  'assets/images/shirt01.jpg', 'assets/images/pants02.jpeg', 'assets/images/shoes03.jpg'
);
const outfit2 = Outfit(
  'assets/images/shirt03.jpg', 'assets/images/pants01.jpg', 'assets/images/shoes03.jpg'
);

/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Outfit>>(
  equals: isSameDay,
  hashCode: getHashCode,
); 

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

