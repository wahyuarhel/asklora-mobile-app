part of 'account_information_bloc.dart';

class AccountInformationState extends Equatable {
  final BaseResponse<GetAccountResponse> response;

  const AccountInformationState({
    this.response = const BaseResponse(),
  });

  @override
  List<Object> get props => [response];

  AccountInformationState copyWith({
    BaseResponse<GetAccountResponse>? response,
  }) {
    return AccountInformationState(
      response: response ?? this.response,
    );
  }
}
