import 'package:intl/intl.dart';

bool isAdult(String birthDateString) {
  String datePattern = 'yyyy-MM-dd';
  DateTime today = DateTime.now();

  DateTime birthDate = DateFormat(datePattern).parse(birthDateString);

  DateTime adultDate = DateTime(
    birthDate.year + 18,
    birthDate.month,
    birthDate.day,
  );

  return adultDate.isBefore(today);
}
