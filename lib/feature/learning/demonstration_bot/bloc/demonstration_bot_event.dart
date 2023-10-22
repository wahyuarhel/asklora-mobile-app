part of 'demonstration_bot_bloc.dart';

abstract class DemonstrationBotEvent extends Equatable {
  const DemonstrationBotEvent();

  @override
  List<Object> get props => [];
}

class FetchBotDemonstration extends DemonstrationBotEvent {}

class FetchChartData extends DemonstrationBotEvent {}

class FetchTradeChartData extends DemonstrationBotEvent {}
