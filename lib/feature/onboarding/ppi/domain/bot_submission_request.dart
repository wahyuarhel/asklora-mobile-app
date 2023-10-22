class BotSubmissionRequest {
  final String email;
  final List<int> choices;

  BotSubmissionRequest(this.email, this.choices);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['choices'] = choices;
    return data;
  }
}
