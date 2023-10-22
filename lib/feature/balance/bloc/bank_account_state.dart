part of 'bank_account_bloc.dart';

class BankAccountState extends Equatable {
  final BaseResponse response;
  final DepositType depositType;

  const BankAccountState({
    this.response = const BaseResponse(),
    this.depositType = DepositType.firstTime,
  }) : super();

  @override
  List<Object?> get props => [response, depositType];

  BankAccountState copyWith({
    BaseResponse? response,
    DepositType? depositType,
  }) {
    return BankAccountState(
      response: response ?? this.response,
      depositType: depositType ?? this.depositType,
    );
  }
}
