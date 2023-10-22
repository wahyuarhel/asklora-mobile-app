part of '../deposit_screen.dart';

class DepositNotes extends StatelessWidget {
  final DepositType depositType;

  const DepositNotes({this.depositType = DepositType.firstTime, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextNew(
          S.of(context).notes,
          style:
              AskLoraTextStyles.body4.copyWith(color: AskLoraColors.darkGray),
        ),
        const SizedBox(
          height: 4,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 6),
          child: Column(
            children: depositType == DepositType.firstTime
                ? _firstTimeNotes(context)
                : _type1And2Notes(context),
          ),
        )
      ],
    );
  }

  List<Widget> _firstTimeNotes(context) => [
        _depositNote(
            label: '1.', text: S.of(context).pleaseMakeSureYouHaveFinished),
        _depositNote(label: '2.', text: S.of(context).yourDepositMayBeRejected),
        _depositNote(label: '3.', text: S.of(context).weAcceptHKDOnly),
      ];

  List<Widget> _type1And2Notes(context) => [
        _depositNote(
            label: '1.', text: S.of(context).pleaseMakeSureYouPressSubmit),
        _depositNote(label: '2.', text: S.of(context).yourDepositMayBeRejected),
        _depositNote(label: '3.', text: S.of(context).weAcceptHKDOnly),
      ];

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
