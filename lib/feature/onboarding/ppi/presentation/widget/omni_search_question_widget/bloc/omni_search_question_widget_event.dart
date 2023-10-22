part of 'omni_search_question_widget_bloc.dart';

abstract class OmniSearchQuestionWidgetEvent extends Equatable {
  OmniSearchQuestionWidgetEvent() : super();

  final int timeStamp = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object> get props => [timeStamp];
}

class KeywordChanged extends OmniSearchQuestionWidgetEvent {
  final String keyword;

  KeywordChanged(this.keyword);
}

class KeywordAdded extends OmniSearchQuestionWidgetEvent {
  final String keywordInput;

  KeywordAdded(this.keywordInput);
}

class KeywordRemoved extends OmniSearchQuestionWidgetEvent {
  final String keyword;

  KeywordRemoved(this.keyword);
}

class KeywordSelected extends OmniSearchQuestionWidgetEvent {
  final String keyword;

  KeywordSelected(this.keyword);
}

class KeywordReset extends OmniSearchQuestionWidgetEvent {
  KeywordReset();
}
