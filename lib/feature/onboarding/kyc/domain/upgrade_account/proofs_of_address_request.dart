import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'proofs_of_address_request.g.dart';

@JsonSerializable()
class ProofsOfAddressRequest extends Equatable {
  @JsonKey(name: 'proof_file')
  final String? proofFile;

  const ProofsOfAddressRequest({
    this.proofFile,
  });

  factory ProofsOfAddressRequest.fromJson(Map<String, dynamic> json) =>
      _$ProofsOfAddressRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ProofsOfAddressRequestToJson(this);

  @override
  List<Object> get props => [
        proofFile ?? '',
      ];
}
