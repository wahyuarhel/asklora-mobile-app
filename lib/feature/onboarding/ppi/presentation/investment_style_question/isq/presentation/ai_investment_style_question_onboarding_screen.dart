import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../app/bloc/app_bloc.dart';
import '../../../../../../../core/presentation/ai/utils/ai_utils.dart';
import '../../../../../../../core/utils/feature_flags.dart';
import '../../../../../../../core/utils/storage/shared_preference.dart';
import '../../../../../../bot_stock/presentation/gift/bot_stock_welcome_screen.dart';
import '../../investment_style_result_end_screen.dart';
import '../../../../../../ai/investment_style_question/presentation/ai_investment_style_question_form.dart';
import '../bloc/isq_onboarding_bloc.dart';

class AiInvestmentStyleQuestionOnboardingScreen extends StatelessWidget {
  static const String route = '/ai_investment_style_question_onboarding_screen';

  const AiInvestmentStyleQuestionOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => IsqOnBoardingBloc(sharedPreference: SharedPreference())
        ..add(const UpdateAiWelcomeScreenStatus(false)),
      lazy: false,
      child: AiInvestmentStyleQuestionForm(
        aiThemeType: AiThemeType.light,
        onFinished: () {
          if (FeatureFlags.isMockApp) {
            context
                .read<AppBloc>()
                .add(const SaveUserJourney(UserJourney.learnBotPlank));
            BotStockWelcomeScreen.open(context);
          } else {
            context.read<AppBloc>().add(const SaveUserJourney(UserJourney.kyc));
            InvestmentStyleResultScreen.open(context);
          }
        },
      ),
    );
  }

  static void open(BuildContext context) =>
      Navigator.of(context, rootNavigator: true).pushNamed(route);
}
