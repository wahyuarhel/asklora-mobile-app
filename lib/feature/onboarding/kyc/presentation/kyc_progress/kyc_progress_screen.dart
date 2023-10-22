import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/presentation/ai/lora_animation_green.dart';
import '../../../../../core/presentation/buttons/button_pair.dart';
import '../../../../../core/presentation/custom_text_new.dart';
import '../../../../../core/presentation/navigation/bloc/navigation_bloc.dart';
import '../../../../../core/presentation/round_colored_box.dart';
import '../../../../../core/styles/asklora_colors.dart';
import '../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../core/values/app_values.dart';
import '../../../../../generated/l10n.dart';
import '../../../../tabs/presentation/tab_screen.dart';
import '../../bloc/kyc_bloc.dart';
import '../widgets/custom_stepper/custom_stepper.dart';

class KycProgressScreen extends StatelessWidget {
  final int currentStep;

  const KycProgressScreen({this.currentStep = 0, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppValues.screenHorizontalPadding,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(width: 180, child: LoraAnimationGreen()),
            CustomTextNew(
              S.of(context).accountOpeningAndDeposit,
              style:
                  AskLoraTextStyles.h4.copyWith(color: AskLoraColors.charcoal),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            _kycSteps(context),
            const SizedBox(height: 20),
            _neededItems(context),
            const SizedBox(height: 57),
            CustomTextNew(
              S.of(context).onceYouHaveStarted,
              style: AskLoraTextStyles.subtitle3
                  .copyWith(color: AskLoraColors.charcoal),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            _bottomButton(context),
          ],
        ),
      ),
    );
  }

  Widget _bottomButton(BuildContext context) => ButtonPair(
        primaryButtonOnClick: () => context
            .read<NavigationBloc<KycPageStep>>()
            .add(const PageChanged(KycPageStep.residentCheck)),
        secondaryButtonOnClick: () => TabScreen.openAndRemoveAllRoute(context),
        primaryButtonLabel: S.of(context).openAccountNow,
        secondaryButtonLabel: S.of(context).buttonMaybeLater,
      );

  Widget _kycSteps(BuildContext context) => RoundColoredBox(
      key: const Key('kyc_steps'),
      title: S.of(context).getReadyForTrading,
      content: CustomStepper(
        currentStep: currentStep,
        steps: [
          S.of(context).setupPersonalInfo,
          S.of(context).setUpFinancialProfile,
          S.of(context).verifyIdentity,
          S.of(context).signAgreements,
        ],
      ));

  Widget _neededItems(BuildContext context) => RoundColoredBox(
      key: const Key('kyc_items_needed'),
      title: S.of(context).theItemYouWillNeed,
      content: Column(children: [
        _neededItem(S.of(context).hkId),
        const SizedBox(height: 10),
        _neededItem(S.of(context).porAddress,
            additionalText: S.of(context).weAcceptUtilityBill)
      ]));

  Widget _neededItem(String text, {String additionalText = ''}) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextNew(
            '●',
            style: AskLoraTextStyles.body1
                .copyWith(color: AskLoraColors.charcoal, height: 2),
          ),
          const SizedBox(
            width: 14,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextNew(
                  text,
                  style: AskLoraTextStyles.body1
                      .copyWith(color: AskLoraColors.charcoal),
                ),
                if (additionalText.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: CustomTextNew(
                      additionalText,
                      style: AskLoraTextStyles.body3
                          .copyWith(color: AskLoraColors.charcoal),
                    ),
                  ),
              ],
            ),
          )
        ],
      );
}
