part of '../deposit_welcome_screen.dart';

class DepositBankAccount extends StatelessWidget {
  final BankAccount? bankAccount;
  final Widget spaceHeightSmall;
  final Widget spaceHeight;

  const DepositBankAccount(
      {required this.spaceHeightSmall,
      required this.spaceHeight,
      this.bankAccount,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (bankAccount != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BankAccountCard(
            bankAccount: bankAccount!,
          ),
          spaceHeightSmall,
          const ChangeBankAccountButton(),
          spaceHeight,
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
