import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/domain/base_response.dart';
import '../../../core/presentation/custom_header.dart';
import '../../../core/presentation/custom_scaffold.dart';
import '../../../core/presentation/custom_text_new.dart';
import '../../../core/presentation/loading/custom_loading_overlay.dart';
import '../../../core/styles/asklora_colors.dart';
import '../../../core/styles/asklora_text_styles.dart';
import '../../../core/values/app_values.dart';
import '../../../generated/l10n.dart';
import '../../bot_stock/presentation/portfolio/portfolio_screen.dart';
import '../../bot_stock/utils/bot_stock_utils.dart';
import '../bloc/transaction_history_bloc.dart';
import '../bot_order/detail/bot_order_transaction_history_detail_screen.dart';
import '../domain/grouped_model.dart';
import '../domain/transaction_history_model.dart';
import '../../../core/repository/transaction_repository.dart';
import '../transfer/detail/transfer_transaction_history_detail_screen.dart';
import '../utils/transaction_history_util.dart';
import 'widgets/empty_transaction_placeholder.dart';
import 'widgets/transaction_history_group_title.dart';

part 'widgets/transaction_history_group_widget.dart';

part 'widgets/transaction_history_list.dart';

part '../bot_order/bot_order_transaction_history_card.dart';

part '../bot_order/bot_order_transaction_history_list.dart';

part '../transfer/transfer_transaction_history_card.dart';

part '../transfer/transfer_transaction_history_list.dart';

class TransactionHistoryScreen extends StatelessWidget {
  static const String route = '/transaction_history_screen';

  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: BlocProvider(
        create: (_) => TransactionHistoryBloc(
            transactionHistoryRepository: TransactionRepository())
          ..add(FetchAllTransaction())
          ..add(FetchBotTransaction())
          ..add(FetchTransferTransaction()),
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              CustomHeader(title: S.of(context).transactionHistoryTitle),
              Container(
                margin: AppValues.screenHorizontalPadding.copyWith(top: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AskLoraColors.whiteSmoke,
                ),
                height: 40,
                child: TabBar(
                    labelStyle: AskLoraTextStyles.subtitle4,
                    padding: const EdgeInsets.all(2),
                    indicatorColor: Colors.red,
                    labelColor: AskLoraColors.charcoal,
                    unselectedLabelColor: AskLoraColors.darkGray,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AskLoraColors.primaryGreen),
                    tabs: [
                      Tab(
                        text: S.of(context).transactionHistoryTabAll,
                      ),
                      Tab(
                        text: S.of(context).transactionHistoryTabOrders,
                      ),
                      Tab(
                        text: S.of(context).transactionHistoryTabTransfer,
                      ),
                    ]),
              ),
              const SizedBox(
                height: 20,
              ),
              const Expanded(
                child: TabBarView(children: [
                  TransactionHistoryList(),
                  BotOrderTransactionHistoryList(),
                  TransferTransactionHistoryList(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void open(BuildContext context) => Navigator.pushNamed(context, route);
}
