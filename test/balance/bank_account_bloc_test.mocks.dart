// Mocks generated by Mockito 5.4.2 from annotations
// in asklora_mobile_app/test/balance/bank_account_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:asklora_mobile_app/core/domain/base_response.dart' as _i2;
import 'package:asklora_mobile_app/feature/balance/domain/registered_bank_accounts.dart'
    as _i5;
import 'package:asklora_mobile_app/feature/balance/repository/bank_account_repository.dart'
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

/// A class which mocks [BankAccountRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockBankAccountRepository extends _i1.Mock
    implements _i3.BankAccountRepository {
  MockBankAccountRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.BaseResponse<_i5.RegisteredBankAccounts>> getBankAccount() =>
      (super.noSuchMethod(
        Invocation.method(
          #getBankAccount,
          [],
        ),
        returnValue:
            _i4.Future<_i2.BaseResponse<_i5.RegisteredBankAccounts>>.value(
                _FakeBaseResponse_0<_i5.RegisteredBankAccounts>(
          this,
          Invocation.method(
            #getBankAccount,
            [],
          ),
        )),
      ) as _i4.Future<_i2.BaseResponse<_i5.RegisteredBankAccounts>>);
}
