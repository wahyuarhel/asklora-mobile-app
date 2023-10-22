import '../../../core/domain/base_response.dart';
import '../domain/bank_account_api_client.dart';
import '../domain/get_bank_account_response.dart';
import '../domain/registered_bank_accounts.dart';

class BankAccountRepository {
  final BankAccountApiClient _bankDetailsApiClient = BankAccountApiClient();

  Future<BaseResponse<RegisteredBankAccounts>> getBankAccount() async {
    ///REAL
    var response = await _bankDetailsApiClient.getBankAccount();
    return BaseResponse.complete(RegisteredBankAccounts(
        List<GetBankAccountResponse>.from(response.data
            .map((model) => GetBankAccountResponse.fromJson(model)))));
  }
}
