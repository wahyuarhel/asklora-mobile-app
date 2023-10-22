import 'package:asklora_mobile_app/core/domain/base_response.dart';
import 'package:asklora_mobile_app/feature/balance/bloc/bank_account_bloc.dart';
import 'package:asklora_mobile_app/feature/balance/deposit/utils/deposit_utils.dart';
import 'package:asklora_mobile_app/feature/balance/domain/get_bank_account_response.dart';
import 'package:asklora_mobile_app/feature/balance/domain/registered_bank_accounts.dart';
import 'package:asklora_mobile_app/feature/balance/repository/bank_account_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'bank_account_bloc_test.mocks.dart';

@GenerateMocks([BankAccountRepository])
void main() async {
  group('Deposit Bloc Tests', () {
    late BankAccountBloc bankAccountBloc;
    late MockBankAccountRepository mockBankAccountRepository;
    final BaseResponse<RegisteredBankAccounts> registeredBankAccountResponse =
        BaseResponse.complete(RegisteredBankAccounts(const [
      GetBankAccountResponse('', '', '', '123', 'Alex', '112233', 'FPS', '',
          'Bank Central Asia', '', '', '')
    ]));

    setUpAll(() async {
      mockBankAccountRepository = MockBankAccountRepository();
    });

    setUp(() async {
      bankAccountBloc =
          BankAccountBloc(bankAccountRepository: mockBankAccountRepository);
    });

    test('Account Bloc init state', () {
      expect(bankAccountBloc.state, const BankAccountState());
    });

    blocTest<BankAccountBloc, BankAccountState>(
        'emits `registeredBankAccountResponse` WHEN '
        'checking for registered bank account',
        build: () {
          when(mockBankAccountRepository.getBankAccount())
              .thenAnswer((_) => Future.value(registeredBankAccountResponse));
          return bankAccountBloc;
        },
        act: (bloc) => bloc.add(const RegisteredBankAccountCheck()),
        expect: () => {
              BankAccountState(response: BaseResponse.loading()),
              BankAccountState(
                  response: registeredBankAccountResponse,
                  depositType: DepositType.type2),
            });

    tearDown(() => {bankAccountBloc.close()});
  });
}
