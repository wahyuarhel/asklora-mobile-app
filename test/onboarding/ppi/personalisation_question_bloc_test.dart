import 'package:asklora_mobile_app/feature/onboarding/ppi/presentation/personalisation_question/bloc/personalisation_question_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Personalisation Question Bloc Test', () {
    late PersonalisationQuestionBloc personalisationQuestionBloc;

    setUp(() async {
      personalisationQuestionBloc = PersonalisationQuestionBloc();
    });

    test(
        'Personalisation Question Bloc init sate is should be PersonalisationQuestionState',
        () {
      expect(personalisationQuestionBloc.state,
          const PersonalisationQuestionState());
    });

    blocTest<PersonalisationQuestionBloc, PersonalisationQuestionState>(
      'emits onNextInvestmentStyleQuestionScreen WHEN tap next button',
      build: () => personalisationQuestionBloc,
      act: (bloc) => bloc.add(NextPersonalisationQuestion()),
      expect: () => {OnNextResultEndScreen()},
    );
    blocTest<PersonalisationQuestionBloc, PersonalisationQuestionState>(
      'emits onPreviousPrivacyQuestionScreen WHEN tap cancel button',
      build: () => personalisationQuestionBloc,
      act: (bloc) => bloc.add(PreviousPersonalisationQuestion()),
      expect: () => {OnPreviousToPrivacyQuestionScreen()},
    );
    tearDown(() => {personalisationQuestionBloc.close()});
  });
}
