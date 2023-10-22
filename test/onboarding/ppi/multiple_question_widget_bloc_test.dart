import 'package:asklora_mobile_app/feature/onboarding/ppi/presentation/widget/multiple_question_widget/bloc/multiple_question_widget_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  group('Multiple Question Widget Bloc Tests', () {
    late MultipleQuestionWidgetBloc multipleQuestionWidgetBloc;

    setUp(() async {
      multipleQuestionWidgetBloc = MultipleQuestionWidgetBloc();
    });

    test('Multiple Question Widget Bloc init defaultChoiceIndex should be -1',
        () {
      expect(multipleQuestionWidgetBloc.state,
          const MultipleQuestionWidgetState(defaultChoiceIndex: -1));
    });

    blocTest<MultipleQuestionWidgetBloc, MultipleQuestionWidgetState>(
        'emits defaultChoiceIndex 2 WHEN '
        'Tap second answer',
        build: () => multipleQuestionWidgetBloc,
        act: (bloc) => bloc.add(AnswerChanged(2)),
        expect: () =>
            {const MultipleQuestionWidgetState(defaultChoiceIndex: 2)});

    tearDown(() => {multipleQuestionWidgetBloc.close()});
  });
}
