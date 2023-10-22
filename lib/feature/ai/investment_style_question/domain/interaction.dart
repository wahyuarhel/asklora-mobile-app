import 'package:equatable/equatable.dart';

enum ISQInteractionType { textField, choices, summary, empty, error }

abstract class ISQInteraction extends Equatable {
  ISQInteractionType type();

  static empty() => const [];

  @override
  List<Object?> get props => [type()];

  const ISQInteraction();
}

class TextFieldInteraction extends ISQInteraction {
  const TextFieldInteraction();

  @override
  ISQInteractionType type() => ISQInteractionType.textField;
}

class ChoicesInteraction extends ISQInteraction {
  final Map<String, String> choices;

  @override
  ISQInteractionType type() => ISQInteractionType.choices;

  const ChoicesInteraction(this.choices);

  @override
  List<Object?> get props => [type(), choices];
}

class SummaryInteraction extends ISQInteraction {
  @override
  ISQInteractionType type() => ISQInteractionType.summary;

  const SummaryInteraction();
}

class EmptyInteraction extends ISQInteraction {
  @override
  ISQInteractionType type() => ISQInteractionType.empty;

  const EmptyInteraction();
}

class ErrorInteraction extends ISQInteraction {
  @override
  ISQInteractionType type() => ISQInteractionType.error;

  const ErrorInteraction();
}
