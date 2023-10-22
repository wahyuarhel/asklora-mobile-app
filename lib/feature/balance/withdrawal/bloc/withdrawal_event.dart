part of 'withdrawal_bloc.dart';

abstract class WithdrawalEvent extends Equatable {
  const WithdrawalEvent() : super();

  @override
  List<Object?> get props => [];
}

class WithdrawalAmountChanged extends WithdrawalEvent {
  final String withdrawalAmount;

  const WithdrawalAmountChanged(this.withdrawalAmount) : super();

  @override
  List<Object?> get props => [withdrawalAmount];
}

class SubmitWithdrawal extends WithdrawalEvent {
  final String withdrawalAmount;

  const SubmitWithdrawal(this.withdrawalAmount);
}

class ResetWithdrawalResponse extends WithdrawalEvent {}
