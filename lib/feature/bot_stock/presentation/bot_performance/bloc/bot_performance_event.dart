part of 'bot_performance_bloc.dart';

abstract class BotPerformanceEvent extends Equatable {
  const BotPerformanceEvent();

  @override
  List<Object> get props => [];
}

class FetchBotPerformance extends BotPerformanceEvent {
  final String botOrderId;

  const FetchBotPerformance({required this.botOrderId});
}
