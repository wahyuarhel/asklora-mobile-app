part of 'personal_info_bloc.dart';

class PersonalInfoState extends Equatable {
  const PersonalInfoState({
    this.firstName = '',
    this.lastName = '',
    this.gender = '',
    this.dateOfBirth = '1990-01-01',
    this.countryCodeOfBirth = '',
    this.countryNameOfBirth = '',
    this.phoneCountryCode = '852',
    this.phoneNumber = '',
    this.nationalityCode = '',
    this.nationalityName = '',
    this.isHongKongPermanentResident,
    this.hkIdNumber = '',
    this.isUnitedStateResident,
    this.phoneNumberErrorText = '',
    this.hkIdErrorText = '',
    this.response = const BaseResponse(),
  });

  final String firstName;
  final String lastName;
  final String gender;
  final String dateOfBirth;
  final String countryCodeOfBirth;
  final String countryNameOfBirth;
  final String phoneCountryCode;
  final String phoneNumber;
  final String nationalityCode;
  final String nationalityName;
  final bool? isHongKongPermanentResident;
  final String hkIdNumber;
  final bool? isUnitedStateResident;
  final String? phoneNumberErrorText;
  final BaseResponse response;
  final String? hkIdErrorText;

  @override
  List<Object?> get props {
    return [
      firstName,
      lastName,
      gender,
      dateOfBirth,
      countryCodeOfBirth,
      countryNameOfBirth,
      phoneCountryCode,
      phoneNumber,
      nationalityCode,
      nationalityName,
      isHongKongPermanentResident,
      hkIdNumber,
      isUnitedStateResident,
      phoneNumberErrorText,
      hkIdErrorText,
      response,
    ];
  }

  PersonalInfoState copyWith({
    String? firstName,
    String? lastName,
    String? gender,
    String? dateOfBirth,
    String? countryCodeOfBirth,
    String? countryNameOfBirth,
    String? phoneCountryCode,
    String? phoneNumber,
    String? nationalityCode,
    String? nationalityName,
    ValueGetter<bool?>? isHongKongPermanentResident,
    String? hkIdNumber,
    ValueGetter<bool?>? isUnitedStateResident,
    String? phoneNumberErrorText,
    BaseResponse? response,
    String? hkIdErrorText,
  }) {
    return PersonalInfoState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      countryCodeOfBirth: countryCodeOfBirth ?? this.countryCodeOfBirth,
      countryNameOfBirth: countryNameOfBirth ?? this.countryNameOfBirth,
      phoneCountryCode: phoneCountryCode ?? this.phoneCountryCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      nationalityCode: nationalityCode ?? this.nationalityCode,
      nationalityName: nationalityName ?? this.nationalityName,
      isHongKongPermanentResident: isHongKongPermanentResident != null
          ? isHongKongPermanentResident()
          : this.isHongKongPermanentResident,
      hkIdNumber: hkIdNumber ?? this.hkIdNumber,
      isUnitedStateResident: isUnitedStateResident != null
          ? isUnitedStateResident()
          : this.isUnitedStateResident,
      phoneNumberErrorText: phoneNumberErrorText ?? this.phoneNumberErrorText,
      response: response ?? this.response,
      hkIdErrorText: hkIdErrorText ?? this.hkIdErrorText,
    );
  }

  bool enableNextButton() {
    if (firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        gender.isNotEmpty &&
        dateOfBirth.isNotEmpty &&
        countryCodeOfBirth.isNotEmpty &&
        phoneCountryCode.isNotEmpty &&
        phoneNumber.isNotEmpty &&
        nationalityCode.isNotEmpty &&
        isHongKongPermanentResident != null &&
        isUnitedStateResident != null) {
      if (isHongKongPermanentResident == true) {
        if (hkIdNumber.isNotEmpty) {
          return true;
        } else {
          return false;
        }
      } else {
        return true;
      }
    } else {
      return false;
    }
  }
}
