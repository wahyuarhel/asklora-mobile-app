import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../core/utils/date_utils.dart';
import '../../../../settings/domain/bank_account.dart';
import '../upgrade_account/agreement.dart';
import '../upgrade_account/employment_info.dart';
import '../upgrade_account/personal_info_request.dart';
import '../upgrade_account/residence_info_request.dart';

part 'get_account_response.g.dart';

@JsonSerializable(explicitToJson: true)
class GetAccountResponse extends Equatable {
  final int id;
  final String username;
  final String email;
  @JsonKey(name: 'can_trade')
  final bool canTrade;
  @JsonKey(name: 'date_joined')
  final String? dateJoined;
  @JsonKey(name: 'bank_account')
  final BankAccount? bankAccount;
  @JsonKey(name: 'personal_info')
  final PersonalInfoRequest? personalInfo;
  @JsonKey(name: 'residence_info')
  final ResidenceInfoRequest? residenceInfo;
  @JsonKey(name: 'employment_info')
  final EmploymentInfo? employmentInfo;
  final List<Agreement>? agreements;
  @JsonKey(name: 'last_journey')
  final LastJourney? lastJourney;
  @JsonKey(name: 'is_staff')
  final bool isStaff;

  const GetAccountResponse(
      {required this.id,
      required this.username,
      required this.email,
      required this.dateJoined,
      required this.canTrade,
      this.bankAccount,
      this.personalInfo,
      this.residenceInfo,
      this.employmentInfo,
      this.agreements,
      this.lastJourney,
      required this.isStaff});

  factory GetAccountResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAccountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAccountResponseToJson(this);

  String get idStr {
    return id == 0 ? '-' : id.toString();
  }

  String get dateJoinedFormatted => formatDateTimeAsString(dateJoined);

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        canTrade,
        dateJoined,
        bankAccount,
        personalInfo,
        residenceInfo,
        employmentInfo,
        agreements,
        lastJourney,
        isStaff,
      ];
}

@JsonSerializable()
class LastJourney extends Equatable {
  @JsonKey(name: 'user_journey')
  final String userJourney;
  @JsonKey(name: 'data')
  final String? signature;

  const LastJourney({
    required this.userJourney,
    this.signature,
  });

  factory LastJourney.fromJson(Map<String, dynamic> json) =>
      _$LastJourneyFromJson(json);

  Map<String, dynamic> toJson() => _$LastJourneyToJson(this);

  @override
  String toString() =>
      'LastJourney(userJourney: $userJourney, signature: $signature)';

  @override
  List<Object?> get props => [userJourney, signature];
}
