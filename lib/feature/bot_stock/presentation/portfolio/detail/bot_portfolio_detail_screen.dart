import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/feature_flags.dart';
import '../../../../../app/bloc/app_bloc.dart';
import '../../../../../core/domain/base_response.dart';
import '../../../../../core/presentation/buttons/primary_button.dart';
import '../../../../../core/presentation/column_text/column_text.dart';
import '../../../../../core/presentation/column_text/column_text_with_bottom_sheet.dart';
import '../../../../../core/presentation/column_text/column_text_with_tooltip.dart';
import '../../../../../core/presentation/column_text/pair_column_text.dart';
import '../../../../../core/presentation/column_text/pair_column_text_with_bottom_sheet.dart';
import '../../../../../core/presentation/column_text/pair_column_text_with_tooltip.dart';
import '../../../../../core/presentation/custom_in_app_notification.dart';
import '../../../../../core/presentation/custom_layout_with_blur_pop_up.dart';
import '../../../../../core/presentation/custom_scaffold.dart';
import '../../../../../core/presentation/custom_text_new.dart';
import '../../../../../core/presentation/loading/custom_loading_overlay.dart';
import '../../../../../core/presentation/lora_popup_message/model/lora_pop_up_message_model.dart';
import '../../../../../core/presentation/round_colored_box.dart';
import '../../../../../core/presentation/suspended_account_screen.dart';
import '../../../../../core/repository/transaction_repository.dart';
import '../../../../../core/styles/asklora_colors.dart';
import '../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../core/utils/back_button_interceptor/back_button_interceptor_bloc.dart';
import '../../../../../core/values/app_values.dart';
import '../../../../../generated/l10n.dart';
import '../../../../tabs/bloc/tab_screen_bloc.dart';
import '../../../../tabs/utils/tab_util.dart';
import '../../../bloc/bot_stock_bloc.dart';
import '../../../domain/orders/bot_active_order_detail_model.dart';
import '../../../repository/bot_stock_repository.dart';
import '../../../utils/bot_stock_bottom_sheet.dart';
import '../../../utils/bot_stock_utils.dart';
import '../../bot_performance/bot_performance_chart.dart';
import '../../bot_stock_result_screen.dart';
import '../../widgets/bot_stock_form.dart';
import '../bloc/portfolio_bloc.dart';
import 'widgets/bot_portfolio_detail_content.dart';

part 'widgets/bot_portfolio_detail_header.dart';

part 'widgets/buttons/bot_cancel_button.dart';

part 'widgets/buttons/bot_portfolio_buttons.dart';

part 'widgets/buttons/bot_rollover_button.dart';

part 'widgets/buttons/bot_terminate_button.dart';

part 'widgets/key_info.dart';

part 'widgets/performance.dart';

class BotPortfolioDetailScreen extends StatelessWidget {
  static const String route = '/bot_portfolio_detail_screen';
  final BotPortfolioDetailArguments arguments;

  const BotPortfolioDetailScreen({required this.arguments, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => CustomScaffold(
        enableBackNavigation: false,
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (_) => PortfolioBloc(
                    botStockRepository: BotStockRepository(),
                    transactionHistoryRepository: TransactionRepository())
                  ..add(FetchActiveOrderDetail(botOrderId: arguments.botUid))),
            BlocProvider(create: (_) => BackButtonInterceptorBloc())
          ],
          child: MultiBlocListener(
            listeners: [
              BlocListener<BackButtonInterceptorBloc,
                  BackButtonInterceptorState>(
                listener: (context, state) {
                  if (state is OnPressedBack) {
                    Navigator.of(context).maybePop();
                  }
                },
              ),
              BlocListener<TabScreenBloc, TabScreenState>(
                listenWhen: (previous, current) =>
                    previous.isPortfolioDetailScreenOpened !=
                    current.isPortfolioDetailScreenOpened,
                listener: (context, state) {
                  if (!state.isPortfolioDetailScreenOpened) {
                    Navigator.maybePop(context);
                  }
                },
              )
            ],
            child: BlocConsumer<PortfolioBloc, PortfolioState>(
              listenWhen: (previous, current) =>
                  previous.botActiveOrderDetailResponse.state !=
                  current.botActiveOrderDetailResponse.state,
              listener: (context, state) {
                CustomLoadingOverlay.of(context)
                    .show(state.botActiveOrderDetailResponse.state);

                if (state.botActiveOrderDetailResponse.state ==
                    ResponseState.loading) {
                  context
                      .read<BackButtonInterceptorBloc>()
                      .add(RemoveInterceptor());
                } else {
                  context
                      .read<BackButtonInterceptorBloc>()
                      .add(InitiateInterceptor());
                }
              },
              buildWhen: (previous, current) =>
                  previous.botActiveOrderDetailResponse.state !=
                  current.botActiveOrderDetailResponse.state,
              builder: (context, state) {
                final BotActiveOrderDetailModel? botActiveOrderDetailModel =
                    state.botActiveOrderDetailResponse.data;
                return RefreshIndicator(
                  onRefresh: () async => _fetchActiveOrderDetail(context),
                  child: CustomLayoutWithBlurPopUp(
                    loraPopUpMessageModel: LoraPopUpMessageModel(
                      title: S.of(context).errorGettingInformationTitle,
                      subTitle: S
                          .of(context)
                          .errorGettingInformationPortfolioSubTitle,
                      primaryButtonLabel: S.of(context).buttonReloadPage,
                      secondaryButtonLabel: S.of(context).buttonCancel,
                      onSecondaryButtonTap: () => Navigator.pop(context),
                      onPrimaryButtonTap: () =>
                          _fetchActiveOrderDetail(context),
                    ),
                    showPopUp: state.botActiveOrderDetailResponse.state ==
                        ResponseState.error,
                    content: BotStockForm(
                      useHeader: true,
                      customHeader: BotPortfolioDetailHeader(
                        title: arguments.botName,
                        botStatus: botActiveOrderDetailModel?.botStatus,
                      ),
                      padding: EdgeInsets.zero,
                      content: BotPortfolioDetailContent(
                        botActiveOrderDetailModel: botActiveOrderDetailModel,
                      ),
                      bottomButton: BotPortfolioButtons(portfolioState: state),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );

  void _fetchActiveOrderDetail(BuildContext context) => context
      .read<PortfolioBloc>()
      .add(FetchActiveOrderDetail(botOrderId: arguments.botUid));

  static void open(
      {required BuildContext context,
      required BotPortfolioDetailArguments arguments}) {
    Navigator.pushNamed(context, route, arguments: arguments).then((value) {
      context
          .read<TabScreenBloc>()
          .add(TabChanged(TabPage.portfolio.setData()));
      if (arguments.callback != null) {
        arguments.callback!();
      }
    });
  }

  static void openReplace(
          {required BuildContext context,
          required BotPortfolioDetailArguments arguments}) =>
      Navigator.pushReplacementNamed(context, route, arguments: arguments);
}

class BotPortfolioDetailArguments {
  final String botUid;
  final String botName;
  final VoidCallback? callback;

  const BotPortfolioDetailArguments({
    required this.botUid,
    required this.botName,
    this.callback,
  });
}
