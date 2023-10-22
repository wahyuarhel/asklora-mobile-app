import 'package:asklora_mobile_app/core/domain/base_response.dart';
import 'package:asklora_mobile_app/feature/transaction_history/bloc/transaction_history_bloc.dart';
import 'package:asklora_mobile_app/feature/transaction_history/domain/grouped_model.dart';
import 'package:asklora_mobile_app/feature/transaction_history/domain/grouped_transaction_model.dart';
import 'package:asklora_mobile_app/feature/transaction_history/domain/transaction_history_model.dart';
import 'package:asklora_mobile_app/core/repository/transaction_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'transaction_history_bloc_test.mocks.dart';

@GenerateMocks([TransactionRepository])
void main() async {
  group('Transaction History Bloc Tests', () {
    late MockTransactionRepository transactionRepository;
    late TransactionHistoryBloc transactionHistoryBloc;

    final BaseResponse<List<GroupedTransactionModel>>
        allTransactionSuccessResponse = BaseResponse.complete([
      const GroupedTransactionModel(
          groupType: GroupType.others,
          groupTitle: '2023-04-01',
          data: [
            TransactionHistoryModel('1', TransactionHistoryType.bot,
                '2023-04-01', '2023-04-01', 'AAPL', 'place', '2000'),
            TransactionHistoryModel('1', TransactionHistoryType.bot,
                '2023-04-01', '2023-04-01', 'BMW', 'place', '2500'),
            TransactionHistoryModel('1', TransactionHistoryType.bot,
                '2023-04-01', '2023-04-01', 'WITHDRAW', 'success', '2000'),
            TransactionHistoryModel('1', TransactionHistoryType.bot,
                '2023-04-01', '2023-04-01', 'WITHDRAW', 'success', '2500'),
          ]),
      const GroupedTransactionModel(
          groupType: GroupType.others,
          groupTitle: '2023-04-02',
          data: [
            TransactionHistoryModel('1', TransactionHistoryType.bot,
                '2023-04-02', '2023-04-02', 'FORD', 'place', '1000'),
            TransactionHistoryModel('1', TransactionHistoryType.transfer,
                '2023-04-02', '2023-04-02', 'DEPOSIT', 'success', '1000'),
          ]),
    ]);

    final BaseResponse<List<GroupedTransactionModel>>
        botTransactionSuccessResponse = BaseResponse.complete([
      const GroupedTransactionModel(
          groupType: GroupType.others,
          groupTitle: '2023-04-01',
          data: [
            TransactionHistoryModel('1', TransactionHistoryType.bot,
                '2023-04-01', '2023-04-01', 'AAPL', 'place', '2000'),
            TransactionHistoryModel('1', TransactionHistoryType.bot,
                '2023-04-01', '2023-04-01', 'BMW', 'place', '2500'),
          ]),
      const GroupedTransactionModel(
          groupType: GroupType.others,
          groupTitle: '2023-04-02',
          data: [
            TransactionHistoryModel('1', TransactionHistoryType.bot,
                '2023-04-02', '2023-04-02', 'FORD', 'place', '1000'),
          ]),
    ]);

    final BaseResponse<List<GroupedTransactionModel>>
        transferTransactionSuccessResponse = BaseResponse.complete([
      const GroupedTransactionModel(
          groupType: GroupType.others,
          groupTitle: '2023-04-01',
          data: [
            TransactionHistoryModel('1', TransactionHistoryType.transfer,
                '2023-04-01', '2023-04-01', 'WITHDRAW', 'success', '2000'),
            TransactionHistoryModel('1', TransactionHistoryType.transfer,
                '2023-04-01', '2023-04-01', 'WITHDRAW', 'success', '2500'),
          ]),
      const GroupedTransactionModel(
          groupType: GroupType.others,
          groupTitle: '2023-04-02',
          data: [
            TransactionHistoryModel('1', TransactionHistoryType.transfer,
                '2023-04-02', '2023-04-02', 'DEPOSIT', 'success', '1000'),
          ]),
    ]);

    final BaseResponse<List<GroupedTransactionModel>> errorResponse =
        BaseResponse.error();

    setUpAll(() async {
      transactionRepository = MockTransactionRepository();
    });

    setUp(() async {
      transactionHistoryBloc = TransactionHistoryBloc(
          transactionHistoryRepository: transactionRepository);
    });

    test('Transaction History Bloc init state response should be default one',
        () {
      expect(transactionHistoryBloc.state, const TransactionHistoryState());
    });

    blocTest<TransactionHistoryBloc, TransactionHistoryState>(
        'emits `BaseResponse.complete` WHEN '
        'fetching all transaction history',
        build: () {
          when(transactionRepository.fetchAllTransactionsHistory())
              .thenAnswer((_) => Future.value(allTransactionSuccessResponse));
          return transactionHistoryBloc;
        },
        act: (bloc) => bloc.add(FetchAllTransaction()),
        expect: () => {
              TransactionHistoryState(
                  allTransactionsResponse: BaseResponse.loading()),
              TransactionHistoryState(
                  allTransactionsResponse: allTransactionSuccessResponse),
            });

    blocTest<TransactionHistoryBloc, TransactionHistoryState>(
        'emits `BaseResponse.error` WHEN '
        'failed fetching all transaction history',
        build: () {
          when(transactionRepository.fetchAllTransactionsHistory())
              .thenAnswer((_) => Future.value(errorResponse));
          return transactionHistoryBloc;
        },
        act: (bloc) => bloc.add(FetchAllTransaction()),
        expect: () => {
              TransactionHistoryState(
                  allTransactionsResponse: BaseResponse.loading()),
              TransactionHistoryState(allTransactionsResponse: errorResponse),
            });

    blocTest<TransactionHistoryBloc, TransactionHistoryState>(
        'emits `BaseResponse.complete` WHEN '
        'fetching bot transaction history',
        build: () {
          when(transactionRepository.fetchBotTransactionsHistory())
              .thenAnswer((_) => Future.value(botTransactionSuccessResponse));
          return transactionHistoryBloc;
        },
        act: (bloc) => bloc.add(FetchBotTransaction()),
        expect: () => {
              TransactionHistoryState(
                  botTransactionsResponse: BaseResponse.loading()),
              TransactionHistoryState(
                  botTransactionsResponse: botTransactionSuccessResponse),
            });

    blocTest<TransactionHistoryBloc, TransactionHistoryState>(
        'emits `BaseResponse.error` WHEN '
        'failed fetching bot transaction history',
        build: () {
          when(transactionRepository.fetchBotTransactionsHistory())
              .thenAnswer((_) => Future.value(errorResponse));
          return transactionHistoryBloc;
        },
        act: (bloc) => bloc.add(FetchBotTransaction()),
        expect: () => {
              TransactionHistoryState(
                  botTransactionsResponse: BaseResponse.loading()),
              TransactionHistoryState(botTransactionsResponse: errorResponse),
            });

    blocTest<TransactionHistoryBloc, TransactionHistoryState>(
        'emits `BaseResponse.complete` WHEN '
        'fetching transfer transaction history',
        build: () {
          when(transactionRepository.fetchTransferTransactionsHistory())
              .thenAnswer(
                  (_) => Future.value(transferTransactionSuccessResponse));
          return transactionHistoryBloc;
        },
        act: (bloc) => bloc.add(FetchTransferTransaction()),
        expect: () => {
              TransactionHistoryState(
                  transferTransactionsResponse: BaseResponse.loading()),
              TransactionHistoryState(
                  transferTransactionsResponse:
                      transferTransactionSuccessResponse),
            });

    blocTest<TransactionHistoryBloc, TransactionHistoryState>(
        'emits `BaseResponse.error` WHEN '
        'failed fetching transfer transaction history',
        build: () {
          when(transactionRepository.fetchTransferTransactionsHistory())
              .thenAnswer((_) => Future.value(errorResponse));
          return transactionHistoryBloc;
        },
        act: (bloc) => bloc.add(FetchTransferTransaction()),
        expect: () => {
              TransactionHistoryState(
                  transferTransactionsResponse: BaseResponse.loading()),
              TransactionHistoryState(
                  transferTransactionsResponse: errorResponse),
            });

    tearDown(() => {transactionHistoryBloc.close()});
  });
}
