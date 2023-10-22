import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/domain/base_response.dart';
import '../../../../../core/domain/transaction/transaction_balance_response.dart';
import '../../../../../core/repository/transaction_repository.dart';
import '../../../../../core/utils/bloc_transformer/restartable.dart';
import '../../../../../core/utils/currency_enum.dart';
import '../../../../tabs/lora_gpt/domain/portfolio_query_request.dart';
import '../../../domain/orders/bot_active_order_detail_model.dart';
import '../../../domain/orders/bot_active_order_model.dart';
import '../../../domain/orders/bot_order_response.dart';
import '../../../repository/bot_stock_repository.dart';
import '../../../utils/bot_stock_utils.dart';

part 'portfolio_event.dart';

part 'portfolio_state.dart';

class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  PortfolioBloc(
      {required BotStockRepository botStockRepository,
      required TransactionRepository transactionHistoryRepository})
      : _botStockRepository = botStockRepository,
        _transactionHistoryRepository = transactionHistoryRepository,
        super(const PortfolioState()) {
    on<FetchActiveOrderDetail>(_onFetchActiveOrderDetail);
    on<FetchActiveOrders>(onFetchBotActiveOrders, transformer: restartable());
    on<ActiveFilterChecked>(_onActiveFilterChecked);
    on<PendingFilterChecked>(_onPendingFilterChecked);
    on<CurrencyChanged>(_onCurrencyChanged);
    on<RolloverBotStock>(_onRolloverBotStock);
    on<EndBotStock>(_onEndBotStock);
    on<CancelBotStock>(_onCancelBotStock);
    on<FetchBalance>(_onFetchBalance);
  }

  final BotStockRepository _botStockRepository;
  final TransactionRepository _transactionHistoryRepository;

  _onFetchBalance(FetchBalance event, Emitter<PortfolioState> emit) async {
    emit(state.copyWith(transactionBalanceResponse: BaseResponse.loading()));
    var balance = await _transactionHistoryRepository.fetchBalance();
    emit(state.copyWith(transactionBalanceResponse: balance));
  }

  onFetchBotActiveOrders(
      FetchActiveOrders event, Emitter<PortfolioState> emit) async {
    emit(state.copyWith(botActiveOrderResponse: BaseResponse.loading()));
    var data =
        await _botStockRepository.activeOrders(status: getFilterStatus(state));
    emit(state.copyWith(botActiveOrderResponse: data));
  }

  List<String> getFilterStatus(PortfolioState state) {
    List<String> status = [];
    if (state.activeFilterChecked) {
      status.addAll(BotStatus.live.omsStatusCollection.map((e) => e.value));
    }
    if (state.pendingFilterChecked) {
      status.addAll(BotStatus.pending.omsStatusCollection.map((e) => e.value));
    }
    return status;
  }

  _onFetchActiveOrderDetail(
      FetchActiveOrderDetail event, Emitter<PortfolioState> emit) async {
    emit(state.copyWith(botActiveOrderDetailResponse: BaseResponse.loading()));
    var data = await _botStockRepository.activeOrderDetail(event.botOrderId);
    emit(state.copyWith(botActiveOrderDetailResponse: data));
  }

  _onActiveFilterChecked(
      ActiveFilterChecked event, Emitter<PortfolioState> emit) async {
    emit(state.copyWith(activeFilterChecked: event.isChecked));
    add(const FetchActiveOrders());
  }

  _onPendingFilterChecked(
      PendingFilterChecked event, Emitter<PortfolioState> emit) async {
    emit(state.copyWith(pendingFilterChecked: event.isChecked));
    add(const FetchActiveOrders());
  }

  _onCurrencyChanged(CurrencyChanged event, Emitter<PortfolioState> emit) {
    emit(state.copyWith(currency: event.currencyType));
  }

  _onEndBotStock(EndBotStock event, Emitter<PortfolioState> emit) async {
    emit(state.copyWith(endBotStockResponse: BaseResponse.loading()));
    var data = await _botStockRepository.terminateOrder(event.botOrderId);
    emit(state.copyWith(endBotStockResponse: data));
  }

  _onCancelBotStock(CancelBotStock event, Emitter<PortfolioState> emit) async {
    emit(state.copyWith(cancelBotStockResponse: BaseResponse.loading()));
    var data = await _botStockRepository.cancelOrder(event.botOrderId);
    emit(state.copyWith(cancelBotStockResponse: data));
  }

  _onRolloverBotStock(
      RolloverBotStock event, Emitter<PortfolioState> emit) async {
    emit(state.copyWith(rolloverBotStockResponse: BaseResponse.loading()));
    var data = await _botStockRepository.rolloverOrder(event.botOrderId);
    emit(state.copyWith(rolloverBotStockResponse: data));
  }
}
