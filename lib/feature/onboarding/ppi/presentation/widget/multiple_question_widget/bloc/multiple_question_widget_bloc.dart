import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'multiple_question_widget_event.dart';

part 'multiple_question_widget_state.dart';

class MultipleQuestionWidgetBloc
    extends Bloc<MultipleQuestionWidgetEvent, MultipleQuestionWidgetState> {
  MultipleQuestionWidgetBloc({int defaultChoiceIndex = -1})
      : super(MultipleQuestionWidgetState(
            defaultChoiceIndex: defaultChoiceIndex)) {
    on<AnswerChanged>(_onAnswerChanged);
  }

  void _onAnswerChanged(
      AnswerChanged event, Emitter<MultipleQuestionWidgetState> emit) {
    emit(state.copyWith(defaultChoiceIndex: event.defaultChoiceIndex));
  }
}
