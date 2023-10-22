// Mocks generated by Mockito 5.4.2 from annotations
// in asklora_mobile_app/test/portfolio/portfolio_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:asklora_mobile_app/core/domain/base_response.dart' as _i2;
import 'package:asklora_mobile_app/core/domain/transaction/transaction_balance_response.dart'
    as _i18;
import 'package:asklora_mobile_app/core/domain/transaction/transaction_ledger_balance_response.dart'
    as _i19;
import 'package:asklora_mobile_app/core/repository/transaction_repository.dart'
    as _i15;
import 'package:asklora_mobile_app/feature/balance/deposit/domain/deposit_response.dart'
    as _i20;
import 'package:asklora_mobile_app/feature/balance/withdrawal/domain/withdrawal_request.dart'
    as _i23;
import 'package:asklora_mobile_app/feature/balance/withdrawal/domain/withdrawal_response.dart'
    as _i22;
import 'package:asklora_mobile_app/feature/bot_stock/domain/bot_recommendation_detail_model.dart'
    as _i5;
import 'package:asklora_mobile_app/feature/bot_stock/domain/bot_recommendation_model.dart'
    as _i9;
import 'package:asklora_mobile_app/feature/bot_stock/domain/bot_recommendation_response.dart'
    as _i8;
import 'package:asklora_mobile_app/feature/bot_stock/domain/orders/bot_active_order_detail_model.dart'
    as _i11;
import 'package:asklora_mobile_app/feature/bot_stock/domain/orders/bot_active_order_model.dart'
    as _i10;
import 'package:asklora_mobile_app/feature/bot_stock/domain/orders/bot_create_order_response.dart'
    as _i13;
import 'package:asklora_mobile_app/feature/bot_stock/domain/orders/bot_order_response.dart'
    as _i14;
import 'package:asklora_mobile_app/feature/bot_stock/repository/bot_stock_repository.dart'
    as _i3;
import 'package:asklora_mobile_app/feature/chart/domain/bot_portfolio_chart_models.dart'
    as _i12;
import 'package:asklora_mobile_app/feature/chart/domain/chart_models.dart'
    as _i6;
import 'package:asklora_mobile_app/feature/chart/domain/chart_studio_animation_model.dart'
    as _i7;
import 'package:asklora_mobile_app/feature/transaction_history/bot_order/detail/domain/bot_detail_transaction_history_response.dart'
    as _i17;
import 'package:asklora_mobile_app/feature/transaction_history/domain/grouped_transaction_model.dart'
    as _i16;
import 'package:file_picker/file_picker.dart' as _i21;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeBaseResponse_0<T> extends _i1.SmartFake
    implements _i2.BaseResponse<T> {
  _FakeBaseResponse_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [BotStockRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockBotStockRepository extends _i1.Mock
    implements _i3.BotStockRepository {
  MockBotStockRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.BaseResponse<_i5.BotRecommendationDetailModel>> fetchBotDetail(
    String? ticker,
    String? botId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchBotDetail,
          [
            ticker,
            botId,
          ],
        ),
        returnValue: _i4
            .Future<_i2.BaseResponse<_i5.BotRecommendationDetailModel>>.value(
            _FakeBaseResponse_0<_i5.BotRecommendationDetailModel>(
          this,
          Invocation.method(
            #fetchBotDetail,
            [
              ticker,
              botId,
            ],
          ),
        )),
      ) as _i4.Future<_i2.BaseResponse<_i5.BotRecommendationDetailModel>>);
  @override
  _i4.Future<_i2.BaseResponse<List<_i6.ChartDataSet>>> fetchChartDataJson() =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchChartDataJson,
          [],
        ),
        returnValue: _i4.Future<_i2.BaseResponse<List<_i6.ChartDataSet>>>.value(
            _FakeBaseResponse_0<List<_i6.ChartDataSet>>(
          this,
          Invocation.method(
            #fetchChartDataJson,
            [],
          ),
        )),
      ) as _i4.Future<_i2.BaseResponse<List<_i6.ChartDataSet>>>);
  @override
  _i4.Future<_i2.BaseResponse<_i7.ChartStudioAnimationModel>>
      fetchTradeChartDataJson() => (super.noSuchMethod(
            Invocation.method(
              #fetchTradeChartDataJson,
              [],
            ),
            returnValue: _i4
                .Future<_i2.BaseResponse<_i7.ChartStudioAnimationModel>>.value(
                _FakeBaseResponse_0<_i7.ChartStudioAnimationModel>(
              this,
              Invocation.method(
                #fetchTradeChartDataJson,
                [],
              ),
            )),
          ) as _i4.Future<_i2.BaseResponse<_i7.ChartStudioAnimationModel>>);
  @override
  _i4.Future<_i2.BaseResponse<_i8.BotRecommendationResponse>>
      fetchBotRecommendation() => (super.noSuchMethod(
            Invocation.method(
              #fetchBotRecommendation,
              [],
            ),
            returnValue: _i4
                .Future<_i2.BaseResponse<_i8.BotRecommendationResponse>>.value(
                _FakeBaseResponse_0<_i8.BotRecommendationResponse>(
              this,
              Invocation.method(
                #fetchBotRecommendation,
                [],
              ),
            )),
          ) as _i4.Future<_i2.BaseResponse<_i8.BotRecommendationResponse>>);
  @override
  _i4.Future<_i2.BaseResponse<_i8.BotRecommendationResponse>>
      fetchFreeBotRecommendation({bool? isFreeBot = false}) =>
          (super.noSuchMethod(
            Invocation.method(
              #fetchFreeBotRecommendation,
              [],
              {#isFreeBot: isFreeBot},
            ),
            returnValue: _i4
                .Future<_i2.BaseResponse<_i8.BotRecommendationResponse>>.value(
                _FakeBaseResponse_0<_i8.BotRecommendationResponse>(
              this,
              Invocation.method(
                #fetchFreeBotRecommendation,
                [],
                {#isFreeBot: isFreeBot},
              ),
            )),
          ) as _i4.Future<_i2.BaseResponse<_i8.BotRecommendationResponse>>);
  @override
  _i4.Future<_i2.BaseResponse<List<_i9.BotRecommendationModel>>>
      fetchBotDemonstration() => (super.noSuchMethod(
            Invocation.method(
              #fetchBotDemonstration,
              [],
            ),
            returnValue: _i4.Future<
                    _i2.BaseResponse<List<_i9.BotRecommendationModel>>>.value(
                _FakeBaseResponse_0<List<_i9.BotRecommendationModel>>(
              this,
              Invocation.method(
                #fetchBotDemonstration,
                [],
              ),
            )),
          ) as _i4.Future<_i2.BaseResponse<List<_i9.BotRecommendationModel>>>);
  @override
  _i4.Future<void> removeInvestmentStyleState() => (super.noSuchMethod(
        Invocation.method(
          #removeInvestmentStyleState,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<_i2.BaseResponse<List<_i10.BotActiveOrderModel>>> activeOrders(
          {required List<String>? status}) =>
      (super.noSuchMethod(
        Invocation.method(
          #activeOrders,
          [],
          {#status: status},
        ),
        returnValue:
            _i4.Future<_i2.BaseResponse<List<_i10.BotActiveOrderModel>>>.value(
                _FakeBaseResponse_0<List<_i10.BotActiveOrderModel>>(
          this,
          Invocation.method(
            #activeOrders,
            [],
            {#status: status},
          ),
        )),
      ) as _i4.Future<_i2.BaseResponse<List<_i10.BotActiveOrderModel>>>);
  @override
  _i4.Future<_i2.BaseResponse<_i11.BotActiveOrderDetailModel>>
      activeOrderDetail(String? botOrderId) => (super.noSuchMethod(
            Invocation.method(
              #activeOrderDetail,
              [botOrderId],
            ),
            returnValue: _i4
                .Future<_i2.BaseResponse<_i11.BotActiveOrderDetailModel>>.value(
                _FakeBaseResponse_0<_i11.BotActiveOrderDetailModel>(
              this,
              Invocation.method(
                #activeOrderDetail,
                [botOrderId],
              ),
            )),
          ) as _i4.Future<_i2.BaseResponse<_i11.BotActiveOrderDetailModel>>);
  @override
  _i4.Future<_i2.BaseResponse<List<_i12.BotPortfolioChartDataSet>>>
      fetchBotPerformance(String? botOrderId) => (super.noSuchMethod(
            Invocation.method(
              #fetchBotPerformance,
              [botOrderId],
            ),
            returnValue: _i4.Future<
                    _i2
                    .BaseResponse<List<_i12.BotPortfolioChartDataSet>>>.value(
                _FakeBaseResponse_0<List<_i12.BotPortfolioChartDataSet>>(
              this,
              Invocation.method(
                #fetchBotPerformance,
                [botOrderId],
              ),
            )),
          ) as _i4
              .Future<_i2.BaseResponse<List<_i12.BotPortfolioChartDataSet>>>);
  @override
  _i4.Future<_i2.BaseResponse<_i13.BotCreateOrderResponse>> createOrder({
    required _i9.BotRecommendationModel? botRecommendationModel,
    required double? tradeBotStockAmount,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #createOrder,
          [],
          {
            #botRecommendationModel: botRecommendationModel,
            #tradeBotStockAmount: tradeBotStockAmount,
          },
        ),
        returnValue:
            _i4.Future<_i2.BaseResponse<_i13.BotCreateOrderResponse>>.value(
                _FakeBaseResponse_0<_i13.BotCreateOrderResponse>(
          this,
          Invocation.method(
            #createOrder,
            [],
            {
              #botRecommendationModel: botRecommendationModel,
              #tradeBotStockAmount: tradeBotStockAmount,
            },
          ),
        )),
      ) as _i4.Future<_i2.BaseResponse<_i13.BotCreateOrderResponse>>);
  @override
  _i4.Future<_i2.BaseResponse<_i14.BotOrderResponse>> cancelOrder(
          String? botOrderId) =>
      (super.noSuchMethod(
        Invocation.method(
          #cancelOrder,
          [botOrderId],
        ),
        returnValue: _i4.Future<_i2.BaseResponse<_i14.BotOrderResponse>>.value(
            _FakeBaseResponse_0<_i14.BotOrderResponse>(
          this,
          Invocation.method(
            #cancelOrder,
            [botOrderId],
          ),
        )),
      ) as _i4.Future<_i2.BaseResponse<_i14.BotOrderResponse>>);
  @override
  _i4.Future<_i2.BaseResponse<_i14.RolloverOrderResponse>> rolloverOrder(
          String? botOrderId) =>
      (super.noSuchMethod(
        Invocation.method(
          #rolloverOrder,
          [botOrderId],
        ),
        returnValue:
            _i4.Future<_i2.BaseResponse<_i14.RolloverOrderResponse>>.value(
                _FakeBaseResponse_0<_i14.RolloverOrderResponse>(
          this,
          Invocation.method(
            #rolloverOrder,
            [botOrderId],
          ),
        )),
      ) as _i4.Future<_i2.BaseResponse<_i14.RolloverOrderResponse>>);
  @override
  _i4.Future<_i2.BaseResponse<_i14.TerminateOrderResponse>> terminateOrder(
          String? botOrderId) =>
      (super.noSuchMethod(
        Invocation.method(
          #terminateOrder,
          [botOrderId],
        ),
        returnValue:
            _i4.Future<_i2.BaseResponse<_i14.TerminateOrderResponse>>.value(
                _FakeBaseResponse_0<_i14.TerminateOrderResponse>(
          this,
          Invocation.method(
            #terminateOrder,
            [botOrderId],
          ),
        )),
      ) as _i4.Future<_i2.BaseResponse<_i14.TerminateOrderResponse>>);
}

/// A class which mocks [TransactionRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTransactionRepository extends _i1.Mock
    implements _i15.TransactionRepository {
  MockTransactionRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.BaseResponse<List<_i16.GroupedTransactionModel>>>
      fetchAllTransactionsHistory() => (super.noSuchMethod(
            Invocation.method(
              #fetchAllTransactionsHistory,
              [],
            ),
            returnValue: _i4.Future<
                    _i2.BaseResponse<List<_i16.GroupedTransactionModel>>>.value(
                _FakeBaseResponse_0<List<_i16.GroupedTransactionModel>>(
              this,
              Invocation.method(
                #fetchAllTransactionsHistory,
                [],
              ),
            )),
          ) as _i4
              .Future<_i2.BaseResponse<List<_i16.GroupedTransactionModel>>>);
  @override
  _i4.Future<_i2.BaseResponse<List<_i16.GroupedTransactionModel>>>
      fetchBotTransactionsHistory() => (super.noSuchMethod(
            Invocation.method(
              #fetchBotTransactionsHistory,
              [],
            ),
            returnValue: _i4.Future<
                    _i2.BaseResponse<List<_i16.GroupedTransactionModel>>>.value(
                _FakeBaseResponse_0<List<_i16.GroupedTransactionModel>>(
              this,
              Invocation.method(
                #fetchBotTransactionsHistory,
                [],
              ),
            )),
          ) as _i4
              .Future<_i2.BaseResponse<List<_i16.GroupedTransactionModel>>>);
  @override
  _i4.Future<_i2.BaseResponse<List<_i16.GroupedTransactionModel>>>
      fetchTransferTransactionsHistory() => (super.noSuchMethod(
            Invocation.method(
              #fetchTransferTransactionsHistory,
              [],
            ),
            returnValue: _i4.Future<
                    _i2.BaseResponse<List<_i16.GroupedTransactionModel>>>.value(
                _FakeBaseResponse_0<List<_i16.GroupedTransactionModel>>(
              this,
              Invocation.method(
                #fetchTransferTransactionsHistory,
                [],
              ),
            )),
          ) as _i4
              .Future<_i2.BaseResponse<List<_i16.GroupedTransactionModel>>>);
  @override
  _i4.Future<_i2.BaseResponse<_i17.BotDetailTransactionHistoryResponse>>
      fetchBotTransactionsDetail(String? orderId) => (super.noSuchMethod(
            Invocation.method(
              #fetchBotTransactionsDetail,
              [orderId],
            ),
            returnValue: _i4.Future<
                    _i2.BaseResponse<
                        _i17.BotDetailTransactionHistoryResponse>>.value(
                _FakeBaseResponse_0<_i17.BotDetailTransactionHistoryResponse>(
              this,
              Invocation.method(
                #fetchBotTransactionsDetail,
                [orderId],
              ),
            )),
          ) as _i4.Future<
              _i2.BaseResponse<_i17.BotDetailTransactionHistoryResponse>>);
  @override
  _i4.Future<_i2.BaseResponse<_i18.TransactionBalanceResponse>>
      fetchBalance() => (super.noSuchMethod(
            Invocation.method(
              #fetchBalance,
              [],
            ),
            returnValue: _i4.Future<
                    _i2.BaseResponse<_i18.TransactionBalanceResponse>>.value(
                _FakeBaseResponse_0<_i18.TransactionBalanceResponse>(
              this,
              Invocation.method(
                #fetchBalance,
                [],
              ),
            )),
          ) as _i4.Future<_i2.BaseResponse<_i18.TransactionBalanceResponse>>);
  @override
  _i4.Future<_i2.BaseResponse<_i19.TransactionLedgerBalanceResponse>>
      fetchLedgerBalance() => (super.noSuchMethod(
            Invocation.method(
              #fetchLedgerBalance,
              [],
            ),
            returnValue: _i4.Future<
                    _i2
                    .BaseResponse<_i19.TransactionLedgerBalanceResponse>>.value(
                _FakeBaseResponse_0<_i19.TransactionLedgerBalanceResponse>(
              this,
              Invocation.method(
                #fetchLedgerBalance,
                [],
              ),
            )),
          ) as _i4
              .Future<_i2.BaseResponse<_i19.TransactionLedgerBalanceResponse>>);
  @override
  _i4.Future<_i2.BaseResponse<_i20.DepositResponse>> submitDeposit({
    required double? depositAmount,
    required List<_i21.PlatformFile>? platformFiles,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #submitDeposit,
          [],
          {
            #depositAmount: depositAmount,
            #platformFiles: platformFiles,
          },
        ),
        returnValue: _i4.Future<_i2.BaseResponse<_i20.DepositResponse>>.value(
            _FakeBaseResponse_0<_i20.DepositResponse>(
          this,
          Invocation.method(
            #submitDeposit,
            [],
            {
              #depositAmount: depositAmount,
              #platformFiles: platformFiles,
            },
          ),
        )),
      ) as _i4.Future<_i2.BaseResponse<_i20.DepositResponse>>);
  @override
  _i4.Future<_i2.BaseResponse<_i22.WithdrawalResponse>> submitWithdrawal(
          {required _i23.WithdrawalRequest? withdrawalRequest}) =>
      (super.noSuchMethod(
        Invocation.method(
          #submitWithdrawal,
          [],
          {#withdrawalRequest: withdrawalRequest},
        ),
        returnValue:
            _i4.Future<_i2.BaseResponse<_i22.WithdrawalResponse>>.value(
                _FakeBaseResponse_0<_i22.WithdrawalResponse>(
          this,
          Invocation.method(
            #submitWithdrawal,
            [],
            {#withdrawalRequest: withdrawalRequest},
          ),
        )),
      ) as _i4.Future<_i2.BaseResponse<_i22.WithdrawalResponse>>);
}
