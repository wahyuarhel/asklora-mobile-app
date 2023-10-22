import 'dart:math';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyTextInputFormatter extends TextInputFormatter {
  CurrencyTextInputFormatter(
      {this.locale,
      this.name,
      this.symbol,
      this.decimalDigits,
      this.customPattern,
      this.turnOffGrouping = false,
      this.enableNegative = true,
      this.allowDecimal = true});

  final String? locale;
  final String? name;
  final String? symbol;
  final int? decimalDigits;
  final String? customPattern;
  final bool turnOffGrouping;
  final bool enableNegative;
  final bool allowDecimal;

  num _newNum = 0;
  String _newString = '';
  bool _isNegative = false;

  void _formatter(String newText) {
    final NumberFormat format = NumberFormat.currency(
      locale: locale,
      name: name,
      symbol: symbol,
      decimalDigits: decimalDigits,
      customPattern: customPattern,
    );
    if (turnOffGrouping) {
      format.turnOffGrouping();
    }

    int firstIdxOfDot = newText.indexOf('.');
    int lastIdxOfDot = newText.lastIndexOf('.');

    if (firstIdxOfDot == -1 || firstIdxOfDot == 0) {
      _newNum = num.tryParse(newText) ?? 0;
      if (format.decimalDigits! > 0) {
        _newNum /= pow(10, format.decimalDigits!);
      }
      _newString = (_isNegative ? '-' : '') + format.format(_newNum).trim();
    } else {
      _newNum = num.tryParse(newText.substring(0, firstIdxOfDot)) ?? 0;

      String formatNewNum = format.format(_newNum).trim();
      if (allowDecimal) {
        String digitString = newText
            .substring(
                firstIdxOfDot,
                firstIdxOfDot == lastIdxOfDot
                    ? newText.length
                    : newText.length - 1)
            .trim();
        _newString = (_isNegative ? '-' : '') +
            formatNewNum +
            digitString.substring(
                0, digitString.length > 3 ? 3 : digitString.length);
      } else {
        _newString = (_isNegative ? '-' : '') + formatNewNum;
      }
    }
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final bool isRemovedCharacter =
        oldValue.text.length - 1 == newValue.text.length &&
            oldValue.text.startsWith(newValue.text);

    if (enableNegative) {
      _isNegative = newValue.text.startsWith('-');
    } else {
      _isNegative = false;
    }

    String newText = newValue.text.replaceAll(RegExp('[^0-9.]'), '');
    if (isRemovedCharacter && !_lastCharacterIsDigit(oldValue.text)) {
      final int length = newText.length - 1;
      newText = newText.substring(0, length > 0 ? length : 0);
    }

    _formatter(newText);

    if (newText.trim() == '' || newText == '00' || newText == '000') {
      return TextEditingValue(
        text: _isNegative ? '-' : '',
        selection: TextSelection.collapsed(offset: _isNegative ? 1 : 0),
      );
    }

    return TextEditingValue(
      text: _newString,
      selection: TextSelection.collapsed(offset: _newString.length),
    );
  }

  static bool _lastCharacterIsDigit(String text) {
    final String lastChar = text.substring(text.length - 1);
    return RegExp('[0-9.]').hasMatch(lastChar);
  }

  String getFormattedValue() {
    return _newString;
  }

  num getUnformattedValue() {
    return _isNegative ? (_newNum * -1) : _newNum;
  }

  String format(String value) {
    if (enableNegative) {
      _isNegative = value.startsWith('-');
    } else {
      _isNegative = false;
    }

    final String newText = value.replaceAll(RegExp('[^0-9.]'), '');
    _formatter(newText);
    return _newString;
  }
}
