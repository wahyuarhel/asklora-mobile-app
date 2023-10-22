import 'package:equatable/equatable.dart';

class AskloraNotification extends Equatable {
  const AskloraNotification({
    required this.title,
    required this.body,
  });

  final String title;

  final String body;

  @override
  List<Object> get props => [title, body];
}
