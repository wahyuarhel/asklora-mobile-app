import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/remote/base_api_client.dart';
import '../../../../core/domain/base_response.dart';
import '../../../../core/repository/transaction_repository.dart';
import '../../../../core/utils/extensions.dart';
import '../domain/deposit_response.dart';
import '../utils/deposit_utils.dart';

part 'deposit_event.dart';

part 'deposit_state.dart';

class DepositBloc extends Bloc<DepositEvent, DepositState> {
  DepositBloc(
      {required TransactionRepository transactionRepository,
      required this.depositType})
      : _transactionRepository = transactionRepository,
        super(const DepositState()) {
    on<DepositAmountChanged>(_onDepositAmountChanged);
    on<ProofOfRemittanceImagesChanged>(_onProofOfRemittanceImagesChanged);
    on<ProofOfRemittanceImageDeleted>(_onProofOfRemittanceImageDeleted);
    on<SubmitDeposit>(_onSubmitDeposit);
    on<ResetDepositResponse>(_onResetDepositResponse);
  }

  final TransactionRepository _transactionRepository;
  final DepositType depositType;

  void _onResetDepositResponse(
      ResetDepositResponse event, Emitter<DepositState> emit) {
    emit(state.copyWith(response: const BaseResponse()));
  }

  void _onDepositAmountChanged(
      DepositAmountChanged event, Emitter<DepositState> emit) {
    emit(state.copyWith(
      depositAmount: event.depositAmount,
      depositAmountErrorText: '',
    ));
  }

  _onProofOfRemittanceImagesChanged(
      ProofOfRemittanceImagesChanged event, Emitter<DepositState> emit) {
    emit(state.copyWith(proofOfRemittanceImagesErrorText: ''));
    List<PlatformFile> images = List.from(state.proofOfRemittanceImages);
    images.addAll(event.images);
    if (images.length > maximumProofOfRemittanceImagesAllowed) {
      emit(state.copyWith(
          proofOfRemittanceImagesErrorText:
              'Maximum number of images allowed is $maximumProofOfRemittanceImagesAllowed'));
    } else {
      emit(state.copyWith(proofOfRemittanceImages: images));
    }
  }

  _onProofOfRemittanceImageDeleted(
      ProofOfRemittanceImageDeleted event, Emitter<DepositState> emit) {
    List<PlatformFile> images = List.from(state.proofOfRemittanceImages);
    images.remove(event.image);
    emit(state.copyWith(proofOfRemittanceImages: images));
  }

  void _onSubmitDeposit(SubmitDeposit event, Emitter<DepositState> emit) async {
    try {
      if (_isBelowMinAmount) {
        emit(state.copyWith(depositAmountErrorText: _getAmountErrorText));
      } else {
        emit(state.copyWith(response: BaseResponse.loading()));
        var data = await _transactionRepository.submitDeposit(
            depositAmount: state.depositAmount,
            platformFiles: state.proofOfRemittanceImages);
        emit(state.copyWith(response: data));
      }
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

  bool get _isBelowMinAmount {
    return state.depositAmount < depositType.minDeposit;
  }

  String get _getAmountErrorText =>
      'The minimum deposit amount is HKD${depositType.minDeposit.convertToCurrencyDecimal()}';
}
