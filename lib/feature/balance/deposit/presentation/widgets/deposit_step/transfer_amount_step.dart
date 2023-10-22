part of '../../deposit_screen.dart';

class TransferAmountStep extends StatelessWidget {
  final DepositType depositType;
  final bool drawLine;

  const TransferAmountStep(
      {this.drawLine = true, required this.depositType, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DepositBaseStep(
      drawLine: drawLine,
      contents: [
        CustomTextNew(
          S.of(context).inputDepositAmount,
          style: AskLoraTextStyles.h6.copyWith(color: AskLoraColors.charcoal),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomTextNew(
          depositType == DepositType.firstTime
              ? S.of(context).theAmountMustMatchWithPor
              : S.of(context).theAmountMustMatch,
          style:
              AskLoraTextStyles.body2.copyWith(color: AskLoraColors.charcoal),
        ),
        const SizedBox(
          height: 18,
        ),
        BlocConsumer<DepositBloc, DepositState>(
          listenWhen: (previous, current) =>
              previous.depositAmountErrorText !=
                  current.depositAmountErrorText &&
              current.depositAmountErrorText.isNotEmpty,
          listener: (context, state) => CustomInAppNotification.show(
              context, state.depositAmountErrorText),
          buildWhen: (previous, current) =>
              previous.depositAmountErrorText != current.depositAmountErrorText,
          builder: (context, state) => AmountTextField(
            decimalDigits: 0,
            onChanged: (value) => context.read<DepositBloc>().add(
                DepositAmountChanged(
                    value.isNotEmpty ? double.parse(value) : 0)),
            backgroundColor: AskLoraColors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 17, vertical: 14),
            errorText: state.depositAmountErrorText,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomTextNew(
          S.of(context).exchangeRateInDepositScreen('13:12:14'),
          style:
              AskLoraTextStyles.body4.copyWith(color: AskLoraColors.darkGray),
        ),
      ],
    );
  }
}
