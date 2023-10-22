import 'package:flutter/material.dart';

import '../../../../../../app/bloc/app_bloc.dart';
import '../../../../../../core/presentation/buttons/primary_button.dart';
import '../../../../../../core/presentation/column_text/pair_column_text_with_tooltip.dart';
import '../../../../../../core/presentation/custom_text_new.dart';
import '../../../../../../core/presentation/lora_popup_message/lora_popup_message.dart';
import '../../../../../../core/styles/asklora_colors.dart';
import '../../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../../core/utils/feature_flags.dart';
import '../../../../../../core/values/app_values.dart';
import '../../../../../balance/deposit/presentation/welcome/deposit_welcome_screen.dart';
import '../../../../../balance/deposit/utils/deposit_utils.dart';
import '../../../../domain/orders/bot_active_order_detail_model.dart';
import '../../../../utils/bot_stock_utils.dart';
import '../../../widgets/custom_detail_expansion_tile.dart';
import '../bot_portfolio_detail_screen.dart';

class BotPortfolioDetailContent extends StatelessWidget {
  final BotActiveOrderDetailModel? botActiveOrderDetailModel;

  final SizedBox _spaceBetweenInfo = const SizedBox(
    height: 16,
  );

  const BotPortfolioDetailContent({this.botActiveOrderDetailModel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (botActiveOrderDetailModel != null) {
      final BotType botType = botActiveOrderDetailModel!.botType;
      final BotStatus botStatus = botActiveOrderDetailModel!.botStatus;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppValues.screenHorizontalPadding,
            child: Column(
              children: [
                Performance(
                  botType: botType,
                  botActiveOrderDetailModel: botActiveOrderDetailModel!,
                ),
                const SizedBox(
                  height: 33,
                ),
                KeyInfo(
                  botStatus: botStatus,
                  botType: botType,
                  botActiveOrderDetailModel: botActiveOrderDetailModel!,
                ),
                const SizedBox(
                  height: 35,
                ),
              ],
            ),
          ),
          if (!FeatureFlags.isMockApp) _botExpansionTile(botType),
          if (!UserJourney.compareUserJourney(
              context: context, target: UserJourney.deposit))
            Padding(
              padding: AppValues.screenHorizontalPadding.copyWith(top: 40.0),
              child: LoraPopUpMessage(
                backgroundColor: AskLoraColors.charcoal,
                title: 'Take the next step towards gift redemption!',
                titleColor: AskLoraColors.white,
                subTitle: 'The secret of getting ahead is getting started.',
                subTitleColor: AskLoraColors.white,
                primaryButtonLabel: 'Complete Milestone',
                onPrimaryButtonTap: () => DepositWelcomeScreen.open(
                    context: context, depositType: DepositType.firstTime),
                buttonPrimaryType: ButtonPrimaryType.solidGreen,
                bottomText: 'Next Step: Pay deposit',
              ),
            )
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _botExpansionTile(BotType botType) => Column(
        children: [
          CustomDetailExpansionTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextNew(
                  '${botType.upperCaseName} Bots',
                  style: AskLoraTextStyles.h5
                      .copyWith(color: AskLoraColors.charcoal),
                ),
                CustomTextNew(
                  botActiveOrderDetailModel!.botInfo.botDescription.detail,
                  style: AskLoraTextStyles.body3
                      .copyWith(color: AskLoraColors.charcoal),
                )
              ],
            ),
            children: [
              CustomTextNew(
                'Best Suited For',
                style: AskLoraTextStyles.body4
                    .copyWith(color: AskLoraColors.charcoal),
              ),
              const SizedBox(
                height: 6,
              ),
              CustomTextNew(
                botActiveOrderDetailModel!.botInfo.botDescription.suited,
                style: AskLoraTextStyles.body1
                    .copyWith(color: AskLoraColors.charcoal),
              ),
              const SizedBox(
                height: 18,
              ),
              CustomTextNew(
                'How It Works',
                style: AskLoraTextStyles.body4
                    .copyWith(color: AskLoraColors.charcoal),
              ),
              const SizedBox(
                height: 6,
              ),
              CustomTextNew(
                botActiveOrderDetailModel!.botInfo.botDescription.works,
                style: AskLoraTextStyles.body1
                    .copyWith(color: AskLoraColors.charcoal),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          CustomDetailExpansionTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextNew(
                  'About ${botActiveOrderDetailModel!.stockInfoWithPlaceholder.tickerName} ${botActiveOrderDetailModel!.stockInfoWithPlaceholder.symbol}',
                  style: AskLoraTextStyles.h5
                      .copyWith(color: AskLoraColors.charcoal),
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomTextNew(
                  botActiveOrderDetailModel!.stockInfoWithPlaceholder.industry,
                  style: AskLoraTextStyles.body2
                      .copyWith(color: AskLoraColors.charcoal),
                )
              ],
            ),
            children: [
              CustomTextNew(
                'About ${botActiveOrderDetailModel!.stockInfoWithPlaceholder.tickerName}',
                style: AskLoraTextStyles.h6
                    .copyWith(color: AskLoraColors.charcoal),
              ),
              const SizedBox(
                height: 21,
              ),
              PairColumnTextWithTooltip(
                leftTitle: 'Sector(s)',
                leftSubTitle:
                    botActiveOrderDetailModel!.stockInfoWithPlaceholder.sector,
                rightTitle: 'Industry',
                rightSubTitle: botActiveOrderDetailModel!
                    .stockInfoWithPlaceholder.industry,
              ),
              _spaceBetweenInfo,
              PairColumnTextWithTooltip(
                leftTitle: 'CEO',
                leftSubTitle:
                    botActiveOrderDetailModel!.stockInfoWithPlaceholder.ceo,
                rightTitle: 'Employees',
                rightSubTitle:
                    '${botActiveOrderDetailModel!.stockInfoWithPlaceholder.employees}',
              ),
              _spaceBetweenInfo,
              PairColumnTextWithTooltip(
                leftTitle: 'Headquarters',
                leftSubTitle: botActiveOrderDetailModel!
                    .stockInfoWithPlaceholder.headquarter,
                rightTitle: 'Founded',
                rightSubTitle: botActiveOrderDetailModel!
                    .stockInfoWithPlaceholder.foundedFormatted,
              ),
              const SizedBox(
                height: 23,
              ),
              CustomTextNew(
                botActiveOrderDetailModel!.stockInfoWithPlaceholder.description,
                style: AskLoraTextStyles.body1
                    .copyWith(color: AskLoraColors.charcoal),
              )
            ],
          ),
        ],
      );
}
