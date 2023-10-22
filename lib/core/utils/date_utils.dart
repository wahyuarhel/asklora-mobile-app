import 'package:intl/intl.dart';

String formatDateTimeAsString(dynamic dateTime,
    {String dateFormat = 'yyyy-MM-dd'}) {
  try {
    if (dateTime is DateTime) {
      return DateFormat(dateFormat).format(dateTime);
    } else {
      return DateFormat(dateFormat).format(DateTime.parse(dateTime));
    }
  } catch (e) {
    return '-';
  }
}

DateTime formatDateTimeToLocal(dynamic dateTime,
    {String dateFormat = 'dd/MM/yyyy HH:mm', bool isUtc = true}) {
  return DateFormat(dateFormat)
      .parse(DateFormat(dateFormat).format(DateTime.parse(dateTime)), isUtc)
      .toLocal();
}

String formatLocalDateTimeToString(String dateTime, {String? dateFormat}) {
  DateTime dt = formatDateTimeToLocal(dateTime);
  return DateFormat(dateFormat ?? 'hh:mm dd/MM/yy').format(dt);
}

DateTime formatDateOnly(dynamic dateTime) {
  DateTime date = DateTime.parse(formatDateTimeAsString(dateTime));
  return DateTime(date.year, date.month, date.day);
}

String convertDateToEstString(String dateTime,
    {String dateFormat = 'dd/MM/yyyy'}) {
  DateTime date = DateFormat(dateFormat).parse(DateFormat(dateFormat)
      .format(DateTime.parse(dateTime).subtract(const Duration(hours: 4))));
  return formatDateTimeAsString(date, dateFormat: dateFormat);
}

String convertDateToHktString(String dateTime,
    {String dateFormat = 'dd/MM/yyyy'}) {
  DateTime date = DateFormat(dateFormat).parse(DateFormat(dateFormat)
      .format(DateTime.parse(dateTime).add(const Duration(hours: 8))));
  return formatDateTimeAsString(date, dateFormat: dateFormat);
}

String addOneDayToDate(String dateTime, {String dateFormat = 'dd/MM/yyyy'}) {
  DateTime date = DateFormat(dateFormat).parse(DateFormat(dateFormat)
      .format(DateTime.parse(dateTime).add(const Duration(days: 1))));
  return formatDateTimeAsString(date, dateFormat: dateFormat);
}

DateTime convertDateToHkt(String dateTime) {
  return DateTime.parse(dateTime).add(const Duration(hours: 8));
}
