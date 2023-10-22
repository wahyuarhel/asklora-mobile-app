import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/remote/base_api_client.dart';
import '../../../../core/domain/base_response.dart';
import '../../../../core/repository/transaction_repository.dart';
import '../domain/withdrawal_request.dart';
import '../domain/withdrawal_response.dart';

part 'withdrawal_event.dart';

part 'withdrawal_state.dart';

class WithdrawalBloc extends Bloc<WithdrawalEvent, WithdrawalState> {
  WithdrawalBloc({required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository,
        super(const WithdrawalState()) {
    on<WithdrawalAmountChanged>(_onWithdrawalAmountChanged);
    on<SubmitWithdrawal>(_onSubmitWithdrawal);
    on<ResetWithdrawalResponse>(_onResetWithdrawalResponse);
  }

  final TransactionRepository _transactionRepository;

  void _onResetWithdrawalResponse(
      ResetWithdrawalResponse event, Emitter<WithdrawalState> emit) {
    emit(state.copyWith(response: const BaseResponse()));
  }

  void _onWithdrawalAmountChanged(
      WithdrawalAmountChanged event, Emitter<WithdrawalState> emit) {
    emit(state.copyWith(
      withdrawalAmount: event.withdrawalAmount,
      withdrawalAmountErrorText: '',
    ));
  }

  void _onSubmitWithdrawal(
      SubmitWithdrawal event, Emitter<WithdrawalState> emit) async {
    try {
      emit(state.copyWith(response: BaseResponse.loading()));
      var data = await _transactionRepository.submitWithdrawal(
          withdrawalRequest: WithdrawalRequest(amount: event.withdrawalAmount));
      emit(state.copyWith(response: data));
    } on AskloraApiClientException catch (e) {
      emit(state.copyWith(
          response: BaseResponse.error(validationCode: e.askloraError.type)));
    }
    /*on LegalReasonException {
      emit(state.copyWith(response: BaseResponse.suspended()));
    }*/
    catch (e) {
      emit(state.copyWith(response: BaseResponse.error()));
    }
  }
}
