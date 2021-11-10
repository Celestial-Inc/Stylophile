import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'outfit.g.dart';

@HiveType(typeId: 0)
class Outfit {
  @HiveField(0)
  String top;

  @HiveField(1)
  String bottom;

  @HiveField(2)
  String shoe;

  Outfit(this.top, this.bottom, this.shoe);
}
