import 'package:equatable/equatable.dart';

import 'get_bank_account_response.dart';

class RegisteredBankAccounts extends Equatable {
  late final List<GetBankAccountResponse>? fpsBankAccounts;
  late final List<GetBankAccountResponse>? wireBankAccounts;
  late final List<GetBankAccountResponse>? eDdaBankAccounts;

  RegisteredBankAccounts(List<GetBankAccountResponse> getBankAccountResponse) {
    fpsBankAccounts = List.from((getBankAccountResponse)
        .where((bankDetail) => bankDetail.bankTransferType!.contains('FPS')));
    wireBankAccounts = List.from((getBankAccountResponse)
        .where((bankDetail) => bankDetail.bankTransferType!.contains('WIRE')));
    eDdaBankAccounts = List.from((getBankAccountResponse)
        .where((bankDetail) => bankDetail.bankTransferType!.contains('EDDA')));
  }

  @override
  List<Object?> get props =>
      [fpsBankAccounts, wireBankAccounts, eDdaBankAccounts];
}
