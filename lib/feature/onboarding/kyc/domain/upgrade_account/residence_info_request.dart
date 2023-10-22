import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'residence_info_request.g.dart';

@JsonSerializable()
class ResidenceInfoRequest extends Equatable {
  @JsonKey(name: 'address_line_1')
  final String? addressLine1;
  @JsonKey(name: 'address_line_2')
  final String? addressLine2;
  final String? district;
  final String? region;
  @JsonKey(includeIfNull: false)
  final String? country;

  const ResidenceInfoRequest({
    this.addressLine1,
    this.addressLine2,
    this.district,
    this.region,
    this.country,
  });

  factory ResidenceInfoRequest.fromJson(Map<String, dynamic> json) =>
      _$ResidenceInfoRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ResidenceInfoRequestToJson(this);

  @override
  List<Object> get props => [
        addressLine1 ?? '',
        addressLine2 ?? '',
        district ?? '',
        region ?? '',
        country ?? '',
      ];
}
