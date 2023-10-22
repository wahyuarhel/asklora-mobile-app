import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../core/data/remote/base_api_client.dart';
import '../../../core/domain/base_response.dart';
import '../../../core/domain/validation_enum.dart';
import '../../../core/utils/storage/shared_preference.dart';
import '../../../core/utils/storage/storage_keys.dart';
import '../../chart/domain/bot_portfolio_chart_models.dart';
import '../../chart/domain/bot_recommendation_chart_model.dart';
import '../../chart/domain/chart_models.dart';
import '../../chart/domain/chart_studio_animation_model.dart';
import '../domain/bot_detail_request.dart';
import '../domain/bot_recommendation_detail_model.dart';
import '../domain/bot_recommendation_model.dart';
import '../domain/bot_recommendation_response.dart';
import '../domain/bot_stock_api_client.dart';
import '../domain/orders/bot_active_order_detail_model.dart';
import '../domain/orders/bot_active_order_model.dart';
import '../domain/orders/bot_active_order_request.dart';
import '../domain/orders/bot_create_order_request.dart';
import '../domain/orders/bot_create_order_response.dart';
import '../domain/orders/bot_order_request.dart';
import '../domain/orders/bot_order_response.dart';
import '../utils/bot_stock_utils.dart';

class BotStockRepository {
  final SharedPreference _sharedPreference = SharedPreference();
  final BotStockApiClient _botStockApiClient = BotStockApiClient();

  Future<BaseResponse<BotRecommendationDetailModel>> fetchBotDetail(
      String ticker, String botId) async {
    try {
      var response = await _botStockApiClient
          .fetchBotDetail(BotDetailRequest(ticker, botId));

      return BaseResponse.complete(
          BotRecommendationDetailModel.fromJson(response.data));
    } catch (e) {
      return BaseResponse.error();
    }
  }

  Future<BaseResponse<List<ChartDataSet>>> fetchChartDataJson() async {
    try {
      final String response =
          await rootBundle.loadString('assets/json/aapl_with_index.json');

      Iterable iterable = json.decode(response);

      return BaseResponse.complete(List<ChartDataSet>.from(iterable
          .map((model) => BotRecommendationChartModel.fromJson(model))));
    } catch (e) {
      return BaseResponse.error();
    }
  }

  Future<BaseResponse<ChartStudioAnimationModel>>
      fetchTradeChartDataJson() async {
    try {
      final String response =
          await rootBundle.loadString('assets/json/tesla_3_month_uno.json');
      var decodedJson = json.decode(response);
      return BaseResponse.complete(ChartStudioAnimationModel(
          chartData: _addIndexChartStudioData(List<ChartDataStudioSet>.from(
              decodedJson['chart_data']
                  .map((model) => ChartDataStudioSet.fromJson(model)))),
          botData: List<ChartDataStudioSet>.from(decodedJson['bot_data']
              .map((model) => ChartDataStudioSet.fromJson(model))),
          uiData: List<UiData>.from(
              decodedJson['ui_data'].map((model) => UiData.fromJson(model)))));
    } catch (e) {
      return BaseResponse.error();
    }
  }

  List<ChartDataStudioSet> _addIndexChartStudioData(
      List<ChartDataStudioSet> chartData) {
    List<ChartDataStudioSet> finalChartData = [];
    int index = 0;
    for (var element in chartData) {
      finalChartData.add(ChartDataStudioSet(
          index: index++, date: element.date, price: element.price));
    }
    return finalChartData;
  }

  Future<BaseResponse<BotRecommendationResponse>>
      fetchBotRecommendation() async {
    try {
      var response = await _botStockApiClient.fetchBotRecommendation(
          await _sharedPreference.readData(StorageKeys.sfKeyPpiAccountId) ??
              '');
      return BaseResponse.complete(
          BotRecommendationResponse.fromJson(response.data));
    } on BadRequestException catch (_) {
      return BaseResponse.error(validationCode: ValidationCode.redoIsq);
    } catch (e) {
      return BaseResponse.error();
    }
  }

  Future<BaseResponse<BotRecommendationResponse>> fetchFreeBotRecommendation(
      {bool isFreeBot = false}) async {
    try {
      var response = await _botStockApiClient.fetchBotRecommendation(
          await _sharedPreference.readData(StorageKeys.sfKeyPpiAccountId) ??
              '');
      var botRecommendationResponse =
          BotRecommendationResponse.fromJson(response.data);

      return BaseResponse.complete(BotRecommendationResponse(
          updated: botRecommendationResponse.updated,
          data: botRecommendationResponse.data
              .map((model) => model.copyWith(freeBot: true))
              .toList()));
    } catch (e) {
      return BaseResponse.error();
    }
  }

  Future<BaseResponse<List<BotRecommendationModel>>>
      fetchBotDemonstration() async {
    await Future.delayed(const Duration(seconds: 1));
    return BaseResponse.complete(demonstrationBots);
  }

  Future<void> removeInvestmentStyleState() async =>
      await _sharedPreference.deleteData(StorageKeys.sfKeyInvestmentStyleState);

  Future<BaseResponse<List<BotActiveOrderModel>>> activeOrders(
      {required List<String> status}) async {
    try {
      var response = await _botStockApiClient
          .activeOrder(BotActiveOrderRequest(status: status.join(',')));
      return BaseResponse.complete(List.from(response.data
          .map((element) => BotActiveOrderModel.fromJson(element))));
    } on AskloraApiClientException catch (e) {
      return BaseResponse.error(validationCode: e.askloraError.type);
    }
    /*on ForbiddenException {
      return BaseResponse.error(validationCode: ValidationCodes.tradeAuthorization);
    }*/
    catch (e) {
      return BaseResponse.error();
    }
  }

  Future<BaseResponse<BotActiveOrderDetailModel>> activeOrderDetail(
      String botOrderId) async {
    try {
      var response = await _botStockApiClient.activeOrderDetail(botOrderId);
      return BaseResponse.complete(
          BotActiveOrderDetailModel.fromJson(response.data));
    } catch (e) {
      return BaseResponse.error();
    }
  }

  Future<BaseResponse<List<BotPortfolioChartDataSet>>> fetchBotPerformance(
      String botOrderId) async {
    try {
      var response = await _botStockApiClient.fetchBotPerformance(botOrderId);

      return BaseResponse.complete(List.from(response.data
          .map((element) => BotPortfolioChartDataSet.fromJson(element))));
    } catch (e) {
      return BaseResponse.error();
    }
  }

  Future<BaseResponse<BotCreateOrderResponse>> createOrder(
      {required BotRecommendationModel botRecommendationModel,
      required double tradeBotStockAmount}) async {
    try {
      ///SHOULD ENABLE ISDUMMY IF FREEBOTS FLOW IS ENABLED
      var response = await _botStockApiClient.createOrder(BotCreateOrderRequest(
        ticker: botRecommendationModel.ticker,
        botId: botRecommendationModel.botId,
        // spotDate: formatDateTimeAsString(DateTime.now()),
        investmentAmount: tradeBotStockAmount,
        // price: checkDouble(
        //   botRecommendationModel.latestPrice,
        // ),
        /*isDummy: botRecommendationModel.freeBot)*/
      ));
      return BaseResponse.complete(
          BotCreateOrderResponse.fromJson(response.data));
    } on AskloraApiClientException catch (e) {
      return BaseResponse.error(validationCode: e.askloraError.type);
    }
    /* on ForbiddenException {
      return BaseResponse.error(validationCode: ValidationCodes.tradeAuthorization);
    } on LegalReasonException {
      return BaseResponse.suspended();
    }*/
    catch (e) {
      ///TODO: handle error code later on insufficient balance
      return BaseResponse.error();
    }
  }

  Future<BaseResponse<BotOrderResponse>> cancelOrder(String botOrderId) async {
    try {
      var response =
          await _botStockApiClient.cancelOrder(BotOrderRequest(botOrderId));
      return BaseResponse.complete(BotOrderResponse.fromJson(response.data));
    } on AskloraApiClientException catch (e) {
      return BaseResponse.error(validationCode: e.askloraError.type);
    }
    /*on LegalReasonException {
      return BaseResponse.suspended();
    }*/
    catch (e) {
      return BaseResponse.error();
    }
  }

  Future<BaseResponse<RolloverOrderResponse>> rolloverOrder(
      String botOrderId) async {
    try {
      var response =
          await _botStockApiClient.rolloverOrder(BotOrderRequest(botOrderId));
      return BaseResponse.complete(
          RolloverOrderResponse.fromJson(response.data));
    } on AskloraApiClientException catch (e) {
      return BaseResponse.error(validationCode: e.askloraError.type);
    }
    /*on LegalReasonException {
      return BaseResponse.suspended();
    }*/
    catch (e) {
      return BaseResponse.error();
    }
  }

  Future<BaseResponse<TerminateOrderResponse>> terminateOrder(
      String botOrderId) async {
    try {
      var response =
          await _botStockApiClient.terminateOrder(BotOrderRequest(botOrderId));
      return BaseResponse.complete(
          TerminateOrderResponse.fromJson(response.data));
    } on AskloraApiClientException catch (e) {
      return BaseResponse.error(validationCode: e.askloraError.type);
    }
    /*on LegalReasonException {
      return BaseResponse.suspended();
    }*/
    catch (e) {
      return BaseResponse.error();
    }
  }
}
