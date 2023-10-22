import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'formatter_utils.dart';

part 'phone_input_data.dart';

class PhoneInputFormatter extends TextInputFormatter {
  final ValueChanged<PhoneCountryData?>? onCountrySelected;
  final bool allowEndlessPhone;
  final String? countryCode;
  final ValueChanged<String>? onPhoneNumberChange;

  PhoneCountryData? _countryData;
  String _lastValue = '';

  PhoneInputFormatter({
    this.onCountrySelected,
    this.allowEndlessPhone = false,
    this.countryCode,
    this.onPhoneNumberChange,
  });

  String get masked => _lastValue;

  String get unmasked => '+${toNumericString(_lastValue, allowHyphen: false)}';

  bool get isFilled => isPhoneValid(masked);

  String mask(String value) {
    return formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(text: value),
    ).text;
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var isErasing = newValue.text.length < oldValue.text.length;
    _lastValue = newValue.text;

    var onlyNumbers = toNumericString(newValue.text);
    String maskedValue;
    if (isErasing) {
      if (newValue.text.isEmpty) {
        _clearCountry();
      }
    }
    if (onlyNumbers.length == 2) {
      var isRussianWrongNumber =
          onlyNumbers[0] == '8' && onlyNumbers[1] == '9' ||
              onlyNumbers[0] == '8' && onlyNumbers[1] == '3';
      if (isRussianWrongNumber) {
        onlyNumbers = '7${onlyNumbers[1]}';
        _countryData = null;
        _applyMask(
          '7',
          allowEndlessPhone,
        );
      }
    }

    maskedValue = _applyMask(onlyNumbers, allowEndlessPhone);
    onPhoneNumberChange!(onlyNumbers);
    if (maskedValue == oldValue.text && onlyNumbers != '7') {
      _lastValue = maskedValue;
      if (isErasing) {
        var newSelection = oldValue.selection;
        newSelection = newSelection.copyWith(
          baseOffset: oldValue.selection.baseOffset,
          extentOffset: oldValue.selection.baseOffset,
        );
        return oldValue.copyWith(
          selection: newSelection,
        );
      }
      return oldValue;
    }

    final endOffset = newValue.text.length - newValue.selection.end;
    final selectionEnd = maskedValue.length - endOffset;

    _lastValue = maskedValue;
    return TextEditingValue(
      selection: TextSelection.collapsed(offset: selectionEnd),
      text: maskedValue,
    );
  }

  Future _clearCountry() async {
    await Future.delayed(const Duration(milliseconds: 5));
    _updateCountryData(null);
  }

  void _updateCountryData(PhoneCountryData? countryData) {
    _countryData = countryData;
    if (onCountrySelected != null) {
      onCountrySelected!(_countryData);
    }
  }

  String _applyMask(String numericString, bool allowEndlessPhone) {
    if (numericString.isEmpty) {
      _updateCountryData(null);
    } else {
      var countryData =
          PhoneCodes.getCountryDataByPhone(countryCode ?? numericString);
      if (countryData != null) {
        _updateCountryData(countryData);
      }
    }
    if (_countryData != null) {
      return _formatByMask(
        numericString,
        countryCode == null
            ? _countryData!.phoneMask!
            : _countryData!.phoneMaskWithoutCountryCode!,
        _countryData!.altMasks,
        0,
        allowEndlessPhone,
      );
    }
    return numericString;
  }

  static void addAlternativePhoneMasks({
    required String countryCode,
    required List<String> alternativeMasks,
    bool mergeWithExisting = false,
  }) {
    assert(alternativeMasks.isNotEmpty);
    final countryData = _findCountryDataByCountryCode(countryCode);
    String currentMask = countryData['phoneMask'];
    alternativeMasks.sort((a, b) => a.length.compareTo(b.length));
    countryData['phoneMask'] = alternativeMasks.first;
    alternativeMasks.removeAt(0);
    if (!alternativeMasks.contains(currentMask)) {
      alternativeMasks.add(currentMask);
    }
    alternativeMasks.sort((a, b) => a.length.compareTo(b.length));
    if (!mergeWithExisting || countryData['altMasks'] == null) {
      countryData['altMasks'] = alternativeMasks;
    } else {
      final existingList = countryData['altMasks'];
      for (var m in alternativeMasks) {
        existingList.add(m);
      }
    }
  }

  static void replacePhoneMask({
    required String countryCode,
    required String newMask,
  }) {
    checkMask(newMask);
    final countryData = _findCountryDataByCountryCode(countryCode);
    var currentMask = countryData['phoneMask'];
    if (currentMask != newMask) {
      debugPrint(
        'Phone mask for country "${countryData['country']}" was replaced from $currentMask to $newMask',
      );
      countryData['phoneMask'] = newMask;
    }
  }

  static Map<String, dynamic> _findCountryDataByCountryCode(
    String countryCode,
  ) {
    assert(countryCode.length == 2);
    countryCode = countryCode.toUpperCase();
    var countryData = _data.firstWhereOrNull(
      ((m) => m!['countryCode'] == countryCode),
    );
    if (countryData == null) {
      throw 'A country with a code of $countryCode is not found';
    }
    return countryData;
  }
}

bool isPhoneValid(
  String phone, {
  bool allowEndlessPhone = false,
}) {
  phone = toNumericString(
    phone,
    allowHyphen: false,
  );
  if (phone.isEmpty) {
    return false;
  }
  var countryData = PhoneCodes.getCountryDataByPhone(
    phone,
  );
  if (countryData == null) {
    return false;
  }
  var formatted = _formatByMask(
    phone,
    countryData.phoneMask!,
    countryData.altMasks,
    0,
    allowEndlessPhone,
  );
  var preprocessed = toNumericString(
    formatted,
    allowHyphen: false,
  );
  if (allowEndlessPhone) {
    var contains = phone.contains(preprocessed);
    return contains;
  }
  var correctLength = formatted.length == countryData.phoneMask!.length;
  if (correctLength != true && countryData.altMasks != null) {
    return countryData.altMasks!.any(
      (altMask) => formatted.length == altMask.length,
    );
  }
  return correctLength;
}

String? formatAsPhoneNumber(
  String phone, {
  InvalidPhoneAction invalidPhoneAction = InvalidPhoneAction.showUnformatted,
  bool allowEndlessPhone = false,
  String? defaultMask,
}) {
  if (!isPhoneValid(
    phone,
    allowEndlessPhone: allowEndlessPhone,
  )) {
    switch (invalidPhoneAction) {
      case InvalidPhoneAction.showUnformatted:
        if (defaultMask == null) return phone;
        break;
      case InvalidPhoneAction.returnNull:
        return null;
      case InvalidPhoneAction.showPhoneInvalidString:
        return 'invalid phone';
    }
  }
  phone = toNumericString(phone);
  var countryData = PhoneCodes.getCountryDataByPhone(phone);

  if (countryData != null) {
    return _formatByMask(
      phone,
      countryData.phoneMask!,
      countryData.altMasks,
      0,
      allowEndlessPhone,
    );
  } else {
    return _formatByMask(
      phone,
      defaultMask!,
      null,
      0,
      allowEndlessPhone,
    );
  }
}

String _formatByMask(
  String text,
  String mask,
  List<String>? altMasks, [
  int altMaskIndex = 0,
  bool allowEndlessPhone = false,
]) {
  text = toNumericString(text, allowHyphen: false);
  var result = <String>[];
  var indexInText = 0;
  for (var i = 0; i < (mask.length); i++) {
    if (indexInText >= text.length) {
      break;
    }
    var curMaskChar = mask[i];
    if (curMaskChar == '0') {
      var curChar = text[indexInText];
      if (isDigit(curChar)) {
        result.add(curChar);
        indexInText++;
      } else {
        break;
      }
    } else {
      result.add(curMaskChar);
    }
  }

  var actualDigitsInMask = toNumericString(
    mask,
    allowHyphen: false,
  ).replaceAll(',', '');
  if (actualDigitsInMask.length < text.length) {
    if (altMasks != null && altMaskIndex < altMasks.length) {
      var formatResult = _formatByMask(
        text,
        altMasks[altMaskIndex],
        altMasks,
        altMaskIndex + 1,
        allowEndlessPhone,
      );
      return formatResult;
    }

    if (allowEndlessPhone) {
      result.add(' ');
      for (var i = actualDigitsInMask.length; i < text.length; i++) {
        result.add(text[i]);
      }
    }
  }

  final jointResult = result.join();
  return jointResult;
}

List<PhoneCountryData> getCountryDatasByPhone(String phone) {
  phone = toNumericString(phone);
  if (phone.isEmpty || phone.length < 11) {
    return <PhoneCountryData>[];
  }
  var phoneCode = phone.substring(0, phone.length - 10);
  return PhoneCodes.getCountriesDataByPhone(phoneCode);
}

class PhoneCountryData {
  final String? country;
  final String? phoneCode;
  final String? countryCode;
  final String? phoneMask;
  final String? phoneMaskWithoutCountryCode;

  final List<String>? altMasks;

  PhoneCountryData._init({
    this.country,
    this.countryCode,
    this.phoneMask,
    this.phoneMaskWithoutCountryCode,
    this.altMasks,
    this.phoneCode,
  });

  String phoneCodeToString() {
    return '+$phoneCode';
  }

  factory PhoneCountryData.fromMap(Map value) {
    final countryData = PhoneCountryData._init(
      country: value['country'],
      phoneCode: value['phoneCode'] ?? value['internalPhoneCode'],
      countryCode: value['countryCode'],
      phoneMask: value['phoneMask'],
      phoneMaskWithoutCountryCode:
          _getPhoneMaskWithoutCountryCode(value['phoneMask']),
      altMasks: value['altMasks'],
    );
    return countryData;
  }

  static String _getPhoneMaskWithoutCountryCode(String phoneMask) {
    List<String> test = phoneMask.split(' ');
    test.removeAt(0);
    return test.join(' ');
  }

  @override
  String toString() {
    return '[PhoneCountryData(country: $country, phoneCode: $phoneCode, countryCode: $countryCode)]';
  }
}

class PhoneCodes {
  static PhoneCountryData? getCountryDataByPhone(
    String phone, {
    int? subscribingLength,
  }) {
    if (phone.isEmpty) return null;
    subscribingLength = subscribingLength ?? phone.length;

    if (subscribingLength < 1) return null;
    var phoneCode = phone.substring(0, subscribingLength);

    var rawData = _data.firstWhereOrNull(
      (data) => toNumericString(data!['internalPhoneCode']) == phoneCode,
    );
    if (rawData != null) {
      return PhoneCountryData.fromMap(rawData);
    }
    return getCountryDataByPhone(phone,
        subscribingLength: subscribingLength - 1);
  }

  static List<PhoneCountryData> getCountriesDataByPhone(
    String phoneCode,
  ) {
    var list = <PhoneCountryData>[];
    for (var data in _data) {
      var c = toNumericString(data!['internalPhoneCode']);
      if (c == phoneCode) {
        list.add(PhoneCountryData.fromMap(data));
      }
    }
    return list;
  }
}
