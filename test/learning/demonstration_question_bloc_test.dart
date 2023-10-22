import 'package:asklora_mobile_app/feature/learning/demonstration_question/bloc/demonstration_question_bloc.dart';
import 'package:asklora_mobile_app/feature/learning/demonstration_question/repository/demonstration_question_repository.dart';
import 'package:asklora_mobile_app/feature/onboarding/ppi/domain/question.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'demonstration_question_bloc_test.mocks.dart';

@GenerateMocks([DemonstrationQuestionRepository])
void main() async {
  group('Demonstration Question Bloc Tests', () {
    late MockDemonstrationQuestionRepository demonstrationQuestionRepository;
    late DemonstrationQuestionBloc demonstrationQuestionBloc;

    final List<Question> questionCollection = [Question(), Question()];

    final List<bool> questionAnsweredList = [false, false];

    setUpAll(() async {
      demonstrationQuestionRepository = MockDemonstrationQuestionRepository();
    });

    setUp(() async {
      demonstrationQuestionBloc = DemonstrationQuestionBloc(
          demonstrationQuestionRepository: demonstrationQuestionRepository);
    });

    test('Demonstration Question Bloc init state', () {
      expect(
          demonstrationQuestionBloc.state, const DemonstrationQuestionState());
    });

    blocTest<DemonstrationQuestionBloc, DemonstrationQuestionState>(
        'emits `questionCollection` WHEN '
        'fetching question',
        build: () {
          when(demonstrationQuestionRepository.fetchQuestions())
              .thenAnswer((_) => Future.value(questionCollection));
          return demonstrationQuestionBloc;
        },
        act: (bloc) => bloc.add(FetchQuestion()),
        expect: () => {
              DemonstrationQuestionState(
                questionCollection: questionCollection,
                questionAnsweredList: questionAnsweredList,
              ),
            });

    blocTest<DemonstrationQuestionBloc, DemonstrationQuestionState>(
      'emits nothing WHEN '
      'trigger next question',
      build: () => demonstrationQuestionBloc,
      act: (bloc) => bloc.add(NextQuestion()),
    );

    blocTest<DemonstrationQuestionBloc, DemonstrationQuestionState>(
        'emits `question index = 1` WHEN '
        'trigger next question',
        build: () {
          when(demonstrationQuestionRepository.fetchQuestions())
              .thenAnswer((_) => Future.value(questionCollection));
          return demonstrationQuestionBloc;
        },
        act: (bloc) => {
              bloc.add(FetchQuestion()),
              bloc.add(NextQuestion()),
            },
        expect: () => {
              DemonstrationQuestionState(
                questionCollection: questionCollection,
                questionAnsweredList: questionAnsweredList,
              ),
              DemonstrationQuestionState(
                questionCollection: questionCollection,
                questionAnsweredList: questionAnsweredList,
                questionIndex: 1,
              ),
            });

    blocTest<DemonstrationQuestionBloc, DemonstrationQuestionState>(
        'emits `question index = 0` WHEN '
        'trigger next question and then trigger previous question',
        build: () {
          when(demonstrationQuestionRepository.fetchQuestions())
              .thenAnswer((_) => Future.value(questionCollection));
          return demonstrationQuestionBloc;
        },
        act: (bloc) => {
              bloc.add(FetchQuestion()),
              bloc.add(NextQuestion()),
              bloc.add(PreviousQuestion()),
            },
        expect: () => {
              DemonstrationQuestionState(
                questionCollection: questionCollection,
                questionAnsweredList: questionAnsweredList,
              ),
              DemonstrationQuestionState(
                questionCollection: questionCollection,
                questionAnsweredList: questionAnsweredList,
                questionIndex: 1,
              ),
              DemonstrationQuestionState(
                questionCollection: questionCollection,
                questionAnsweredList: questionAnsweredList,
                questionIndex: 0,
              ),
            });

    blocTest<DemonstrationQuestionBloc, DemonstrationQuestionState>(
        'emits `questionAnsweredList = [true,false]` WHEN '
        'answering on first index of question',
        build: () {
          when(demonstrationQuestionRepository.fetchQuestions())
              .thenAnswer((_) => Future.value(questionCollection));
          return demonstrationQuestionBloc;
        },
        act: (bloc) => {
              bloc.add(FetchQuestion()),
              bloc.add(AnswerQuestion(0)),
            },
        expect: () => {
              DemonstrationQuestionState(
                questionCollection: questionCollection,
                questionAnsweredList: questionAnsweredList,
              ),
              DemonstrationQuestionState(
                questionCollection: questionCollection,
                questionAnsweredList: const [true, false],
              ),
            });

    tearDown(() => {demonstrationQuestionBloc.close()});
  });
}
