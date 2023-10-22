import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/base_response.dart';
import '../../../onboarding/kyc/domain/get_account/get_account_response.dart';
import '../../../onboarding/kyc/repository/account_repository.dart';

part 'account_information_event.dart';

part 'account_information_state.dart';

class AccountInformationBloc
    extends Bloc<AccountInformationEvent, AccountInformationState> {
  final AccountRepository _accountRepository;

  AccountInformationBloc({required AccountRepository accountRepository})
      : _accountRepository = accountRepository,
        super(const AccountInformationState()) {
    on<GetAccountInformation>(_onGetAccountInformation);
    on<GetLocalAccountInformation>(_onGetLocalAccountInformation);
    on<InitiateAccountInformationData>(_onInitiateAccountInformationData);
  }

  _onInitiateAccountInformationData(InitiateAccountInformationData event,
      Emitter<AccountInformationState> emit) async {
    emit(state.copyWith(response: BaseResponse.loading()));
    emit(state.copyWith(response: event.data));
  }

  _onGetAccountInformation(GetAccountInformation event,
      Emitter<AccountInformationState> emit) async {
    ///preserving previous data in the state
    ///so the UI would not need to rebuild if the previous data == current data
    emit(state.copyWith(
        response: BaseResponse.loading(previousData: state.response.data)));
    var response = await _accountRepository.getAccount();
    emit(state.copyWith(response: response));
  }

  _onGetLocalAccountInformation(GetLocalAccountInformation event,
      Emitter<AccountInformationState> emit) async {
    emit(state.copyWith(response: BaseResponse.loading()));
    var response = await _accountRepository.getLocalAccount();
    emit(state.copyWith(response: response));
  }
}
