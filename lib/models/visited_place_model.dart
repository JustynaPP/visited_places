import 'dart:io';

import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final dateFormater = DateFormat.yMMMd();

class VisitedPlace {
  VisitedPlace({
    required this.title,
    required this.date,
    required this.image,
    String? id,
  }) : id = id ?? uuid.v4();

  final String id;
  final String title;
  final DateTime date;
  final File image;

  String get formattedDate {
    return dateFormater.format(date);
  }
}
