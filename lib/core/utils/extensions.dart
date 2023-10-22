import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'currency_enum.dart';

/// General Email Regex (RFC 5322 Official Standard)
/// https://www.emailregex.com/
const emailPatternSource =
    '^(?:[a-z0-9A-Z!#\$%&\'*+/=?^_`{|}~-]+(?:\\.[a-z0-9A-Z!#\$%&\'*+/=?^_`{|}~-]+)*|"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*")@(?:(?:[a-z0-9A-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-zA-Z0-9-]*[a-zA-Z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])\$';

final RegExp emailRegex = RegExp(emailPatternSource);

/// Password regex (minimum 8 chars and one character and one number).
final RegExp passwordRegex = RegExp(
    r'^(?=.*[A-Za-z])(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[A-Za-z\d\S ]{8,16}$');

/// OTP regex (exactly 6 digits)
final RegExp otpRegex = RegExp(r'^([0-9]{6})$');

/// extract amount regex
final RegExp amountRegex = RegExp('[^.0-9]');

bool deviceHasNotch(BuildContext context) =>
    (MediaQuery.of(context).viewPadding.top > 0);

extension EmailValidator on String {
  bool isValidEmail() => emailRegex.hasMatch(this);

  bool isValidPassword() => passwordRegex.hasMatch(this);

  bool isValidOtp() => otpRegex.hasMatch(this);
}

extension StringExtension on String {
  double textHeight(TextStyle style, double textWidth) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: this, style: style),
      textDirection: ui.TextDirection.ltr,
      maxLines: 1,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    final countLines = (textPainter.size.width / textWidth).ceil();
    final height = countLines * textPainter.size.height;
    return height;
  }

  double textWidth(TextStyle style) {
    TextPainter textPainter = TextPainter()
      ..text = TextSpan(text: this, style: style)
      ..textDirection = ui.TextDirection.ltr
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size.width;
  }

  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  String get toTitleCase => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.capitalize())
      .join(' ');
}

extension PasswordValidators on String {
  bool get containsUppercase => contains(RegExp(r'[A-Z]'));

  bool get containsLowercase => contains(RegExp(r'[a-z]'));

  bool get containsNumber => contains(RegExp(r'[0-9]'));
}

MaterialColor randomColor() => ([...Colors.primaries]..shuffle()).first;

extension DoublePrecision on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}

extension CurrencyFormat on double {
  String convertToCurrencyDecimal(
      {String symbol = '', String? locale, int decimalDigits = 2}) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      symbol: symbol,
      locale: locale,
      decimalDigits: decimalDigits,
    );
    return currencyFormatter.format(this);
  }

  String toUsd() {
    return (this * 0.13).convertToCurrencyDecimal();
  }

  String toHkd() {
    return (this * 7.85).convertToCurrencyDecimal();
  }

  String toUsdWithCurrencyPrefix() {
    return '${CurrencyType.usd.name} ${(this * 0.13).convertToCurrencyDecimal()}';
  }

  String toHkdWithCurrencyPrefix() {
    return '${CurrencyType.hkd.name} ${(this * 7.85).convertToCurrencyDecimal()}';
  }
}

extension ExtraPadding on BuildContext {
  Padding padding(
          {double topPadding = 20,
          double rightPadding = 20,
          double bottomPadding = 20,
          double leftPadding = 20}) =>
      Padding(
          padding: EdgeInsets.only(
        top: topPadding,
        left: leftPadding,
        right: rightPadding,
        bottom: bottomPadding,
      ));
}

extension RestTimeOnDuration on Duration {
  String get inDaysRest => inDays < 10 ? '0$inDays' : '$inDays';

  String get inHoursRest {
    int time = inHours - (inDays * 24);
    return time < 10 ? '0$time' : '$time';
  }

  String get inMinutesRest {
    int time = inMinutes - (inHours * 60);
    return time < 10 ? '0$time' : '$time';
  }

  String get inSecondsRest {
    int time = inSeconds - (inMinutes * 60);
    return time < 10 ? '0$time' : '$time';
  }

  int get inMillisecondsRest => inMilliseconds - (inSeconds * 1000);

  int get inMicrosecondsRest => inMicroseconds - (inMilliseconds * 1000);
}

double checkDouble(dynamic value) {
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0.0;
  return 0.0;
}

double checkTwoDecimalDouble(dynamic value) =>
    double.parse(checkDouble(value).toStringAsFixed(2));

int checkInt(dynamic value) {
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is String) return int.tryParse(value) ?? 0;
  return 0;
}

extension ConvertToBase64 on PlatformFile {
  String base64Image() {
    final bytes = File(path!).readAsBytesSync();
    String result = 'data:image/png;base64,${base64Encode(bytes)}';
    return result;
  }
}
