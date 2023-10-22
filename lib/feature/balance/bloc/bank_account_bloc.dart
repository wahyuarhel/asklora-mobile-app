import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/base_response.dart';
import '../../balance/deposit/utils/deposit_utils.dart';
import '../repository/bank_account_repository.dart';

part 'bank_account_event.dart';

part 'bank_account_state.dart';

class BankAccountBloc extends Bloc<BankAccountEvent, BankAccountState> {
  BankAccountBloc({required BankAccountRepository bankAccountRepository})
      : _bankAccountRepository = bankAccountRepository,
        super(const BankAccountState()) {
    on<RegisteredBankAccountCheck>(_onRegisteredBankAccountCheck);
  }

  final BankAccountRepository _bankAccountRepository;

  void _onRegisteredBankAccountCheck(
      RegisteredBankAccountCheck event, Emitter<BankAccountState> emit) async {
    DepositType depositType = DepositType.firstTime;
    try {
      emit(state.copyWith(response: BaseResponse.loading()));
      var response = await _bankAccountRepository.getBankAccount();

      if (response.data!.fpsBankAccounts!.isNotEmpty ||
          response.data!.wireBankAccounts!.isNotEmpty) {
        depositType = DepositType.type2;
      } else {
        depositType = DepositType.firstTime;
      }
      emit(state.copyWith(
        response: response,
        depositType: depositType,
      ));
    } catch (e) {
      emit(state.copyWith(
          response: BaseResponse.error(), depositType: depositType));
    }
  }
}
