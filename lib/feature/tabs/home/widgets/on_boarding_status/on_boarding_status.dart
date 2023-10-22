import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/bloc/app_bloc.dart';
import '../../../../../core/presentation/custom_text_new.dart';
import '../../../../../core/styles/asklora_colors.dart';
import '../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../generated/l10n.dart';
import '../../../../ai/investment_style_question/presentation/ai_investment_style_question_welcome_screen.dart';
import '../../../../balance/deposit/presentation/welcome/deposit_welcome_screen.dart';
import '../../../../balance/deposit/utils/deposit_utils.dart';
import '../../../../bot_stock/utils/bot_stock_utils.dart';
import '../../../../learning/learning_bot_stock_screen.dart';
import '../../../../onboarding/kyc/presentation/kyc_screen.dart';
import 'domain/on_boarding_status_model.dart';

part 'widgets/on_boarding_status_button.dart';

class OnBoardingStatus extends StatelessWidget {
  final Color valueColor;
  final Color backgroundColor;
  final double edgeRadius;
  final int intersectCount;
  final int arrowPointingOnSection;
  final Color completeColor;

  const OnBoardingStatus(
      {this.valueColor = AskLoraColors.primaryMagenta,
      this.backgroundColor = AskLoraColors.charcoal,
      this.arrowPointingOnSection = 1,
      this.edgeRadius = 10,
      this.intersectCount = 2,
      this.completeColor = AskLoraColors.primaryGreen,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
        buildWhen: (previous, current) =>
            previous.userJourney != current.userJourney,
        builder: (context, state) {
          final OnBoardingStatusModel onBoardingStatusModel =
              _onBoardingStatusModel(context, state.userJourney);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomTextNew(
                      onBoardingStatusModel.title,
                      style: AskLoraTextStyles.h4,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(edgeRadius)),
                    child: LinearProgressIndicator(
                      minHeight: 10,
                      value: onBoardingStatusModel.progress,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          onBoardingStatusModel.progress != 1
                              ? valueColor
                              : completeColor),
                      backgroundColor: backgroundColor,
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: getIntersectContainer),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              _isShowOnBoardingStatusButton(
                  onBoardingStatusModel, state.userJourney)
            ],
          );
        });
  }

  List<Widget> get getIntersectContainer {
    List<Widget> children = [];
    for (int i = 0; i < intersectCount; i++) {
      children.add(
        Container(
          height: 10,
          width: 4,
          color: Colors.white,
        ),
      );
    }
    return children;
  }

  OnBoardingStatusModel _onBoardingStatusModel(
      BuildContext context, UserJourney userJourney) {
    switch (userJourney) {
      case UserJourney.investmentStyle:
        return OnBoardingStatusModel(
          title: S.of(context).greatStart,
          subTitle: S.of(context).defineInvestmentStyle,
          onTap: () => AiInvestmentStyleQuestionWelcomeScreen.open(context),
          progress: 0.17,
        );
      case UserJourney.kyc:
        return OnBoardingStatusModel(
          title: S.of(context).halfWayThere,
          subTitle: S.of(context).openInvestmentAccount,
          onTap: () => KycScreen.open(context),
          progress: 0.5,
        );
      case UserJourney.deposit:
        return OnBoardingStatusModel(
          title: S.of(context).almostFinished,
          subTitle: S.of(context).depositFundToStartInvesting,
          onTap: () => DepositWelcomeScreen.open(
              context: context, depositType: DepositType.firstTime),
          progress: 0.67,
        );
      case UserJourney.learnBotPlank:
        return OnBoardingStatusModel(
          title: S.of(context).startInvestingOnMilestone,
          subTitle: '',
          onTap: () => LearningBotStockScreen.open(
            context: context,
            botType: BotType.plank,
          ),
          progress: 1,
        );
      default:
        return OnBoardingStatusModel(
          title: '',
          subTitle: '',
          onTap: () {},
          progress: 0,
        );
    }
  }

  Widget _isShowOnBoardingStatusButton(
      OnBoardingStatusModel onBoardingStatusModel, UserJourney userJourney) {
    return onBoardingStatusModel.progress != 1
        ? OnBoardingStatusButton(
            arrowPointingOnSection: userJourney == UserJourney.kyc ||
                    userJourney == UserJourney.deposit
                ? arrowPointingOnSection + 1
                : arrowPointingOnSection,
            onTap: onBoardingStatusModel.onTap,
            intersectCount: intersectCount,
            subTitle: onBoardingStatusModel.subTitle,
          )
        : const SizedBox.shrink();
  }
}
