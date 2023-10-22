import 'dart:math';

import 'package:equatable/equatable.dart';

enum ConversationType { me, lora, loraError, loading, reset, next, component }

abstract class Conversation extends Equatable {
  final bool isNeedCallback;

  ConversationType type();

  const Conversation({this.isNeedCallback = false});

  static empty() => const [];

  @override
  List<Object?> get props => [type()];
}

class Lora extends Conversation {
  final String text;

  const Lora(this.text, {bool isNeedCallback = true})
      : super(isNeedCallback: isNeedCallback);

  @override
  ConversationType type() => ConversationType.lora;

  @override
  List<Object?> get props => [type(), text, isNeedCallback];

  Lora copyWith({bool? isNeedCallback}) =>
      Lora(text, isNeedCallback: isNeedCallback ?? this.isNeedCallback);
}

class LoraError extends Lora {
  static const _errorMessages = [
    'I am having a bit of trouble with your current question. Can you please try another question?',
    'Lora is working on some optimizations to serve you better. Can you please ask a different question?',
    'There\'s a small interruption in my service. Lora is working hard to restore it. Would you mind asking another question?',
    'Apologies! I\'m currently facing an issue. Could we explore a different topic please?'
  ];

  const LoraError(super.text, {bool isNeedCallback = true})
      : super(isNeedCallback: isNeedCallback);

  static String message() =>
      _errorMessages[Random().nextInt(_errorMessages.length)];

  @override
  ConversationType type() => ConversationType.loraError;

  @override
  LoraError copyWith({bool? isNeedCallback}) =>
      LoraError(text, isNeedCallback: isNeedCallback ?? this.isNeedCallback);

  @override
  List<Object?> get props => [type(), isNeedCallback];
}

class Me extends Conversation {
  final String text;
  final String userName;

  const Me(this.text, this.userName) : super();

  @override
  ConversationType type() => ConversationType.me;

  @override
  List<Object?> get props => [text, type(), isNeedCallback];
}

class NextButton extends Conversation {
  @override
  ConversationType type() => ConversationType.next;

  const NextButton() : super(isNeedCallback: false);

  @override
  List<Object?> get props => [type(), isNeedCallback];
}

class Loading extends Conversation {
  @override
  ConversationType type() => ConversationType.loading;

  const Loading({bool isNeedCallback = true})
      : super(isNeedCallback: isNeedCallback);

  @override
  List<Object?> get props => [type()];

  Loading copyWith({bool? isNeedCallback}) =>
      Loading(isNeedCallback: isNeedCallback ?? this.isNeedCallback);
}

class Reset extends Conversation {
  @override
  ConversationType type() => ConversationType.reset;

  const Reset() : super(isNeedCallback: false);

  @override
  List<Object?> get props => [type(), isNeedCallback];
}
