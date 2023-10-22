import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/domain/base_response.dart';
import '../../../../chart/domain/bot_portfolio_chart_models.dart';
import '../../../repository/bot_stock_repository.dart';

part 'bot_performance_event.dart';

part 'bot_performance_state.dart';

class BotPerformanceBloc
    extends Bloc<BotPerformanceEvent, BotPerformanceState> {
  BotPerformanceBloc({required BotStockRepository botStockRepository})
      : _botStockRepository = botStockRepository,
        super(const BotPerformanceState()) {
    on<FetchBotPerformance>(_onFetchBotPerformance);
  }

  final BotStockRepository _botStockRepository;

  _onFetchBotPerformance(
      FetchBotPerformance event, Emitter<BotPerformanceState> emit) async {
    emit(state.copyWith(botPerformanceResponse: BaseResponse.loading()));
    var data = await _botStockRepository.fetchBotPerformance(event.botOrderId);
    emit(state.copyWith(botPerformanceResponse: data));
  }
}
