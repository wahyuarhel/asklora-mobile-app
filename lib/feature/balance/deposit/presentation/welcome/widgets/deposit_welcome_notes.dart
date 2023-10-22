part of '../deposit_welcome_screen.dart';

class DepositWelcomeNotes extends StatelessWidget {
  final DepositType depositType;

  const DepositWelcomeNotes(
      {this.depositType = DepositType.firstTime, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextNew(
          '${S.of(context).notes}:',
          style:
              AskLoraTextStyles.body4.copyWith(color: AskLoraColors.darkGray),
        ),
        const SizedBox(
          height: 4,
        ),
        (depositType == DepositType.firstTime ||
                depositType == DepositType.changeBankAccount)
            ? Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Column(
                  children: _firstTimeNotes(context),
                ),
              )
            : _returningUserNotes(context)
      ],
    );
  }

  List<Widget> _firstTimeNotes(BuildContext context) => [
        _depositNote(
          label: '1.',
          text: S.of(context).weWillTakeInformationCollectedFromYour(
              DepositType.firstTime.minDepositString),
        ),
        _depositNote(
          label: '2.',
          text: S.of(context).pleaseAddAHkBankAccount,
        ),
        _depositNote(
          label: '3.',
          text: S.of(context).weWillOnlyAcceptDepositViaBankTransfer,
        ),
        _depositNote(
          label: '4.',
          text: S.of(context).weWillOnlyAcceptHKD,
        ),
      ];

  Widget _returningUserNotes(BuildContext context) => CustomTextNew(
        S.of(context).returningUserDepositNotes,
        style: AskLoraTextStyles.body4.copyWith(color: AskLoraColors.darkGray),
      );

  Widget _depositNote({required String label, required String text}) => Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: CustomExpandedRow(
          label,
          text: text,
          padding: EdgeInsets.zero,
          leftTextStyle:
              AskLoraTextStyles.body4.copyWith(color: AskLoraColors.darkGray),
          rightTextStyle:
              AskLoraTextStyles.body4.copyWith(color: AskLoraColors.darkGray),
          flex1: 1,
          flex2: 20,
          textValueAlign: TextAlign.start,
        ),
      );
}
