import 'dart:convert';

import '../domain/fixture.dart';
import '../domain/ppi_api_repository.dart';
import '../domain/question.dart';

class PpiQuestionRepository {
  static PpiQuestionRepository? _instance;

  factory PpiQuestionRepository() => _instance ??= PpiQuestionRepository._();

  PpiQuestionRepository._();

  final PpiApiRepository _ppiApiRepository = PpiApiRepository();

  Future<Fixture> fetchPersonalAndPrivacyQuestions() async {
    // Let's keep it for a while as sometimes it good to test the PPI from local file.
    // final String response =
    //     await rootBundle.loadString('assets/json/question_list.json');

    final response = await _ppiApiRepository.fetchPersonalAndPrivacyQuestions();
    List<Question> questions = List.empty(growable: true);

    questions = (jsonDecode(jsonEncode(response.data)) as List)
        .map((i) => Question.fromJson(i))
        .toList();
    return Fixture.instance.fixPersonalisedQuestion(questions);
  }

  Future<Fixture> fetchInvestmentStyleQuestions(String accountId) async {
    final response =
        await _ppiApiRepository.fetchInvestmentStyleQuestions(accountId);
    List<Question> questions = List.empty(growable: true);

    questions = (jsonDecode(jsonEncode(response.data)) as List)
        .map((i) => Question.fromJson(i))
        .toList();
    return Fixture.instance.fixInvestmentStyleQuestion(questions);
  }

  Future<Fixture?> fetchInvestmentStyleQuestionsWithTryCatch(
      String accountId) async {
    try {
      final response =
          await _ppiApiRepository.fetchInvestmentStyleQuestions(accountId);
      List<Question> questions = List.empty(growable: true);

      questions = (jsonDecode(jsonEncode(response.data)) as List)
          .map((i) => Question.fromJson(i))
          .toList();
      return Fixture.instance.fixInvestmentStyleQuestion(questions);
    } catch (_) {
      return null;
    }
  }

  Future<Fixture> getQuestions() async {
    return Fixture.instance;
  }
}
