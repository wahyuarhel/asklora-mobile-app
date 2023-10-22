part of 'account_information_bloc.dart';

abstract class AccountInformationEvent extends Equatable {
  const AccountInformationEvent();

  @override
  List<Object> get props => [];
}

class GetAccountInformation extends AccountInformationEvent {}

class GetLocalAccountInformation extends AccountInformationEvent {}

class InitiateAccountInformationData extends AccountInformationEvent {
  final BaseResponse<GetAccountResponse> data;
  const InitiateAccountInformationData(this.data);
}
