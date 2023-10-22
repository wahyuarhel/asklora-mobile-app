import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/bloc/app_bloc.dart';
import '../../../../app/repository/user_journey_repository.dart';
import '../../../../core/domain/base_response.dart';
import '../domain/onfido/onfido_result_request.dart';
import '../domain/onfido/onfido_result_response.dart';
import '../domain/upgrade_account/save_kyc_request.dart';
import '../domain/upgrade_account/upgrade_account_request.dart';
import '../repository/account_repository.dart';

part 'kyc_event.dart';

part 'kyc_state.dart';

class KycBloc extends Bloc<KycEvent, KycState> {
  KycBloc(
      {required AccountRepository accountRepository,
      required UserJourneyRepository userJourneyRepository})
      : _accountRepository = accountRepository,
        _userJourneyRepository = userJourneyRepository,
        super(const KycState()) {
    on<GetSdkToken>(_onGetOnfidoSdkToken);
    on<UpdateOnfidoResult>(_onUpdateOnfidoResult);
    on<SubmitKyc>(_onSubmitKyc);
    on<SaveKyc>(_onSaveKyc);
    on<FetchKyc>(_onFetchKyc);
  }

  final AccountRepository _accountRepository;
  final UserJourneyRepository _userJourneyRepository;

  _onSubmitKyc(SubmitKyc event, Emitter<KycState> emit) async {
    emit(state.copyWith(submitKycResponse: BaseResponse.loading()));
    try {
      var data =
          await _accountRepository.submitIBKR(event.upgradeAccountRequest);
      emit(state.copyWith(submitKycResponse: data));
    } catch (e) {
      emit(state.copyWith(submitKycResponse: BaseResponse.error()));
    }
  }

  _onSaveKyc(SaveKyc event, Emitter<KycState> emit) async {
    emit(state.copyWith(saveKycResponse: BaseResponse.loading()));
    try {
      emit(state.copyWith(
          saveKycResponse: await _userJourneyRepository.saveUserJourney(
              userJourney: UserJourney.kyc,
              data: event.saveKycRequest.toString())));
    } catch (e) {
      emit(state.copyWith(saveKycResponse: BaseResponse.error()));
    }
  }

  _onFetchKyc(FetchKyc event, Emitter<KycState> emit) async {
    emit(state.copyWith(fetchKycResponse: BaseResponse.loading()));
    try {
      var userJourneyResponse =
          await _userJourneyRepository.getUserJourneyWithData();
      if (userJourneyResponse.data!.userJourney == UserJourney.kyc.value) {
        emit(state.copyWith(
            fetchKycResponse: BaseResponse.complete(SaveKycRequest.fromJson(
                jsonDecode(userJourneyResponse.data!.data!)))));
      } else {
        emit(state.copyWith(fetchKycResponse: BaseResponse.error()));
      }
    } catch (e) {
      emit(state.copyWith(fetchKycResponse: BaseResponse.error()));
    }
  }

  _onGetOnfidoSdkToken(GetSdkToken event, Emitter<KycState> emit) async {
    emit(state.copyWith(onfidoResponse: BaseResponse.loading()));
    var response = await _accountRepository.getOnfidoToken();
    if (response.state == ResponseState.success) {
      emit(OnfidoSdkToken(response.data!.token));
    } else {
      emit(state.copyWith(onfidoResponse: response));
    }
  }

  _onUpdateOnfidoResult(
      UpdateOnfidoResult event, Emitter<KycState> emit) async {
    emit(state.copyWith(onfidoResponse: BaseResponse.loading()));
    var response = await _accountRepository.submitOnfidoOutcome(
        OnfidoResultRequest(event.token, event.reason, event.outcome));

    if (response.state == ResponseState.success) {
      emit(OnfidoResultUpdated(response.data!));
    } else {
      emit(state.copyWith(onfidoResponse: response));
    }
  }
}
