part of 'lora_gpt_bloc.dart';

abstract class LoraGptEvent extends Equatable {
  const LoraGptEvent();
}

class OnEditQuery extends LoraGptEvent {
  final String query;

  const OnEditQuery(this.query);

  @override
  List<Object?> get props => [query];
}

class OnSearchQuery extends LoraGptEvent {
  const OnSearchQuery();

  @override
  List<Object?> get props => [];
}

class OnPromptTap extends LoraGptEvent {
  final String query;

  const OnPromptTap(this.query);

  @override
  List<Object?> get props => [query];
}

class OnResetSession extends LoraGptEvent {
  const OnResetSession();

  @override
  List<Object?> get props => [];
}

class OnStartTyping extends LoraGptEvent {
  const OnStartTyping();

  @override
  List<Object?> get props => [];
}

class OnFinishTyping extends LoraGptEvent {
  final Conversation conversation;

  const OnFinishTyping(this.conversation);

  @override
  List<Object?> get props => [];
}

class OnAiOverlayClose extends LoraGptEvent {
  const OnAiOverlayClose();

  @override
  List<Object?> get props => [];
}

class FetchIntros extends LoraGptEvent {
  const FetchIntros();

  @override
  List<Object?> get props => [];
}

class SubmitLora extends LoraGptEvent {
  final bool isShowErrorChat;
  final String debugText;
  final Future<BaseResponse<QueryResponse>> future;

  const SubmitLora(
      {required this.future,
      this.isShowErrorChat = false,
      this.debugText = ''});

  @override
  List<Object?> get props => [future, isShowErrorChat, debugText];
}

class OnLoraOpened extends LoraGptEvent {
  const OnLoraOpened();

  @override
  List<Object?> get props => [];
}

abstract class StoreLora extends LoraGptEvent {
  const StoreLora();
}

class StorePortfolioDetails extends StoreLora {
  final double totalPortfolioPnl;

  const StorePortfolioDetails({required this.totalPortfolioPnl});

  @override
  List<Object?> get props => [totalPortfolioPnl];
}

class StorePortfolio extends StoreLora {
  final List<Botstock> botstocks;

  const StorePortfolio({required this.botstocks});

  @override
  List<Object?> get props => [botstocks];
}

class StoreTabPage extends StoreLora {
  final TabPage tabPage;

  const StoreTabPage({required this.tabPage});

  @override
  List<Object?> get props => [tabPage];
}
