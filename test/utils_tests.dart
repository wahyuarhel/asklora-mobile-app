import 'package:asklora_mobile_app/core/utils/age_validation.dart';
import 'package:asklora_mobile_app/core/utils/extensions.dart';
import 'package:asklora_mobile_app/core/utils/hkid_validation.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('Utils Tests', () {
    test('Email regex test', () {
      var validEmail = 'test@test.com';
      var inValidEmail = 'test@test!!.com';
      expect(emailRegex.hasMatch(validEmail), true);
      expect(emailRegex.hasMatch(inValidEmail), false);

      expect(emailRegex.hasMatch('!!ll@test.com'), true);
      expect(emailRegex.hasMatch('test1@test.com'), true);
      expect(emailRegex.hasMatch('test!@test.com'), true);
      expect(emailRegex.hasMatch('test!@test-test.com'), true);
      expect(emailRegex.hasMatch('test-test@test-test.com'), true);
      expect(emailRegex.hasMatch('test-test@test-test.com'), true);

      expect(emailRegex.hasMatch('test@test@test-test.com'), false);
      expect(emailRegex.hasMatch('!!ll@test.c@'), false);
      expect(emailRegex.hasMatch(''), false);
      expect(emailRegex.hasMatch('kkkkk'), false);
      expect(emailRegex.hasMatch('ð@test.com'), false);
    });

    test('password regex test', () {
      var validPassword = 'TestTest1';
      var inValidPassword = 'testtest';
      expect(passwordRegex.hasMatch(validPassword), true);
      expect(passwordRegex.hasMatch('pAAssW0rd'), true);

      expect(passwordRegex.hasMatch(inValidPassword), false);
      expect(passwordRegex.hasMatch(''), false);
      expect(passwordRegex.hasMatch('kkkkk'), false);
      expect(passwordRegex.hasMatch('passw0rd!!!'), false);
    });

    test('Hong Kong ID Card Validation', () {
      expect(isHkIdValid('A12345'), false);
      expect(isHkIdValid('A12345789'), false);
      expect(isHkIdValid('A123456(7)'), false);
      expect(isHkIdValid('A123457890'), false);
      expect(isHkIdValid('A1234567'), false);

      expect(isHkIdValid('VE5753176'), true);
      expect(isHkIdValid('F543210A'), true);
      expect(isHkIdValid('Q9249334'), true);
      expect(isHkIdValid('V491175A'), true);
      expect(isHkIdValid('E4273315'), true);
      expect(isHkIdValid('FL1530083'), true);
    });

    test('Age Validation Test', () {
      var now = DateTime.now();
      var seventeenYearsAnd11Months =
          DateTime(now.year - 17, now.month - 1, now.day);

      var seventeenYearsAnd11MonthsAndDayMinusOne =
          DateTime(now.year - 17, now.month - 1, now.day - 1);

      var nineteenYears = DateTime(now.year - 19, now.month, now.day);
      var eighteenYears = DateTime(now.year - 18, now.month, now.day);

      expect(isAdult(now.toString()), false);
      expect(isAdult(seventeenYearsAnd11Months.toString()), false);
      expect(
          isAdult(seventeenYearsAnd11MonthsAndDayMinusOne.toString()), false);

      expect(isAdult('2004-08-02'), true);
      expect(isAdult(nineteenYears.toString()), true);
      expect(isAdult(eighteenYears.toString()), true);
    });

    test('convert currency test', () {
      expect(10000.00.toUsd() == 'USD 1300', true);
      expect(1000.00.toUsd() == 'USD 1500', false);
      expect(1300.00.toHkd() == 'HKD 10000', true);
      expect(1300.00.toHkd() == 'HKD 15000', false);
    });
  });
}
