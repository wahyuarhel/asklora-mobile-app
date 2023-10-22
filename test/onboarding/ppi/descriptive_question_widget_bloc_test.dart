import 'package:asklora_mobile_app/feature/onboarding/ppi/presentation/widget/descriptive_question_widget/bloc/descriptive_question_widget_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  group('Descriptive Question Widget Bloc Tests', () {
    late DescriptiveQuestionWidgetBloc descriptiveQuestionWidgetBloc;

    setUp(() async {
      descriptiveQuestionWidgetBloc = DescriptiveQuestionWidgetBloc();
    });

    test('Descriptive Question Widget Bloc init answer should be empty', () {
      expect(descriptiveQuestionWidgetBloc.state,
          const DescriptiveQuestionWidgetState(answer: ''));
    });

    blocTest<DescriptiveQuestionWidgetBloc, DescriptiveQuestionWidgetState>(
        'emits answer `tesla spaceX` WHEN '
        'input answer',
        build: () => descriptiveQuestionWidgetBloc,
        act: (bloc) => bloc.add(AnswerChanged('tesla spaceX')),
        expect: () =>
            {const DescriptiveQuestionWidgetState(answer: 'tesla spaceX')});

    tearDown(() => {descriptiveQuestionWidgetBloc.close()});
  });
}
