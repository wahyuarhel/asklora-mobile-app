import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'employment_info.g.dart';

@JsonSerializable()
class EmploymentInfo extends Equatable {
  @JsonKey(name: 'employment_status')
  final String? employmentStatus;

  @JsonKey(includeIfNull: false)
  final String? employer;
  @JsonKey(name: 'employer_business', includeIfNull: false)
  final String? employerBusiness;
  @JsonKey(name: 'employer_business_description', includeIfNull: false)
  final String? employerBusinessDescription;
  @JsonKey(includeIfNull: false)
  final String? occupation;
  @JsonKey(name: 'employer_address_line_1', includeIfNull: false)
  final String? employerAddressLine1;
  @JsonKey(name: 'employer_address_line_2', includeIfNull: false)
  final String? employerAddressLine2;
  @JsonKey(includeIfNull: false)
  final String? district;
  @JsonKey(includeIfNull: false)
  final String? region;
  @JsonKey(includeIfNull: false)
  final String? country;
  @JsonKey(name: 'different_country_reason')
  final String? differentCountryReason;

  const EmploymentInfo({
    this.employmentStatus,
    this.employer,
    this.employerBusiness,
    this.employerBusinessDescription,
    this.occupation,
    this.employerAddressLine1,
    this.employerAddressLine2,
    this.district,
    this.region,
    this.country,
    this.differentCountryReason,
  });

  factory EmploymentInfo.fromJson(Map<String, dynamic> json) =>
      _$EmploymentInfoFromJson(json);

  Map<String, dynamic> toJson() => _$EmploymentInfoToJson(this);

  @override
  List<Object> get props => [
        employmentStatus ?? '',
        employer ?? '',
        employerBusiness ?? '',
        employerBusinessDescription ?? '',
        occupation ?? '',
        employerAddressLine1 ?? '',
        employerAddressLine2 ?? '',
        district ?? '',
        region ?? '',
        country ?? '',
        differentCountryReason ?? '',
      ];

  EmploymentInfo copyWith({
    String? employmentStatus,
    String? employer,
    String? employerBusiness,
    String? employerBusinessDescription,
    String? occupation,
    String? employerAddressLine1,
    String? employerAddressLine2,
    String? district,
    String? region,
    String? country,
    String? differentCountryReason,
  }) {
    return EmploymentInfo(
      employmentStatus: employmentStatus ?? this.employmentStatus,
      employer: employer ?? this.employer,
      employerBusiness: employerBusiness ?? this.employerBusiness,
      employerBusinessDescription:
          employerBusinessDescription ?? this.employerBusinessDescription,
      occupation: occupation ?? this.occupation,
      employerAddressLine1: employerAddressLine1 ?? this.employerAddressLine1,
      employerAddressLine2: employerAddressLine2 ?? this.employerAddressLine2,
      district: district ?? this.district,
      region: region ?? this.region,
      country: country ?? this.country,
      differentCountryReason:
          differentCountryReason ?? this.differentCountryReason,
    );
  }
}
