import 'package:asklora_mobile_app/core/domain/base_response.dart';
import 'package:asklora_mobile_app/feature/onboarding/kyc/bloc/personal_info/personal_info_bloc.dart';
import 'package:asklora_mobile_app/feature/onboarding/kyc/domain/account_api_client.dart';
import 'package:asklora_mobile_app/feature/onboarding/kyc/domain/upgrade_account/personal_info_request.dart';
import 'package:asklora_mobile_app/feature/onboarding/kyc/repository/account_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'personal_info_bloc_test.mocks.dart';

class DioAdapterMock extends Mock implements HttpClientAdapter {}

class MockPersonalInfoBloc
    extends MockBloc<PersonalInfoEvent, PersonalInfoState>
    implements PersonalInfoBloc {}

@GenerateMocks([AccountRepository])
@GenerateMocks([AccountApiClient])
void main() {
  group(
    '*Personal Info Bloc Test',
    () {
      late MockAccountRepository accountRepository;
      late PersonalInfoBloc personalInfoBloc;

      setUpAll(
        () async {
          accountRepository = MockAccountRepository();
        },
      );

      setUp(
        () async {
          personalInfoBloc =
              PersonalInfoBloc(accountRepository: accountRepository);
        },
      );

      test(
          'init state all field should be empty string except for optional fields it should be null',
          () {
        expect(
            personalInfoBloc.state,
            const PersonalInfoState(
              firstName: '',
              lastName: '',
              gender: '',
              dateOfBirth: '1990-01-01',
              countryCodeOfBirth: '',
              countryNameOfBirth: '',
              phoneCountryCode: '852',
              phoneNumber: '',
              nationalityCode: '',
              nationalityName: '',
              isHongKongPermanentResident: null,
              hkIdNumber: '',
              isUnitedStateResident: null,
              phoneNumberErrorText: '',
              response: BaseResponse(),
            ));
      });

      blocTest<PersonalInfoBloc, PersonalInfoState>(
          'Expected bloc error should be error as US residence is true',
          build: () => personalInfoBloc,
          act: (bloc) {
            bloc.add(const PersonalInfoIsUnitedStateResidentChanged(true));
            bloc.add(const PersonalInfoNext());
          },
          expect: () => {
                const PersonalInfoState(
                  firstName: '',
                  lastName: '',
                  gender: '',
                  countryCodeOfBirth: '',
                  countryNameOfBirth: '',
                  phoneCountryCode: '852',
                  phoneNumber: '',
                  nationalityCode: '',
                  nationalityName: '',
                  isHongKongPermanentResident: null,
                  hkIdNumber: '',
                  isUnitedStateResident: true,
                  phoneNumberErrorText: '',
                  response: BaseResponse(),
                ),
                PersonalInfoState(
                  firstName: '',
                  lastName: '',
                  gender: '',
                  countryCodeOfBirth: '',
                  countryNameOfBirth: '',
                  phoneCountryCode: '852',
                  phoneNumber: '',
                  nationalityCode: '',
                  nationalityName: '',
                  isHongKongPermanentResident: null,
                  hkIdNumber: '',
                  isUnitedStateResident: true,
                  phoneNumberErrorText: '',
                  response: BaseResponse.unknown(),
                ),
                PersonalInfoState(
                  firstName: '',
                  lastName: '',
                  gender: '',
                  countryCodeOfBirth: '',
                  countryNameOfBirth: '',
                  phoneCountryCode: '852',
                  phoneNumber: '',
                  nationalityCode: '',
                  nationalityName: '',
                  isHongKongPermanentResident: null,
                  hkIdNumber: '',
                  isUnitedStateResident: true,
                  phoneNumberErrorText: '',
                  response:
                      BaseResponse.error(message: r'You are not eligible!'),
                ),
              });

      blocTest<PersonalInfoBloc, PersonalInfoState>(
          'Expected bloc error should be error as age is below 18',
          build: () => personalInfoBloc,
          act: (bloc) {
            bloc.add(const PersonalInfoDateOfBirthChanged(
                '2010-08-08 00:00:00.000'));
            bloc.add(const PersonalInfoHkIdNumberChanged('f1234567'));
            bloc.add(const PersonalInfoSubmitted(PersonalInfoRequest()));
          },
          expect: () => {
                const PersonalInfoState(
                  firstName: '',
                  lastName: '',
                  gender: '',
                  dateOfBirth: '2010-08-08',
                  countryCodeOfBirth: '',
                  countryNameOfBirth: '',
                  phoneCountryCode: '852',
                  phoneNumber: '',
                  nationalityCode: '',
                  nationalityName: '',
                  isHongKongPermanentResident: null,
                  hkIdNumber: '',
                  isUnitedStateResident: null,
                  phoneNumberErrorText: '',
                  response: BaseResponse(),
                ),
                const PersonalInfoState(
                  firstName: '',
                  lastName: '',
                  gender: '',
                  dateOfBirth: '2010-08-08',
                  countryCodeOfBirth: '',
                  countryNameOfBirth: '',
                  phoneCountryCode: '852',
                  phoneNumber: '',
                  nationalityCode: '',
                  nationalityName: '',
                  isHongKongPermanentResident: null,
                  hkIdNumber: 'f1234567',
                  isUnitedStateResident: null,
                  phoneNumberErrorText: '',
                  response: BaseResponse(),
                ),
                PersonalInfoState(
                  firstName: '',
                  lastName: '',
                  gender: '',
                  dateOfBirth: '2010-08-08',
                  countryCodeOfBirth: '',
                  countryNameOfBirth: '',
                  phoneCountryCode: '852',
                  phoneNumber: '',
                  nationalityCode: '',
                  nationalityName: '',
                  isHongKongPermanentResident: null,
                  hkIdNumber: 'f1234567',
                  isUnitedStateResident: null,
                  phoneNumberErrorText: '',
                  response: BaseResponse.unknown(),
                ),
                PersonalInfoState(
                  firstName: '',
                  lastName: '',
                  gender: '',
                  dateOfBirth: '2010-08-08',
                  countryCodeOfBirth: '',
                  countryNameOfBirth: '',
                  phoneCountryCode: '852',
                  phoneNumber: '',
                  nationalityCode: '',
                  nationalityName: '',
                  isHongKongPermanentResident: null,
                  hkIdNumber: 'f1234567',
                  isUnitedStateResident: null,
                  phoneNumberErrorText: '',
                  response: BaseResponse.error(
                      message: r'You must be over 18 to sign up for AskLORA!'),
                ),
              });

      blocTest<PersonalInfoBloc, PersonalInfoState>('Input invalid HKID number',
          build: () => personalInfoBloc,
          act: (bloc) {
            bloc.add(const PersonalInfoHkIdNumberChanged('666-55-4321'));
          },
          expect: () => {
                const PersonalInfoState(
                  firstName: '',
                  lastName: '',
                  gender: '',
                  countryCodeOfBirth: '',
                  countryNameOfBirth: '',
                  phoneCountryCode: '852',
                  phoneNumber: '',
                  nationalityCode: '',
                  nationalityName: '',
                  isHongKongPermanentResident: null,
                  hkIdNumber: '666-55-4321',
                  isUnitedStateResident: null,
                  phoneNumberErrorText: '',
                  response: BaseResponse(),
                ),
              });

      blocTest<PersonalInfoBloc, PersonalInfoState>('Input valid HKID number',
          build: () => personalInfoBloc,
          act: (bloc) {
            bloc.add(const PersonalInfoHkIdNumberChanged('F1234567'));
          },
          expect: () => {
                const PersonalInfoState(
                  firstName: '',
                  lastName: '',
                  gender: '',
                  countryCodeOfBirth: '',
                  countryNameOfBirth: '',
                  phoneCountryCode: '852',
                  phoneNumber: '',
                  nationalityCode: '',
                  nationalityName: '',
                  isHongKongPermanentResident: null,
                  hkIdNumber: 'F1234567',
                  isUnitedStateResident: null,
                  phoneNumberErrorText: '',
                  response: BaseResponse(),
                ),
              });

      blocTest<PersonalInfoBloc, PersonalInfoState>(
          'Input field for Personal Info Form.',
          build: () => personalInfoBloc,
          act: (bloc) {
            bloc.add(const PersonalInfoFirstNameChanged('John'));
            bloc.add(const PersonalInfoLastNameChanged('Doe'));
            bloc.add(const PersonalInfoGenderChanged('Male'));
            bloc.add(const PersonalInfoDateOfBirthChanged(
                '1990-09-10 00:00:00.000'));
            bloc.add(
                const PersonalInfoCountryOfBirthChanged('HKG', 'Hong Kong'));
            bloc.add(const PersonalInfoPhoneCountryCodeChanged('852'));
            bloc.add(const PersonalInfoPhoneNumberChanged('87654321'));
            bloc.add(const PersonalInfoNationalityChanged('HKG', 'Hong Kong'));
            bloc.add(
                const PersonalInfoIsHongKongPermanentResidentChanged(true));
            bloc.add(const PersonalInfoHkIdNumberChanged('666-55-4321'));
            bloc.add(const PersonalInfoIsUnitedStateResidentChanged(false));
          },
          expect: () => {
                const PersonalInfoState(
                  firstName: 'John',
                  lastName: '',
                  gender: '',
                  dateOfBirth: '1990-01-01',
                  countryCodeOfBirth: '',
                  phoneCountryCode: '852',
                  phoneNumber: '',
                  nationalityCode: '',
                  isHongKongPermanentResident: null,
                  hkIdNumber: '',
                  isUnitedStateResident: null,
                ),
                const PersonalInfoState(
                  firstName: 'John',
                  lastName: 'Doe',
                  gender: '',
                  dateOfBirth: '1990-01-01',
                  countryCodeOfBirth: '',
                  phoneCountryCode: '852',
                  phoneNumber: '',
                  nationalityCode: '',
                  isHongKongPermanentResident: null,
                  hkIdNumber: '',
                  isUnitedStateResident: null,
                ),
                const PersonalInfoState(
                  firstName: 'John',
                  lastName: 'Doe',
                  gender: 'Male',
                  dateOfBirth: '1990-01-01',
                  countryCodeOfBirth: '',
                  phoneCountryCode: '852',
                  phoneNumber: '',
                  nationalityCode: '',
                  isHongKongPermanentResident: null,
                  hkIdNumber: '',
                  isUnitedStateResident: null,
                ),
                const PersonalInfoState(
                  firstName: 'John',
                  lastName: 'Doe',
                  gender: 'Male',
                  dateOfBirth: '1990-09-10',
                  countryCodeOfBirth: '',
                  phoneCountryCode: '852',
                  phoneNumber: '',
                  nationalityCode: '',
                  isHongKongPermanentResident: null,
                  hkIdNumber: '',
                  isUnitedStateResident: null,
                ),
                const PersonalInfoState(
                  firstName: 'John',
                  lastName: 'Doe',
                  gender: 'Male',
                  dateOfBirth: '1990-09-10',
                  countryCodeOfBirth: 'HKG',
                  countryNameOfBirth: 'Hong Kong',
                  phoneCountryCode: '852',
                  phoneNumber: '',
                  nationalityCode: '',
                  isHongKongPermanentResident: null,
                  hkIdNumber: '',
                  isUnitedStateResident: null,
                ),
                const PersonalInfoState(
                  firstName: 'John',
                  lastName: 'Doe',
                  gender: 'Male',
                  dateOfBirth: '1990-09-10',
                  countryCodeOfBirth: 'HKG',
                  countryNameOfBirth: 'Hong Kong',
                  phoneCountryCode: '852',
                  phoneNumber: '87654321',
                  nationalityCode: '',
                  isHongKongPermanentResident: null,
                  hkIdNumber: '',
                  isUnitedStateResident: null,
                ),
                const PersonalInfoState(
                  firstName: 'John',
                  lastName: 'Doe',
                  gender: 'Male',
                  dateOfBirth: '1990-09-10',
                  countryCodeOfBirth: 'HKG',
                  countryNameOfBirth: 'Hong Kong',
                  phoneCountryCode: '852',
                  phoneNumber: '87654321',
                  nationalityCode: 'HKG',
                  nationalityName: 'Hong Kong',
                  isHongKongPermanentResident: null,
                  hkIdNumber: '',
                  isUnitedStateResident: null,
                ),
                const PersonalInfoState(
                  firstName: 'John',
                  lastName: 'Doe',
                  gender: 'Male',
                  dateOfBirth: '1990-09-10',
                  countryCodeOfBirth: 'HKG',
                  countryNameOfBirth: 'Hong Kong',
                  phoneCountryCode: '852',
                  phoneNumber: '87654321',
                  nationalityCode: 'HKG',
                  nationalityName: 'Hong Kong',
                  isHongKongPermanentResident: true,
                  hkIdNumber: '',
                  isUnitedStateResident: null,
                ),
                const PersonalInfoState(
                  firstName: 'John',
                  lastName: 'Doe',
                  gender: 'Male',
                  dateOfBirth: '1990-09-10',
                  countryCodeOfBirth: 'HKG',
                  countryNameOfBirth: 'Hong Kong',
                  phoneCountryCode: '852',
                  phoneNumber: '87654321',
                  nationalityCode: 'HKG',
                  nationalityName: 'Hong Kong',
                  isHongKongPermanentResident: true,
                  hkIdNumber: '666-55-4321',
                  isUnitedStateResident: null,
                ),
                const PersonalInfoState(
                  firstName: 'John',
                  lastName: 'Doe',
                  gender: 'Male',
                  dateOfBirth: '1990-09-10',
                  countryCodeOfBirth: 'HKG',
                  countryNameOfBirth: 'Hong Kong',
                  phoneCountryCode: '852',
                  phoneNumber: '87654321',
                  nationalityCode: 'HKG',
                  nationalityName: 'Hong Kong',
                  isHongKongPermanentResident: true,
                  hkIdNumber: '666-55-4321',
                  isUnitedStateResident: false,
                )
              });

      tearDown(() => personalInfoBloc.close());
    },
  );
}
