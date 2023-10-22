import 'package:asklora_mobile_app/core/domain/base_response.dart';
import 'package:asklora_mobile_app/core/repository/transaction_repository.dart';
import 'package:asklora_mobile_app/feature/balance/deposit/bloc/deposit_bloc.dart';
import 'package:asklora_mobile_app/feature/balance/deposit/domain/deposit_response.dart';
import 'package:asklora_mobile_app/feature/balance/deposit/utils/deposit_utils.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'deposit_bloc_test.mocks.dart';

@GenerateMocks([TransactionRepository])
void main() async {
  group('Deposit Bloc Tests', () {
    late DepositBloc depositBloc;
    late TransactionRepository transactionRepository;
    final BaseResponse<DepositResponse> submitResponse =
        BaseResponse.complete(const DepositResponse(''));

    final BaseResponse<DepositResponse> errorResponse = BaseResponse.error();

    setUpAll(() async {
      transactionRepository = MockTransactionRepository();
    });
    setUp(() async {
      depositBloc = DepositBloc(
          transactionRepository: transactionRepository,
          depositType: DepositType.firstTime);
    });

    test('Deposit Bloc init state should be default one', () {
      expect(depositBloc.state, const DepositState());
    });

    blocTest<DepositBloc, DepositState>(
        'emits `depositAmount = 200` WHEN '
        'changed deposit amount to 200',
        build: () => depositBloc,
        act: (bloc) => bloc.add(const DepositAmountChanged(200)),
        expect: () => {
              const DepositState(depositAmount: 200),
            });

    blocTest<DepositBloc, DepositState>(
        'emits `PlatformFile(name: `test_file`, size: 2000)` WHEN '
        'picking some file',
        build: () => depositBloc,
        act: (bloc) => bloc.add(
              ProofOfRemittanceImagesChanged(
                [
                  PlatformFile(name: 'test_file', size: 2000),
                ],
              ),
            ),
        expect: () => {
              const DepositState(proofOfRemittanceImages: []),
              DepositState(proofOfRemittanceImages: [
                PlatformFile(name: 'test_file', size: 2000)
              ]),
            });

    blocTest<DepositBloc, DepositState>(
        'emits `zero proof of remittance images` WHEN '
        'add file and then delete the file',
        build: () => depositBloc,
        act: (bloc) => {
              bloc.add(
                ProofOfRemittanceImagesChanged(
                  [
                    PlatformFile(name: 'test_file', size: 2000),
                  ],
                ),
              ),
              bloc.add(ProofOfRemittanceImageDeleted(
                  PlatformFile(name: 'test_file', size: 2000))),
            },
        expect: () => {
              const DepositState(
                proofOfRemittanceImages: [],
              ),
              DepositState(
                proofOfRemittanceImages: [
                  PlatformFile(name: 'test_file', size: 2000),
                ],
              )
            });

    blocTest<DepositBloc, DepositState>(
        'emits `BaseResponse.success` WHEN '
        'submit deposit',
        build: () {
          when(transactionRepository.submitDeposit(
                  depositAmount: 20000,
                  platformFiles: [PlatformFile(name: 'test_file', size: 2000)]))
              .thenAnswer((_) => Future.value(submitResponse));
          return depositBloc;
        },
        act: (bloc) => {
              bloc.add(const DepositAmountChanged(20000)),
              bloc.add(ProofOfRemittanceImagesChanged(
                [
                  PlatformFile(name: 'test_file', size: 2000),
                ],
              )),
              bloc.add(SubmitDeposit())
            },
        expect: () => {
              const DepositState(depositAmount: 20000),
              DepositState(depositAmount: 20000, proofOfRemittanceImages: [
                PlatformFile(name: 'test_file', size: 2000)
              ]),
              DepositState(
                  response: BaseResponse.loading(),
                  depositAmount: 20000,
                  proofOfRemittanceImages: [
                    PlatformFile(name: 'test_file', size: 2000)
                  ]),
              DepositState(
                  response: submitResponse,
                  depositAmount: 20000,
                  proofOfRemittanceImages: [
                    PlatformFile(name: 'test_file', size: 2000)
                  ]),
            });

    blocTest<DepositBloc, DepositState>(
        'emits `BaseResponse.error` WHEN '
        'failed submit deposit',
        build: () {
          when(transactionRepository.submitDeposit(
                  depositAmount: 20000,
                  platformFiles: [PlatformFile(name: 'test_file', size: 2000)]))
              .thenThrow(errorResponse);
          return depositBloc;
        },
        act: (bloc) => {
              bloc.add(const DepositAmountChanged(20000)),
              bloc.add(ProofOfRemittanceImagesChanged(
                [
                  PlatformFile(name: 'test_file', size: 2000),
                ],
              )),
              bloc.add(SubmitDeposit())
            },
        expect: () => {
              const DepositState(depositAmount: 20000),
              DepositState(depositAmount: 20000, proofOfRemittanceImages: [
                PlatformFile(name: 'test_file', size: 2000)
              ]),
              DepositState(
                  response: BaseResponse.loading(),
                  depositAmount: 20000,
                  proofOfRemittanceImages: [
                    PlatformFile(name: 'test_file', size: 2000)
                  ]),
              DepositState(
                  response: errorResponse,
                  depositAmount: 20000,
                  proofOfRemittanceImages: [
                    PlatformFile(name: 'test_file', size: 2000)
                  ]),
            });

    blocTest<DepositBloc, DepositState>(
        'emits `BaseResponse.unknown` WHEN '
        'failed submit deposit and reset deposit response',
        build: () {
          when(transactionRepository.submitDeposit(
                  depositAmount: 20000,
                  platformFiles: [PlatformFile(name: 'test_file', size: 2000)]))
              .thenThrow(errorResponse);
          return depositBloc;
        },
        act: (bloc) => {
              bloc.add(const DepositAmountChanged(20000)),
              bloc.add(ProofOfRemittanceImagesChanged(
                [
                  PlatformFile(name: 'test_file', size: 2000),
                ],
              )),
              bloc.add(SubmitDeposit()),
              bloc.add(ResetDepositResponse())
            },
        expect: () => {
              const DepositState(depositAmount: 20000),
              DepositState(depositAmount: 20000, proofOfRemittanceImages: [
                PlatformFile(name: 'test_file', size: 2000)
              ]),
              DepositState(
                  response: BaseResponse.loading(),
                  depositAmount: 20000,
                  proofOfRemittanceImages: [
                    PlatformFile(name: 'test_file', size: 2000)
                  ]),
              DepositState(
                  response: errorResponse,
                  depositAmount: 20000,
                  proofOfRemittanceImages: [
                    PlatformFile(name: 'test_file', size: 2000)
                  ]),
              DepositState(
                  response: const BaseResponse<DepositResponse>(),
                  depositAmount: 20000,
                  proofOfRemittanceImages: [
                    PlatformFile(name: 'test_file', size: 2000)
                  ]),
            });

    tearDown(() => {depositBloc.close()});
  });
}
