import 'package:json_annotation/json_annotation.dart';

part 'deposit_request.g.dart';

@JsonSerializable()
class DepositRequest {
  @JsonKey(name: 'deposit_amount')
  final double depositAmount;
  @JsonKey(name: 'proof_files')
  final List<ProofFile> proofFiles;

  DepositRequest(this.depositAmount, this.proofFiles);

  factory DepositRequest.fromJson(Map<String, dynamic> json) =>
      _$DepositRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DepositRequestToJson(this);
}

@JsonSerializable()
class ProofFile {
  final String file;

  ProofFile(this.file);

  factory ProofFile.fromJson(Map<String, dynamic> json) =>
      _$ProofFileFromJson(json);

  Map<String, dynamic> toJson() => _$ProofFileToJson(this);
}
