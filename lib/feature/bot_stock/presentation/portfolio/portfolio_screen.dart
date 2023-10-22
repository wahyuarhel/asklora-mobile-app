import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

import '../../../../../../core/domain/base_response.dart';
import '../../../../../../core/presentation/buttons/others/funding_button.dart';
import '../../../../../../core/presentation/custom_scaffold.dart';
import '../../../../../../core/presentation/custom_text_new.dart';
import '../../../../../../core/styles/asklora_colors.dart';
import '../../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../../core/values/app_values.dart';
import '../../../../app/bloc/app_bloc.dart';
import '../../../../core/domain/transaction/transaction_balance_response.dart';
import '../../../../core/domain/validation_enum.dart';
import '../../../../core/presentation/auto_sized_text_widget.dart';
import '../../../../core/presentation/column_text/pair_column_text.dart';
import '../../../../core/presentation/column_text/pair_column_text_with_auto_sized_text.dart';
import '../../../../core/presentation/column_text/pair_column_text_with_bottom_sheet.dart';
import '../../../../core/presentation/custom_checkbox_list_tile.dart';
import '../../../../core/presentation/custom_layout_with_blur_pop_up.dart';
import '../../../../core/presentation/lora_popup_message/model/lora_pop_up_message_model.dart';
import '../../../../core/presentation/round_colored_box.dart';
import '../../../../core/presentation/shimmer.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/currency_enum.dart';
import '../../../../core/utils/feature_flags.dart';
import '../../../../generated/l10n.dart';
import '../../../balance/deposit/presentation/welcome/deposit_welcome_screen.dart';
import '../../../balance/deposit/utils/deposit_utils.dart';
import '../../../balance/withdrawal/presentation/withdrawal_bank_detail_screen.dart';
import '../../../settings/bloc/account_information/account_information_bloc.dart';
import '../../../settings/presentation/settings_screen.dart';
import '../../../tabs/bloc/tab_screen_bloc.dart';
import '../../../tabs/utils/tab_util.dart';
import '../../domain/orders/bot_active_order_model.dart';
import '../../utils/bot_stock_utils.dart';
import 'bloc/portfolio_bloc.dart';
import 'detail/bot_portfolio_detail_screen.dart';
import 'utils/portfolio_utils.dart';
import 'widgets/bot_portfolio_pop_up.dart';
import 'widgets/currency_toggle_button.dart';

part 'widgets/bot_portfolio_card.dart';
part 'widgets/bot_portfolio_card_shimmer.dart';
part 'widgets/bot_portfolio_filter.dart';
part 'widgets/bot_portfolio_list.dart';
part 'widgets/free_bot_badge.dart';
part 'widgets/portfolio_balance.dart';

class PortfolioScreen extends StatelessWidget {
  static const String route = '/portfolio_screen';

  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: CustomScaffold(
        useSafeArea: false,
        backgroundColor: AskLoraColors.white,
        enableBackNavigation: false,
        body: BlocBuilder<PortfolioBloc, PortfolioState>(
          buildWhen: (previous, current) =>
              previous.transactionBalanceResponse !=
                  current.transactionBalanceResponse ||
              previous.botActiveOrderResponse !=
                  current.botActiveOrderResponse ||
              previous.currency != current.currency,
          builder: (context, state) => RefreshIndicator(
            onRefresh: () async {
              ///fetch portfolio when current UserJourney already passed freeBotStock
              if (UserJourney.compareUserJourney(
                  context: context, target: UserJourney.freeBotStock)) {
                context.read<PortfolioBloc>().add(const FetchActiveOrders());
                context.read<PortfolioBloc>().add(FetchBalance());
              }
              context
                  .read<AccountInformationBloc>()
                  .add(GetAccountInformation());
            },
            child: CustomLayoutWithBlurPopUp(
              loraPopUpMessageModel: LoraPopUpMessageModel(
                title: S.of(context).errorGettingInformationTitle,
                subTitle:
                    S.of(context).errorGettingInformationPortfolioSubTitle,
                primaryButtonLabel: S.of(context).buttonReloadPage,
                onPrimaryButtonTap: () {
                  context.read<PortfolioBloc>().add(const FetchActiveOrders());
                  context.read<PortfolioBloc>().add(FetchBalance());
                },
              ),
              showPopUp: (state.botActiveOrderResponse.state ==
                          ResponseState.error &&
                      state.botActiveOrderResponse.validationCode !=
                          ValidationCode.tradeAuthorization) ||
                  state.transactionBalanceResponse.state == ResponseState.error,
              content: ListView(
                padding: AppValues.screenHorizontalPadding
                    .copyWith(top: 15, bottom: 15),
                children: [
                  _header(context),
                  PortfolioBalance(
                    data: state.transactionBalanceResponse.data ??
                        TransactionBalanceResponse.placeholder,
                    currencyType: state.currency,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  BotPortfolioList(
                    userJourney: context.read<AppBloc>().state.userJourney,
                    portfolioState: state,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (!FeatureFlags.isMockApp)
            Column(
              children: [
                getSvgIcon('icon_notification', color: AskLoraColors.black),
                const SizedBox(width: 15),
              ],
            ),
          InkWell(
              onTap: () => SettingsScreen.open(context),
              child: getSvgIcon('icon_settings', color: AskLoraColors.black)),
        ],
      );

  static void open(BuildContext context) => Navigator.pushNamed(context, route);
}
