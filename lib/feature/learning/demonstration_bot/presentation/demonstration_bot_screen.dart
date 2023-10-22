import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import '../../../../../core/domain/base_response.dart';
import '../../../../../core/presentation/custom_text_new.dart';
import '../../../../../core/presentation/navigation/bloc/navigation_bloc.dart';
import '../../../../../core/styles/asklora_colors.dart';
import '../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../core/values/app_values.dart';
import '../../../../core/presentation/lora_popup_message/lora_popup_message.dart';
import '../../../../generated/l10n.dart';
import '../../../bot_stock/domain/bot_recommendation_model.dart';
import '../../../bot_stock/presentation/bot_recommendation/bot_recommendation_screen.dart';
import '../../../bot_stock/repository/bot_stock_repository.dart';
import '../../../bot_stock/utils/bot_stock_utils.dart';
import '../../../tabs/presentation/tab_screen.dart';
import '../../learning_bot_stock_screen.dart';
import '../../widgets/demonstration_tooltip_guide.dart';
import '../bloc/demonstration_bot_bloc.dart';
import '../utils/demonstration_bottom_sheet.dart';

part 'widgets/demonstration_bot_list.dart';

class DemonstrationBotScreen extends StatelessWidget {
  static const String route = '/demonstration_bot_screen';

  final BotType botType;
  final JustTheController tooltipController;

  const DemonstrationBotScreen(
      {required this.tooltipController, required this.botType, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context
            .read<NavigationBloc<LearningBotStockPageStep>>()
            .add(const PagePop());
        return false;
      },
      child: BlocProvider(
        create: (_) =>
            DemonstrationBotBloc(botStockRepository: BotStockRepository())
              ..add(FetchBotDemonstration()),
        child: BlocListener<DemonstrationBotBloc, DemonstrationBotState>(
          listenWhen: (previous, current) =>
              previous.botDemonstrationResponse.state !=
              current.botDemonstrationResponse.state,
          listener: (context, state) {
            if (state.botDemonstrationResponse.state == ResponseState.success) {
              DemonstrationBottomSheet.show(
                context,
                title:
                    "Let's see the recommendations based on your Investment style.",
                primaryButtonLabel: 'VIEW RECOMMENDATIONS',
                secondaryButtonLabel: 'Continue Later',
                onPrimaryButtonTap: () {
                  tooltipController.showTooltip();
                  Navigator.pop(context);
                },
                onSecondaryButtonTap: () =>
                    TabScreen.openAndRemoveAllRoute(context),
              );
            }
          },
          child: Padding(
            padding: AppValues.screenHorizontalPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _backButton(context),
                _contents(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _contents(BuildContext context) => Expanded(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 35),
          children: [
            _header(context),
            DemonstrationBotList(
              botType: botType,
              verticalMargin: 14,
              tooltipController: tooltipController,
            ),
            const SizedBox(
              height: 40,
            ),
            _loraMemojiWidget,
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      );

  Widget _backButton(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: InkWell(
            onTap: () => context
                .read<NavigationBloc<LearningBotStockPageStep>>()
                .add(const PagePop()),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 24,
              color: AskLoraColors.charcoal,
            )),
      );

  Widget _header(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextNew(
            S.of(context).botRecommendationScreenTitle,
            style: AskLoraTextStyles.h2.copyWith(color: AskLoraColors.charcoal),
          ),
          const SizedBox(
            height: 8,
          ),
          CustomTextNew(
            'For demonstration purposes only. NOT a real trade.',
            style:
                AskLoraTextStyles.body1.copyWith(color: AskLoraColors.charcoal),
          ),
        ],
      );

  Widget get _loraMemojiWidget => const LoraPopUpMessage(
        titleColor: AskLoraColors.white,
        subTitleColor: AskLoraColors.white,
        backgroundColor: AskLoraColors.charcoal,
        title: 'The recommendation is based on your investment preference.',
        primaryButtonLabel: '',
        subTitle:
            'Investment preference included Investment Style, Privacy Questions and Personalisation Questions.',
      );

  static void open(BuildContext context) => Navigator.pushNamed(
        context,
        route,
      );
}
