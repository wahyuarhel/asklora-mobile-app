part of 'personal_info_bloc.dart';

abstract class PersonalInfoEvent extends Equatable {
  const PersonalInfoEvent();

  @override
  List<Object> get props => [];
}

class PersonalInfoFirstNameChanged extends PersonalInfoEvent {
  final String firstName;

  const PersonalInfoFirstNameChanged(this.firstName) : super();

  @override
  List<Object> get props => [firstName];
}

class PersonalInfoLastNameChanged extends PersonalInfoEvent {
  final String lastName;

  const PersonalInfoLastNameChanged(this.lastName) : super();

  @override
  List<Object> get props => [lastName];
}

class PersonalInfoGenderChanged extends PersonalInfoEvent {
  final String gender;

  const PersonalInfoGenderChanged(this.gender) : super();

  @override
  List<Object> get props => [gender];
}

class PersonalInfoDateOfBirthChanged extends PersonalInfoEvent {
  final String dateOfBirth;

  const PersonalInfoDateOfBirthChanged(this.dateOfBirth) : super();

  @override
  List<Object> get props => [dateOfBirth];
}

class PersonalInfoPhoneCountryCodeChanged extends PersonalInfoEvent {
  final String phoneCountryCode;

  const PersonalInfoPhoneCountryCodeChanged(this.phoneCountryCode) : super();

  @override
  List<Object> get props => [phoneCountryCode];
}

class PersonalInfoPhoneNumberChanged extends PersonalInfoEvent {
  final String phoneNumber;

  const PersonalInfoPhoneNumberChanged(this.phoneNumber) : super();

  @override
  List<Object> get props => [phoneNumber];
}

class PersonalInfoNationalityChanged extends PersonalInfoEvent {
  final String nationalityCode;
  final String nationalityName;

  const PersonalInfoNationalityChanged(
      this.nationalityCode, this.nationalityName)
      : super();

  @override
  List<Object> get props => [nationalityCode];
}

class PersonalInfoCountryOfBirthChanged extends PersonalInfoEvent {
  final String countryCodeOfBirth;
  final String countryNameOfBirth;

  const PersonalInfoCountryOfBirthChanged(
      this.countryCodeOfBirth, this.countryNameOfBirth)
      : super();

  @override
  List<Object> get props => [countryCodeOfBirth];
}

class PersonalInfoIsHongKongPermanentResidentChanged extends PersonalInfoEvent {
  final bool isHongKongPermanentResident;

  const PersonalInfoIsHongKongPermanentResidentChanged(
      this.isHongKongPermanentResident)
      : super();

  @override
  List<Object> get props => [isHongKongPermanentResident];
}

class ResetResidentAnswer extends PersonalInfoEvent {}

class PersonalInfoHkIdNumberChanged extends PersonalInfoEvent {
  final String hkIdNumber;

  const PersonalInfoHkIdNumberChanged(this.hkIdNumber);

  @override
  List<Object> get props => [hkIdNumber];
}

class PersonalInfoIsUnitedStateResidentChanged extends PersonalInfoEvent {
  final bool isUnitedStateResident;

  const PersonalInfoIsUnitedStateResidentChanged(this.isUnitedStateResident)
      : super();

  @override
  List<Object> get props => [isUnitedStateResident];
}

class PersonalInfoNext extends PersonalInfoEvent {
  const PersonalInfoNext() : super();

  @override
  List<Object> get props => [];
}

class PersonalInfoReset extends PersonalInfoEvent {
  const PersonalInfoReset() : super();

  @override
  List<Object> get props => [];
}

class PersonalInfoSubmitted extends PersonalInfoEvent {
  final PersonalInfoRequest personalInfoRequest;
  const PersonalInfoSubmitted(this.personalInfoRequest);

  @override
  List<Object> get props => [personalInfoRequest];
}

class InitiatePersonalInfo extends PersonalInfoEvent {
  final PersonalInfoRequest? personalInfoRequest;
  const InitiatePersonalInfo(this.personalInfoRequest);

  @override
  List<Object> get props => [personalInfoRequest ?? ''];
}
