import 'package:asklora_mobile_app/core/domain/base_response.dart';
import 'package:asklora_mobile_app/core/domain/transaction/transaction_balance_response.dart';
import 'package:asklora_mobile_app/core/utils/currency_enum.dart';
import 'package:asklora_mobile_app/feature/bot_stock/domain/orders/bot_active_order_model.dart';
import 'package:asklora_mobile_app/feature/bot_stock/domain/orders/bot_order_response.dart';
import 'package:asklora_mobile_app/feature/bot_stock/presentation/portfolio/bloc/portfolio_bloc.dart';
import 'package:asklora_mobile_app/feature/bot_stock/repository/bot_stock_repository.dart';
import 'package:asklora_mobile_app/feature/bot_stock/utils/bot_stock_utils.dart';
import 'package:asklora_mobile_app/core/repository/transaction_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'portfolio_bloc_test.mocks.dart';

@GenerateMocks([BotStockRepository])
@GenerateMocks([TransactionRepository])
void main() async {
  group('Portfolio Bloc Tests', () {
    late MockBotStockRepository botStockRepository;
    late MockTransactionRepository transactionRepository;
    late PortfolioBloc portfolioBloc;

    final BaseResponse<List<BotActiveOrderModel>> response =
        BaseResponse.complete([]);

    final BaseResponse<List<BotActiveOrderModel>> errorResponse =
        BaseResponse.error();

    final BaseResponse<TransactionBalanceResponse> transactionBalanceResponse =
        BaseResponse.complete(const TransactionBalanceResponse(
            20, 20, 20, 20, 20, 20, 20, 20, 20));

    final BaseResponse<TransactionBalanceResponse>
        transactionBalanceErrorResponse = BaseResponse.error();

    final BaseResponse<TerminateOrderResponse> terminateOrderResponse =
        BaseResponse.complete(TerminateOrderResponse('a', ''));

    final BaseResponse<TerminateOrderResponse> terminateOrderErrorResponse =
        BaseResponse.error();

    final BaseResponse<RolloverOrderResponse> rolloverOrderResponse =
        BaseResponse.complete(RolloverOrderResponse('a', ''));

    final BaseResponse<RolloverOrderResponse> rolloverOrderErrorResponse =
        BaseResponse.error();

    final BaseResponse<BotOrderResponse> botOrderResponse =
        BaseResponse.complete(RolloverOrderResponse('a', ''));

    final BaseResponse<BotOrderResponse> botOrderErrorResponse =
        BaseResponse.error();

    setUpAll(() async {
      botStockRepository = MockBotStockRepository();
      transactionRepository = MockTransactionRepository();
    });

    setUp(() async {
      portfolioBloc = PortfolioBloc(
          botStockRepository: botStockRepository,
          transactionHistoryRepository: transactionRepository);
    });

    test('Portfolio Bloc init state response should be default one', () {
      expect(portfolioBloc.state, const PortfolioState());
    });

    blocTest<PortfolioBloc, PortfolioState>(
        'init HKD to default of the  currency',
        build: () => portfolioBloc,
        act: (bloc) => {bloc.add(const CurrencyChanged(CurrencyType.hkd))},
        expect: () => {const PortfolioState(currency: CurrencyType.hkd)});

    blocTest<PortfolioBloc, PortfolioState>('change currency from HKD to USD',
        build: () => portfolioBloc,
        act: (bloc) => {
              bloc.add(const CurrencyChanged(CurrencyType.hkd)),
              bloc.add(const CurrencyChanged(CurrencyType.usd)),
            },
        expect: () => {
              const PortfolioState(currency: CurrencyType.hkd),
              const PortfolioState(currency: CurrencyType.usd),
            });

    blocTest<PortfolioBloc, PortfolioState>('change currency from USD to HKD',
        build: () => portfolioBloc,
        act: (bloc) => {
              bloc.add(const CurrencyChanged(CurrencyType.usd)),
              bloc.add(const CurrencyChanged(CurrencyType.hkd)),
            },
        expect: () => {
              const PortfolioState(currency: CurrencyType.usd),
              const PortfolioState(currency: CurrencyType.hkd),
            });

    blocTest<PortfolioBloc, PortfolioState>('check active filter',
        build: () {
          when(botStockRepository.activeOrders(status: [
            OmsStatus.live.value,
            OmsStatus.nearlyKnockOut.value,
            OmsStatus.waitingTermination.value,
            OmsStatus.initialized.value,
            OmsStatus.indicative.value,
          ])).thenAnswer((_) => Future.value(response));
          return portfolioBloc;
        },
        act: (bloc) => {
              bloc.add(const ActiveFilterChecked(true)),
            },
        expect: () => {
              const PortfolioState(activeFilterChecked: true),
              PortfolioState(
                  activeFilterChecked: true,
                  botActiveOrderResponse: BaseResponse.loading()),
              PortfolioState(
                  activeFilterChecked: true, botActiveOrderResponse: response),
            });

    blocTest<PortfolioBloc, PortfolioState>('uncheck active filter',
        build: () {
          when(botStockRepository.activeOrders(status: [
            OmsStatus.initialized.value,
            OmsStatus.indicative.value,
          ])).thenAnswer((_) => Future.value(response));
          return portfolioBloc;
        },
        act: (bloc) => {
              bloc.add(const ActiveFilterChecked(false)),
            },
        expect: () => {
              const PortfolioState(activeFilterChecked: false),
              PortfolioState(
                  activeFilterChecked: false,
                  botActiveOrderResponse: BaseResponse.loading()),
              PortfolioState(
                  activeFilterChecked: false, botActiveOrderResponse: response),
            });

    blocTest<PortfolioBloc, PortfolioState>('check pending filter',
        build: () {
          when(botStockRepository.activeOrders(status: [
            OmsStatus.live.value,
            OmsStatus.nearlyKnockOut.value,
            OmsStatus.waitingTermination.value,
            OmsStatus.initialized.value,
            OmsStatus.indicative.value,
          ])).thenAnswer((_) => Future.value(response));
          return portfolioBloc;
        },
        act: (bloc) => {
              bloc.add(const PendingFilterChecked(true)),
            },
        expect: () => {
              const PortfolioState(pendingFilterChecked: true),
              PortfolioState(
                  pendingFilterChecked: true,
                  botActiveOrderResponse: BaseResponse.loading()),
              PortfolioState(
                  pendingFilterChecked: true, botActiveOrderResponse: response),
            });

    blocTest<PortfolioBloc, PortfolioState>('uncheck pending filter',
        build: () {
          when(botStockRepository.activeOrders(status: [
            OmsStatus.live.value,
            OmsStatus.nearlyKnockOut.value,
            OmsStatus.waitingTermination.value,
          ])).thenAnswer((_) => Future.value(response));
          return portfolioBloc;
        },
        act: (bloc) => {
              bloc.add(const PendingFilterChecked(false)),
            },
        expect: () => {
              const PortfolioState(pendingFilterChecked: false),
              PortfolioState(
                  pendingFilterChecked: false,
                  botActiveOrderResponse: BaseResponse.loading()),
              PortfolioState(
                  pendingFilterChecked: false,
                  botActiveOrderResponse: response),
            });

    blocTest<PortfolioBloc, PortfolioState>(
        'emits `BaseResponse.complete` WHEN '
        'fetching bot portfolio',
        build: () {
          when(botStockRepository.activeOrders(status: [
            OmsStatus.live.value,
            OmsStatus.nearlyKnockOut.value,
            OmsStatus.waitingTermination.value,
            OmsStatus.initialized.value,
            OmsStatus.indicative.value,
          ])).thenAnswer((_) => Future.value(response));
          return portfolioBloc;
        },
        act: (bloc) => bloc.add(const FetchActiveOrders()),
        expect: () => {
              PortfolioState(botActiveOrderResponse: BaseResponse.loading()),
              PortfolioState(botActiveOrderResponse: response)
            });

    blocTest<PortfolioBloc, PortfolioState>(
        'emits `BaseResponse.error` WHEN '
        'failed fetching bot portfolio',
        build: () {
          when(botStockRepository.activeOrders(status: [
            OmsStatus.live.value,
            OmsStatus.nearlyKnockOut.value,
            OmsStatus.waitingTermination.value,
            OmsStatus.initialized.value,
            OmsStatus.indicative.value,
          ])).thenAnswer((_) => Future.value(errorResponse));
          return portfolioBloc;
        },
        act: (bloc) => bloc
            .add(const FetchActiveOrders(botStockFilter: BotStockFilter.all)),
        expect: () => {
              PortfolioState(botActiveOrderResponse: BaseResponse.loading()),
              PortfolioState(botActiveOrderResponse: errorResponse)
            });

    blocTest<PortfolioBloc, PortfolioState>(
        'emits `BaseResponse.complete` WHEN '
        'fetching portfolio balance',
        build: () {
          when(transactionRepository.fetchBalance())
              .thenAnswer((_) => Future.value(transactionBalanceResponse));
          return portfolioBloc;
        },
        act: (bloc) => bloc.add(FetchBalance()),
        expect: () => {
              PortfolioState(
                  transactionBalanceResponse: BaseResponse.loading()),
              PortfolioState(
                  transactionBalanceResponse: transactionBalanceResponse)
            });

    blocTest<PortfolioBloc, PortfolioState>(
        'emits `BaseResponse.error` WHEN '
        'failed portfolio balance',
        build: () {
          when(transactionRepository.fetchBalance())
              .thenAnswer((_) => Future.value(transactionBalanceErrorResponse));
          return portfolioBloc;
        },
        act: (bloc) => bloc.add(FetchBalance()),
        expect: () => {
              PortfolioState(
                  transactionBalanceResponse: BaseResponse.loading()),
              PortfolioState(
                  transactionBalanceResponse: transactionBalanceErrorResponse)
            });

    blocTest<PortfolioBloc, PortfolioState>(
        'emits `BaseResponse.complete` WHEN '
        'terminate bot stock',
        build: () {
          when(botStockRepository.terminateOrder('123'))
              .thenAnswer((_) => Future.value(terminateOrderResponse));
          return portfolioBloc;
        },
        act: (bloc) => bloc.add(const EndBotStock('123')),
        expect: () => {
              PortfolioState(endBotStockResponse: BaseResponse.loading()),
              PortfolioState(endBotStockResponse: terminateOrderResponse)
            });

    blocTest<PortfolioBloc, PortfolioState>(
        'emits `BaseResponse.error` WHEN '
        'failed terminate bot stock',
        build: () {
          when(botStockRepository.terminateOrder('123'))
              .thenAnswer((_) => Future.value(terminateOrderErrorResponse));
          return portfolioBloc;
        },
        act: (bloc) => bloc.add(const EndBotStock('123')),
        expect: () => {
              PortfolioState(endBotStockResponse: BaseResponse.loading()),
              PortfolioState(endBotStockResponse: terminateOrderErrorResponse)
            });

    blocTest<PortfolioBloc, PortfolioState>(
        'emits `BaseResponse.complete` WHEN '
        'rollover bot stock',
        build: () {
          when(botStockRepository.rolloverOrder('123'))
              .thenAnswer((_) => Future.value(rolloverOrderResponse));
          return portfolioBloc;
        },
        act: (bloc) => bloc.add(const RolloverBotStock('123')),
        expect: () => {
              PortfolioState(rolloverBotStockResponse: BaseResponse.loading()),
              PortfolioState(rolloverBotStockResponse: rolloverOrderResponse)
            });

    blocTest<PortfolioBloc, PortfolioState>(
        'emits `BaseResponse.error` WHEN '
        'failed rollover bot stock',
        build: () {
          when(botStockRepository.rolloverOrder('123'))
              .thenAnswer((_) => Future.value(rolloverOrderErrorResponse));
          return portfolioBloc;
        },
        act: (bloc) => bloc.add(const RolloverBotStock('123')),
        expect: () => {
              PortfolioState(rolloverBotStockResponse: BaseResponse.loading()),
              PortfolioState(
                  rolloverBotStockResponse: rolloverOrderErrorResponse)
            });

    blocTest<PortfolioBloc, PortfolioState>(
        'emits `BaseResponse.complete` WHEN '
        'cancel bot stock',
        build: () {
          when(botStockRepository.cancelOrder('123'))
              .thenAnswer((_) => Future.value(botOrderResponse));
          return portfolioBloc;
        },
        act: (bloc) => bloc.add(const CancelBotStock('123')),
        expect: () => {
              PortfolioState(cancelBotStockResponse: BaseResponse.loading()),
              PortfolioState(cancelBotStockResponse: botOrderResponse)
            });

    blocTest<PortfolioBloc, PortfolioState>(
        'emits `BaseResponse.error` WHEN '
        'cancel bot stock',
        build: () {
          when(botStockRepository.cancelOrder('123'))
              .thenAnswer((_) => Future.value(botOrderErrorResponse));
          return portfolioBloc;
        },
        act: (bloc) => bloc.add(const CancelBotStock('123')),
        expect: () => {
              PortfolioState(cancelBotStockResponse: BaseResponse.loading()),
              PortfolioState(cancelBotStockResponse: botOrderErrorResponse)
            });

    tearDown(() => {portfolioBloc.close()});
  });
}
