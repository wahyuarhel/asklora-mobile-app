// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepositRequest _$DepositRequestFromJson(Map<String, dynamic> json) =>
    DepositRequest(
      (json['deposit_amount'] as num).toDouble(),
      (json['proof_files'] as List<dynamic>)
          .map((e) => ProofFile.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DepositRequestToJson(DepositRequest instance) =>
    <String, dynamic>{
      'deposit_amount': instance.depositAmount,
      'proof_files': instance.proofFiles,
    };

ProofFile _$ProofFileFromJson(Map<String, dynamic> json) => ProofFile(
      json['file'] as String,
    );

Map<String, dynamic> _$ProofFileToJson(ProofFile instance) => <String, dynamic>{
      'file': instance.file,
    };
