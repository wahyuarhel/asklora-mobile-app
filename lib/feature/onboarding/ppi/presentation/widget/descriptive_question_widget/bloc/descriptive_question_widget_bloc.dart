import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'descriptive_question_widget_event.dart';

part 'descriptive_question_widget_state.dart';

class DescriptiveQuestionWidgetBloc extends Bloc<DescriptiveQuestionWidgetEvent,
    DescriptiveQuestionWidgetState> {
  DescriptiveQuestionWidgetBloc({String defaultAnswer = ''})
      : super(DescriptiveQuestionWidgetState(answer: defaultAnswer)) {
    on<AnswerChanged>(_onAnswerChanged);
  }

  void _onAnswerChanged(
      AnswerChanged event, Emitter<DescriptiveQuestionWidgetState> emit) {
    emit(state.copyWith(answer: event.answer));
  }
}
