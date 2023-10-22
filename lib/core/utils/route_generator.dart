import 'package:flutter/material.dart';
import '../../feature/bot_stock/presentation/gift/bot_stock_explanation_screen.dart';
import '../../feature/bot_stock/presentation/gift/gift_bot_stock_message.dart';
import '../../feature/onboarding/ppi/presentation/investment_style_question/isq/presentation/isq_onboarding_screen.dart';
import '../../feature/tabs/ai_landing_page/presentation/ai_landing_page.dart';
import '../../feature/tabs/utils/tab_util.dart';
import '../presentation/ai/utils/ai_utils.dart';
import '../../feature/onboarding/ppi/presentation/investment_style_question/isq/presentation/ai_investment_style_question_onboarding_screen.dart';
import '../../feature/ai/investment_style_question/presentation/ai_investment_style_question_welcome_screen.dart';
import '../../feature/auth/email_activation/presentation/email_activation_screen.dart';
import '../../feature/auth/otp/presentation/otp_screen.dart';
import '../../feature/auth/reset_password/presentation/reset_password_screen.dart';
import '../../feature/auth/sign_in/presentation/sign_in_screen.dart';
import '../../feature/auth/sign_up/presentation/sign_up_screen.dart';
import '../../feature/backdoor/presentation/backdoor_screen.dart';
import '../../feature/balance/deposit/presentation/deposit_result_screen.dart';
import '../../feature/balance/deposit/presentation/deposit_screen.dart';
import '../../feature/balance/deposit/presentation/welcome/deposit_welcome_screen.dart';
import '../../feature/balance/deposit/utils/deposit_utils.dart';
import '../../feature/balance/withdrawal/presentation/withdrawal_amount/withdrawal_amount_screen.dart';
import '../../feature/balance/withdrawal/presentation/withdrawal_bank_detail_screen.dart';
import '../../feature/balance/withdrawal/presentation/withdrawal_result_screen.dart';
import '../../feature/balance/withdrawal/presentation/withdrawal_summary_screen.dart';
import '../../feature/bot_stock/domain/bot_recommendation_model.dart';
import '../../feature/bot_stock/presentation/bot_recommendation/detail/bot_recommendation_detail_screen.dart';
import '../../feature/bot_stock/presentation/bot_recommendation/free_bot_recommendation_screen.dart';
import '../../feature/bot_stock/presentation/bot_stock_result_screen.dart';
import '../../feature/bot_stock/presentation/bot_trade_summary/bot_trade_summary_screen.dart';
import '../../feature/bot_stock/presentation/gift/bot_stock_do_screen.dart';
import '../../feature/bot_stock/presentation/gift/bot_explanation_screen.dart';
import '../../feature/bot_stock/presentation/gift/bot_stock_welcome_screen.dart';
import '../../feature/bot_stock/presentation/portfolio/detail/bot_portfolio_detail_screen.dart';
import '../../feature/bot_stock/presentation/portfolio/portfolio_screen.dart';
import '../../feature/bot_stock/utils/bot_stock_utils.dart';
import '../../feature/learning/learning_bot_stock_screen.dart';
import '../../feature/onboarding/kyc/presentation/kyc_screen.dart';
import '../../feature/onboarding/ppi/bloc/question/question_bloc.dart';
import '../../feature/onboarding/ppi/presentation/investment_style_question/investment_style_result_end_screen.dart';
import '../../feature/onboarding/ppi/presentation/investment_style_question/investment_style_welcome_screen.dart';
import '../../feature/onboarding/ppi/presentation/ppi_screen.dart';
import '../../feature/onboarding/welcome/ask_name/presentation/ask_name_screen.dart';
import '../../feature/onboarding/welcome/greeting/greeting_screen.dart';
import '../../feature/onboarding/welcome/welcome_screen.dart';
import '../../feature/orders/bloc/order_bloc.dart';
import '../../feature/orders/domain/symbol_detail.dart';
import '../../feature/orders/regular/presentation/regular_order_home_screen.dart';
import '../../feature/settings/domain/bank_account.dart';
import '../../feature/settings/presentation/about_asklora_screen.dart';
import '../../feature/settings/presentation/account_information_screen.dart';
import '../../feature/settings/presentation/account_setting_screen.dart';
import '../../feature/settings/presentation/change_password_screen.dart';
import '../../feature/settings/presentation/customer_service_screen.dart';
import '../../feature/settings/presentation/get_help_screen.dart';
import '../../feature/settings/presentation/language_selection_screen.dart';
import '../../feature/settings/presentation/notification_setting_screen.dart';
import '../../feature/settings/presentation/payment_detail_screen.dart';
import '../../feature/settings/presentation/privacy_policy_screen.dart';
import '../../feature/settings/presentation/settings_screen.dart';
import '../../feature/settings/presentation/terms_condition_screen.dart';
import '../../feature/tabs/for_you/for_you_screen_form.dart';
import '../../feature/tabs/for_you/investment_style/presentation/ai_investment_style_question_for_you_screen.dart';
import '../../feature/tabs/home/home_screen_form.dart';
import '../../feature/tabs/presentation/tab_screen.dart';
import '../../feature/transaction_history/bot_order/detail/bot_order_transaction_history_detail_screen.dart';
import '../../feature/transaction_history/domain/transaction_history_model.dart';
import '../../feature/transaction_history/presentation/transaction_history_screen.dart';
import '../../feature/transaction_history/transfer/detail/transfer_transaction_history_detail_screen.dart';
import '../domain/pair.dart';
import '../presentation/acknowledgement/domain/acknowledgement_model.dart';
import '../presentation/acknowledgement/presentation/acknowledgement_screen.dart';
import '../presentation/custom_status_widget.dart';
import '../presentation/photo_view_screen.dart';
import '../presentation/suspended_account_screen.dart';
import 'app_icons.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SignInScreen.route:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SignInScreen());
      case SignUpScreen.route:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SignUpScreen());
      case OtpScreen.route:
        var arguments = settings.arguments as Pair<String, String>;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) =>
                OtpScreen(email: arguments.left, password: arguments.right));
      case KycScreen.route:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const KycScreen());
      case DepositScreen.route:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => DepositScreen(
                  depositType: settings.arguments as DepositType,
                ));
      case PhotoViewScreen.route:
        ImageProvider imageProvider = settings.arguments as ImageProvider;
        return MaterialPageRoute(
            settings: settings, builder: (_) => PhotoViewScreen(imageProvider));
      case RegularOrderHomeScreen.route:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => RegularOrderHomeScreen(
                availableBuyingPower: 1000,
                symbolDetail: SymbolDetail(
                    'AAPL.O', 100, AppIcons.appleLogo, SymbolType.symbol)));
      case PpiScreen.route:
        var args =
            settings.arguments as Pair<QuestionPageType, QuestionPageStep>;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => PpiScreen(
                  questionPageType: args.left,
                  initialQuestionPage: args.right,
                ));
      case WelcomeScreen.route:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const WelcomeScreen());
      case AskNameScreen.route:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AskNameScreen());
      case GreetingScreen.route:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => GreetingScreen(name: settings.arguments as String));
      case EmailActivationScreen.route:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => EmailActivationScreen(
                arguments:
                    settings.arguments as EmailActivationScreenArguments));
      case ResetPasswordScreen.route:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => ResetPasswordScreen(
                resetPasswordToken: settings.arguments as String));
      case BotStockWelcomeScreen.route:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const BotStockWelcomeScreen());
      case BotExplanationScreen.route:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const BotExplanationScreen());
      case BotStockExplanationScreen.route:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const BotStockExplanationScreen());
      case BotStockDoScreen.route:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const BotStockDoScreen());
      case GiftBotStockMessageScreen.route:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const GiftBotStockMessageScreen());
      case FreeBotRecommendationScreen.route:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const FreeBotRecommendationScreen());
      case BotRecommendationDetailScreen.route:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => BotRecommendationDetailScreen(
                  botRecommendationModel:
                      settings.arguments as BotRecommendationModel,
                ));
      case BotPortfolioDetailScreen.route:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => BotPortfolioDetailScreen(
                  arguments: settings.arguments as BotPortfolioDetailArguments,
                ));
      case BotTradeSummaryScreen.route:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => BotTradeSummaryScreen(
                  botTradeSummaryModel:
                      settings.arguments as BotTradeSummaryModel,
                ));
      case PortfolioScreen.route:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const PortfolioScreen());
      case DepositWelcomeScreen.route:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => DepositWelcomeScreen(
                  initialDepositType: settings.arguments as DepositType?,
                ));
      case DepositResultScreen.route:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) {
              var arguments =
                  settings.arguments as Pair<DepositType, StatusType>;
              return DepositResultScreen(
                statusType: arguments.right,
                depositType: arguments.left,
              );
            });
      case WithdrawalBankDetailScreen.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => WithdrawalBankDetailScreen(
            withdrawableBalance: settings.arguments as double,
          ),
        );
      case WithdrawalAmountScreen.route:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => WithdrawalAmountScreen(
                    args: settings.arguments as ({
                  double withdrawableBalance,
                  BankAccount bankAccount
                })));
      case WithdrawalSummaryScreen.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => WithdrawalSummaryScreen(
            args: settings.arguments as ({
              double withdrawalAmount,
              BankAccount bankAccount
            }),
          ),
        );
      case WithdrawalResultScreen.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const WithdrawalResultScreen(),
        );
      case LearningBotStockScreen.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => LearningBotStockScreen(
            botType: settings.arguments as BotType,
          ),
        );
      case BotStockResultScreen.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BotStockResultScreen(
            arguments: settings.arguments as BotStockResultArgument,
          ),
        );
      case SettingsScreen.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SettingsScreen(),
        );
      case AboutAskloraScreen.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const AboutAskloraScreen(),
        );
      case GetHelpScreen.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const GetHelpScreen(),
        );
      case CustomerServiceScreen.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const CustomerServiceScreen(),
        );
      case AccountSettingScreen.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const AccountSettingScreen(),
        );
      case AccountInformationScreen.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const AccountInformationScreen(),
        );
      case LanguageSelectionScreen.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const LanguageSelectionScreen(),
        );
      case PrivacyPolicyScreen.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const PrivacyPolicyScreen(),
        );
      case TermsAndConditionScreen.route:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const TermsAndConditionScreen());
      case PaymentDetailScreen.route:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const PaymentDetailScreen());
      case NotificationSettingScreen.route:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const NotificationSettingScreen());
      case AcknowledgementScreen.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => AcknowledgementScreen(
            acknowledgementModel: settings.arguments as AcknowledgementModel,
          ),
        );
      case TransactionHistoryScreen.route:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const TransactionHistoryScreen());
      case BotOrderTransactionHistoryDetailScreen.route:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => BotOrderTransactionHistoryDetailScreen(
                  transactionHistoryModel:
                      settings.arguments as TransactionHistoryModel,
                ));
      case TransferTransactionHistoryDetailScreen.route:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => TransferTransactionHistoryDetailScreen(
                  transactionHistoryModel:
                      settings.arguments as TransactionHistoryModel,
                ));
      case ChangePasswordScreen.route:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ChangePasswordScreen());
      case SuspendedAccountScreen.route:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SuspendedAccountScreen());
      case ForYouScreenForm.route:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ForYouScreenForm());
      case HomeScreenForm.route:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const HomeScreenForm());
      case InvestmentStyleWelcomeScreen.route:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const InvestmentStyleWelcomeScreen());
      case InvestmentStyleResultScreen.route:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const InvestmentStyleResultScreen());
      case AiInvestmentStyleQuestionWelcomeScreen.route:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const AiInvestmentStyleQuestionWelcomeScreen());
      case IsqOnBoardingScreen.route:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const IsqOnBoardingScreen());
      case AiInvestmentStyleQuestionOnboardingScreen.route:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const AiInvestmentStyleQuestionOnboardingScreen());
      case AiInvestmentStyleQuestionForYouScreen.route:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => AiInvestmentStyleQuestionForYouScreen(
                  aiThemeType: settings.arguments as AiThemeType,
                ));
      case TabScreen.route:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => TabScreen(
                  initialTabPage: settings.arguments as TabPage?,
                ));
      case AiLandingPage.route:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AiLandingPage());
      case BackdoorScreen.route:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const BackdoorScreen());
      default:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text(
                          'No route defined for ${settings.name}')) /*Container()*/,
                ));
    }
  }
}
