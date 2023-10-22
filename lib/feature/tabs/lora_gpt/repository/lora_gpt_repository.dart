import '../../../../core/domain/ai/component.dart';
import '../../../../core/domain/base_response.dart';
import '../../../ai/investment_style_question/domain/investment_style_question_query_request.dart';
import '../../../ai/investment_style_question/domain/investment_style_question_query_response.dart';
import '../domain/lora_gpt_api_client.dart';
import '../domain/portfolio_details_request.dart';
import '../domain/portfolio_query_request.dart';
import '../domain/query_request.dart';
import '../domain/query_response.dart';

class LoraGptRepository {
  final LoraGptClient _loraGptClient = LoraGptClient();

  Future<BaseResponse<QueryResponse>> general(
      {required GeneralQueryRequest params}) async {
    try {
      var response = await _loraGptClient.general(params.params);
      return BaseResponse.complete(QueryResponse.fromJson(response.data));
    } catch (e) {
      return BaseResponse.error();
    }
  }

  Future<BaseResponse<QueryResponse>> portfolioDetails(
      {required PortfolioDetailsRequest params}) async {
    try {
      var response = await _loraGptClient.portfolioDetails(params.params);

      return BaseResponse.complete(QueryResponse.fromJson(response.data));
    } catch (e) {
      return BaseResponse.error();
    }
  }

  Future<BaseResponse<QueryResponse>> portfolio(
      {required PortfolioQueryRequest params,
      required List<Botstock> data}) async {
    try {
      var response =
          await _loraGptClient.portfolio(params: params.params, payload: data);
      return BaseResponse.complete(QueryResponse.fromJson(response.data));
    } catch (e) {
      return BaseResponse.error();
    }
  }

  Future<BaseResponse<InvestmentStyleQuestionQueryResponse>> investmentStyle(
      {required InvestmentStyleQuestionQueryRequest params}) async {
    try {
      var response = await _loraGptClient.investmentStyle(params);

      return BaseResponse.complete(
          InvestmentStyleQuestionQueryResponse.fromJson(response.data));
    } catch (e) {
      return BaseResponse.error();
    }
  }

  Future<BaseResponse<QueryResponse>> botIntro(
      {required BotstockIntro params}) async {
    try {
      final response = await _loraGptClient.botIntro(params.params);
      return BaseResponse.complete(QueryResponse.fromJson(response.data));
    } catch (e) {
      return BaseResponse.error();
    }
  }

  Future<BaseResponse<QueryResponse>> botEarnings(
      {required BotstockIntro params}) async {
    try {
      var response = await _loraGptClient.botIntroEarnings(params.params);
      return BaseResponse.complete(QueryResponse.fromJson(response.data));
    } catch (e) {
      return BaseResponse.error();
    }
  }

  final BaseResponse<QueryResponse> fullQueryResponse =
      BaseResponse.complete(const QueryResponse('a', 'b', 'c', false, results: [
    't is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout'
  ], components: [
    PromptButton('a', 'a'),
    PromptButton('b', 'b')
  ]));

  final BaseResponse<QueryResponse> fullQueryResponse2nd =
      BaseResponse.complete(const QueryResponse('a', 'b', 'c', false, results: [
    "making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy"
  ], components: [
    PromptButton('c', 'c'),
    PromptButton('d', 'd')
  ]));
  final BaseResponse<QueryResponse> resultOnlyQueryResponse =
      BaseResponse.complete(const QueryResponse('a', 'b', 'c', false, results: [
    't is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout'
  ]));
  final BaseResponse<QueryResponse> componentOnlyQueryResponse =
      BaseResponse.complete(const QueryResponse('a', 'b', 'c', false,
          components: [PromptButton('e', 'e'), PromptButton('f', 'f')]));

  final BaseResponse<QueryResponse> emptyQueryResponse =
      BaseResponse.complete(const QueryResponse(
    'a',
    'b',
    'c',
    false,
  ));

  final BaseResponse<QueryResponse> failedResponse = BaseResponse.error();

  Future<void> get initiateDelay => Future.delayed(const Duration(seconds: 1));

  Future<void> get someDelay => Future.delayed(const Duration(seconds: 2));

  Future<BaseResponse<QueryResponse>> welcomeStarter(
      {required GeneralQueryRequest params}) async {
    try {
      var response = await _loraGptClient.welcomeStarter(params.params);
      return BaseResponse.complete(QueryResponse.fromJson(response.data));
    } catch (e) {
      return BaseResponse.error();
    }
  }

  Future<BaseResponse<QueryResponse>> welcomeNews(
      {required GeneralQueryRequest params}) async {
    try {
      var response = await _loraGptClient.welcomeNews(params.params);
      return BaseResponse.complete(QueryResponse.fromJson(response.data));
    } catch (e) {
      return BaseResponse.error();
    }
  }
}
