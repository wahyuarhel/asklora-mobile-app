import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/domain/base_response.dart';
import '../../../../../core/presentation/custom_layout_with_blur_pop_up.dart';
import '../../../../../core/presentation/custom_scaffold.dart';
import '../../../../../core/presentation/custom_text_new.dart';
import '../../../../../core/presentation/loading/custom_loading_overlay.dart';
import '../../../../../core/presentation/lora_popup_message/model/lora_pop_up_message_model.dart';
import '../../../../../core/styles/asklora_colors.dart';
import '../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../generated/l10n.dart';
import '../../../../core/presentation/auto_sized_text_widget.dart';
import '../../../../core/presentation/column_text/column_text_with_tooltip.dart';
import '../../../../core/presentation/column_text/pair_column_text_with_tooltip.dart';
import '../../../../core/presentation/round_colored_box.dart';
import '../../../../core/repository/transaction_repository.dart';
import '../../../../core/values/app_values.dart';
import '../../../bot_stock/utils/bot_stock_utils.dart';
import '../../domain/grouped_model.dart';
import '../../domain/transaction_history_model.dart';
import '../../presentation/widgets/empty_activity_placeholder.dart';
import '../../presentation/widgets/transaction_history_group_title.dart';
import '../../presentation/widgets/transaction_history_tab.dart';
import '../../utils/transaction_history_util.dart';
import 'bloc/bot_transaction_history_detail_bloc.dart';
import 'domain/bot_activities_transaction_history_model.dart';
import 'domain/bot_detail_transaction_history_response.dart';
import 'domain/bot_summary_transaction_history_model.dart';

part 'bot_order_transaction_history_activities_screen.dart';

part 'bot_order_transaction_history_performance_screen.dart';

part 'bot_order_transaction_history_summary_screen.dart';

part 'widgets/bot_order_transaction_history_activities_card.dart';

part 'widgets/bot_order_transaction_history_activities_group_widget.dart';

part 'widgets/bot_order_transaction_history_detail_content.dart';

part 'widgets/bot_order_transaction_history_summary_card.dart';

class BotOrderTransactionHistoryDetailScreen extends StatelessWidget {
  final TransactionHistoryModel transactionHistoryModel;
  static const String route = '/bot_transaction_history_detail_screen';

  const BotOrderTransactionHistoryDetailScreen(
      {required this.transactionHistoryModel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BotTransactionHistoryDetailBloc(
          transactionHistoryRepository: TransactionRepository())
        ..add(FetchBotTransactionDetail(transactionHistoryModel.idString)),
      child: CustomScaffold(
        enableBackNavigation: false,
        body: BlocConsumer<BotTransactionHistoryDetailBloc,
            BotTransactionHistoryDetailState>(
          listenWhen: (previous, current) =>
              previous.response.state != current.response.state,
          listener: (context, state) =>
              CustomLoadingOverlay.of(context).show(state.response.state),
          buildWhen: (previous, current) =>
              previous.response.state != current.response.state,
          builder: (context, state) {
            return CustomLayoutWithBlurPopUp(
              loraPopUpMessageModel: LoraPopUpMessageModel(
                title: S.of(context).errorGettingInformationTitle,
                subTitle: S
                    .of(context)
                    .errorGettingInformationTransactionHistorySubTitle,
                primaryButtonLabel: S.of(context).buttonReloadPage,
                secondaryButtonLabel: S.of(context).buttonCancel,
                onSecondaryButtonTap: () => Navigator.pop(context),
                onPrimaryButtonTap: () => context
                    .read<BotTransactionHistoryDetailBloc>()
                    .add(FetchBotTransactionDetail(
                        transactionHistoryModel.idString)),
              ),
              showPopUp: state.response.state == ResponseState.error,
              content: BotOrderTransactionHistoryDetailContent(
                title: transactionHistoryModel.title,
                botStatus: transactionHistoryModel.status,
                botOrderId: transactionHistoryModel.idString,
              ),
            );
          },
        ),
      ),
    );
  }

  static void open(BuildContext context,
          TransactionHistoryModel transactionHistoryModel) =>
      Navigator.pushNamed(context, route, arguments: transactionHistoryModel);
}
