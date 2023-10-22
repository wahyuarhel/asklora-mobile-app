part of '../withdrawal_amount_screen.dart';

class WithdrawalKeyPad extends StatelessWidget {
  const WithdrawalKeyPad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Align(
      alignment: Alignment.bottomCenter,
      child: CustomKeyPad(
        onChange: (value) =>
            context.read<WithdrawalBloc>().add(WithdrawalAmountChanged(value)),
      ),
    ));
  }
}
