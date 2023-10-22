import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../bloc/personal_info/personal_info_bloc.dart';

part 'personal_info_request.g.dart';

@JsonSerializable()
class PersonalInfoRequest extends Equatable {
  @JsonKey(name: 'first_name')
  final String? firstName;

  @JsonKey(name: 'last_name')
  final String? lastName;
  final String? gender;
  @JsonKey(name: 'hkid_number')
  final String? hkIdNumber;

  final String? nationality;
  @JsonKey(name: 'date_of_birth')
  final String? dateOfBirth;

  @JsonKey(name: 'country_of_birth')
  final String? countryOfBirth;

  @JsonKey(name: 'phone_country_code')
  final String? phoneCountryCode;

  @JsonKey(name: 'phone_number')
  final String? phoneNumber;

  ///below field are for saving state purposes and not be used on submitting real kyc
  @JsonKey(includeIfNull: false)
  final bool? isUnitedStateResident;
  @JsonKey(includeIfNull: false)
  final bool? isHongKongPermanentResident;

  const PersonalInfoRequest({
    this.firstName,
    this.lastName,
    this.gender,
    this.hkIdNumber,
    this.nationality,
    this.dateOfBirth,
    this.countryOfBirth,
    this.phoneCountryCode,
    this.phoneNumber,
    this.isUnitedStateResident,
    this.isHongKongPermanentResident,
  });

  static PersonalInfoRequest getRequestForSavingKyc(BuildContext context) {
    final PersonalInfoState personalInfoState =
        context.read<PersonalInfoBloc>().state;

    return PersonalInfoRequest(
      firstName: personalInfoState.firstName,
      lastName: personalInfoState.lastName,
      gender: personalInfoState.gender,
      hkIdNumber: personalInfoState.hkIdNumber,
      nationality: context.read<PersonalInfoBloc>().state.nationalityCode,
      dateOfBirth: personalInfoState.dateOfBirth,
      countryOfBirth: context.read<PersonalInfoBloc>().state.countryCodeOfBirth,
      phoneCountryCode: context.read<PersonalInfoBloc>().state.phoneCountryCode,
      phoneNumber: personalInfoState.phoneNumber,
      isUnitedStateResident: personalInfoState.isUnitedStateResident,
      isHongKongPermanentResident:
          personalInfoState.isHongKongPermanentResident,
    );
  }

  factory PersonalInfoRequest.fromJson(Map<String, dynamic> json) =>
      _$PersonalInfoRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalInfoRequestToJson(this);

  @override
  List<Object> get props => [
        firstName ?? '',
        lastName ?? '',
        gender ?? '',
        hkIdNumber ?? '',
        nationality ?? '',
        dateOfBirth ?? '',
        countryOfBirth ?? '',
        phoneCountryCode ?? '',
        phoneNumber ?? '',
      ];
}
