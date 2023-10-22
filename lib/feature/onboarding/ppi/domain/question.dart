import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable()
class Question {
  @JsonKey(name: 'answers')
  List<Choices>? choices;
  String? hints;
  String? question;
  String? section;
  @JsonKey(name: 'question_type')
  String? questionType;
  String? questionIndex;
  @JsonKey(name: 'question_id')
  String? questionId;

  Question({
    this.choices,
    this.hints,
    this.question,
    this.section,
    this.questionType,
    this.questionIndex,
    this.questionId,
  });

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);

  Question copyWith({
    List<Choices>? choices,
    String? hints,
    String? question,
    String? section,
    String? questionType,
    String? questionIndex,
    String? questionId,
  }) {
    return Question(
      choices: choices ?? this.choices,
      hints: hints ?? this.hints,
      question: question ?? this.question,
      section: section ?? this.section,
      questionType: questionType ?? this.questionType,
      questionIndex: questionIndex ?? this.questionIndex,
      questionId: questionId ?? this.questionId,
    );
  }

  @override
  String toString() {
    return 'Choices { hints: $hints, question: $question, section: $section, questionType: $questionType }';
  }
}

class Choices {
  int? id;
  String? name;
  String? score;
  String? answerType;
  bool? selectable;

  Choices({this.name, this.score, this.selectable});

  Choices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    score = json['score'].toString();
    answerType = json['answer_type'];
    selectable = json['selectable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['score'] = score;
    data['selectable'] = selectable;
    data['answer_type'] = answerType;
    return data;
  }

  @override
  String toString() {
    return 'Choices { id:$id, name: $name, score: $score, answer_type: $answerType }';
  }
}
