part of 'bank_account_bloc.dart';

abstract class BankAccountEvent extends Equatable {
  const BankAccountEvent() : super();

  @override
  List<Object?> get props => [];
}

class RegisteredBankAccountCheck extends BankAccountEvent {
  const RegisteredBankAccountCheck() : super();

  @override
  List<Object?> get props => [];
}
