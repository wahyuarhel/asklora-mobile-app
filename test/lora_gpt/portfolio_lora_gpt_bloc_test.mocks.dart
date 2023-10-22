// Mocks generated by Mockito 5.4.2 from annotations
// in asklora_mobile_app/test/lora_gpt/portfolio_lora_gpt_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:asklora_mobile_app/core/domain/base_response.dart' as _i2;
import 'package:asklora_mobile_app/core/utils/storage/shared_preference.dart'
    as _i11;
import 'package:asklora_mobile_app/feature/ai/investment_style_question/domain/investment_style_question_query_request.dart'
    as _i10;
import 'package:asklora_mobile_app/feature/ai/investment_style_question/domain/investment_style_question_query_response.dart'
    as _i9;
import 'package:asklora_mobile_app/feature/tabs/lora_gpt/domain/portfolio_details_request.dart'
    as _i7;
import 'package:asklora_mobile_app/feature/tabs/lora_gpt/domain/portfolio_query_request.dart'
    as _i8;
import 'package:asklora_mobile_app/feature/tabs/lora_gpt/domain/query_request.dart'
    as _i6;
import 'package:asklora_mobile_app/feature/tabs/lora_gpt/domain/query_response.dart'
    as _i4;
import 'package:asklora_mobile_app/feature/tabs/lora_gpt/repository/lora_gpt_repository.dart'
    as _i3;
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

/// A class which mocks [LoraGptRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoraGptRepository extends _i1.Mock implements _i3.LoraGptRepository {
  MockLoraGptRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.BaseResponse<_i4.QueryResponse> get fullQueryResponse =>
      (super.noSuchMethod(
        Invocation.getter(#fullQueryResponse),
        returnValue: _FakeBaseResponse_0<_i4.QueryResponse>(
          this,
          Invocation.getter(#fullQueryResponse),
        ),
      ) as _i2.BaseResponse<_i4.QueryResponse>);
  @override
  _i2.BaseResponse<_i4.QueryResponse> get fullQueryResponse2nd =>
      (super.noSuchMethod(
        Invocation.getter(#fullQueryResponse2nd),
        returnValue: _FakeBaseResponse_0<_i4.QueryResponse>(
          this,
          Invocation.getter(#fullQueryResponse2nd),
        ),
      ) as _i2.BaseResponse<_i4.QueryResponse>);
  @override
  _i2.BaseResponse<_i4.QueryResponse> get resultOnlyQueryResponse =>
      (super.noSuchMethod(
        Invocation.getter(#resultOnlyQueryResponse),
        returnValue: _FakeBaseResponse_0<_i4.QueryResponse>(
          this,
          Invocation.getter(#resultOnlyQueryResponse),
        ),
      ) as _i2.BaseResponse<_i4.QueryResponse>);
  @override
  _i2.BaseResponse<_i4.QueryResponse> get componentOnlyQueryResponse =>
      (super.noSuchMethod(
        Invocation.getter(#componentOnlyQueryResponse),
        returnValue: _FakeBaseResponse_0<_i4.QueryResponse>(
          this,
          Invocation.getter(#componentOnlyQueryResponse),
        ),
      ) as _i2.BaseResponse<_i4.QueryResponse>);
  @override
  _i2.BaseResponse<_i4.QueryResponse> get emptyQueryResponse =>
      (super.noSuchMethod(
        Invocation.getter(#emptyQueryResponse),
        returnValue: _FakeBaseResponse_0<_i4.QueryResponse>(
          this,
          Invocation.getter(#emptyQueryResponse),
        ),
      ) as _i2.BaseResponse<_i4.QueryResponse>);
  @override
  _i2.BaseResponse<_i4.QueryResponse> get failedResponse => (super.noSuchMethod(
        Invocation.getter(#failedResponse),
        returnValue: _FakeBaseResponse_0<_i4.QueryResponse>(
          this,
          Invocation.getter(#failedResponse),
        ),
      ) as _i2.BaseResponse<_i4.QueryResponse>);
  @override
  _i5.Future<void> get initiateDelay => (super.noSuchMethod(
        Invocation.getter(#initiateDelay),
        returnValue: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> get someDelay => (super.noSuchMethod(
        Invocation.getter(#someDelay),
        returnValue: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<_i2.BaseResponse<_i4.QueryResponse>> general(
          {required _i6.GeneralQueryRequest? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #general,
          [],
          {#params: params},
        ),
        returnValue: _i5.Future<_i2.BaseResponse<_i4.QueryResponse>>.value(
            _FakeBaseResponse_0<_i4.QueryResponse>(
          this,
          Invocation.method(
            #general,
            [],
            {#params: params},
          ),
        )),
      ) as _i5.Future<_i2.BaseResponse<_i4.QueryResponse>>);
  @override
  _i5.Future<_i2.BaseResponse<_i4.QueryResponse>> portfolioDetails(
          {required _i7.PortfolioDetailsRequest? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #portfolioDetails,
          [],
          {#params: params},
        ),
        returnValue: _i5.Future<_i2.BaseResponse<_i4.QueryResponse>>.value(
            _FakeBaseResponse_0<_i4.QueryResponse>(
          this,
          Invocation.method(
            #portfolioDetails,
            [],
            {#params: params},
          ),
        )),
      ) as _i5.Future<_i2.BaseResponse<_i4.QueryResponse>>);
  @override
  _i5.Future<_i2.BaseResponse<_i4.QueryResponse>> portfolio({
    required _i8.PortfolioQueryRequest? params,
    required List<_i8.Botstock>? data,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #portfolio,
          [],
          {
            #params: params,
            #data: data,
          },
        ),
        returnValue: _i5.Future<_i2.BaseResponse<_i4.QueryResponse>>.value(
            _FakeBaseResponse_0<_i4.QueryResponse>(
          this,
          Invocation.method(
            #portfolio,
            [],
            {
              #params: params,
              #data: data,
            },
          ),
        )),
      ) as _i5.Future<_i2.BaseResponse<_i4.QueryResponse>>);
  @override
  _i5.Future<
      _i2
      .BaseResponse<_i9.InvestmentStyleQuestionQueryResponse>> investmentStyle(
          {required _i10.InvestmentStyleQuestionQueryRequest? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #investmentStyle,
          [],
          {#params: params},
        ),
        returnValue: _i5.Future<
                _i2
                .BaseResponse<_i9.InvestmentStyleQuestionQueryResponse>>.value(
            _FakeBaseResponse_0<_i9.InvestmentStyleQuestionQueryResponse>(
          this,
          Invocation.method(
            #investmentStyle,
            [],
            {#params: params},
          ),
        )),
      ) as _i5
          .Future<_i2.BaseResponse<_i9.InvestmentStyleQuestionQueryResponse>>);
  @override
  _i5.Future<_i2.BaseResponse<_i4.QueryResponse>> botIntro(
          {required _i8.BotstockIntro? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #botIntro,
          [],
          {#params: params},
        ),
        returnValue: _i5.Future<_i2.BaseResponse<_i4.QueryResponse>>.value(
            _FakeBaseResponse_0<_i4.QueryResponse>(
          this,
          Invocation.method(
            #botIntro,
            [],
            {#params: params},
          ),
        )),
      ) as _i5.Future<_i2.BaseResponse<_i4.QueryResponse>>);
  @override
  _i5.Future<_i2.BaseResponse<_i4.QueryResponse>> botEarnings(
          {required _i8.BotstockIntro? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #botEarnings,
          [],
          {#params: params},
        ),
        returnValue: _i5.Future<_i2.BaseResponse<_i4.QueryResponse>>.value(
            _FakeBaseResponse_0<_i4.QueryResponse>(
          this,
          Invocation.method(
            #botEarnings,
            [],
            {#params: params},
          ),
        )),
      ) as _i5.Future<_i2.BaseResponse<_i4.QueryResponse>>);
  @override
  _i5.Future<_i2.BaseResponse<_i4.QueryResponse>> welcomeStarter(
          {required _i6.GeneralQueryRequest? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #welcomeStarter,
          [],
          {#params: params},
        ),
        returnValue: _i5.Future<_i2.BaseResponse<_i4.QueryResponse>>.value(
            _FakeBaseResponse_0<_i4.QueryResponse>(
          this,
          Invocation.method(
            #welcomeStarter,
            [],
            {#params: params},
          ),
        )),
      ) as _i5.Future<_i2.BaseResponse<_i4.QueryResponse>>);
  @override
  _i5.Future<_i2.BaseResponse<_i4.QueryResponse>> welcomeNews(
          {required _i6.GeneralQueryRequest? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #welcomeNews,
          [],
          {#params: params},
        ),
        returnValue: _i5.Future<_i2.BaseResponse<_i4.QueryResponse>>.value(
            _FakeBaseResponse_0<_i4.QueryResponse>(
          this,
          Invocation.method(
            #welcomeNews,
            [],
            {#params: params},
          ),
        )),
      ) as _i5.Future<_i2.BaseResponse<_i4.QueryResponse>>);
}

/// A class which mocks [SharedPreference].
///
/// See the documentation for Mockito's code generation for more information.
class MockSharedPreference extends _i1.Mock implements _i11.SharedPreference {
  MockSharedPreference() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<void> deleteAllData() => (super.noSuchMethod(
        Invocation.method(
          #deleteAllData,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> deleteData(String? key) => (super.noSuchMethod(
        Invocation.method(
          #deleteData,
          [key],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<String?> readData(String? key) => (super.noSuchMethod(
        Invocation.method(
          #readData,
          [key],
        ),
        returnValue: _i5.Future<String?>.value(),
      ) as _i5.Future<String?>);
  @override
  _i5.Future<bool?> readBoolData(String? key) => (super.noSuchMethod(
        Invocation.method(
          #readBoolData,
          [key],
        ),
        returnValue: _i5.Future<bool?>.value(),
      ) as _i5.Future<bool?>);
  @override
  _i5.Future<bool> writeData(
    String? key,
    String? value,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #writeData,
          [
            key,
            value,
          ],
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
  @override
  _i5.Future<bool> writeBoolData(
    String? key,
    bool? value,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #writeBoolData,
          [
            key,
            value,
          ],
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
  @override
  _i5.Future<bool> writeIntData(
    String? key,
    int? value,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #writeIntData,
          [
            key,
            value,
          ],
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
  @override
  _i5.Future<int?> readIntData(String? key) => (super.noSuchMethod(
        Invocation.method(
          #readIntData,
          [key],
        ),
        returnValue: _i5.Future<int?>.value(),
      ) as _i5.Future<int?>);
  @override
  _i5.Future<bool> containsKey(String? key) => (super.noSuchMethod(
        Invocation.method(
          #containsKey,
          [key],
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
  @override
  _i5.Future<void> deleteAllDataExcept(List<String>? keys) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteAllDataExcept,
          [keys],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
}