import 'conversation.dart';

enum ComponentType {
  promptButton('prompt_btn'),
  navigationButton('nav_btn');

  final String value;

  const ComponentType(this.value);

  static ComponentType findByString(String aiComponentTypeString) =>
      ComponentType.values
          .firstWhere((element) => element.value == aiComponentTypeString);
}

abstract class Component extends Conversation {
  final String id;
  final String label;

  const Component(this.id, this.label, {bool isNeedCallback = true})
      : super(isNeedCallback: isNeedCallback);

  ComponentType componentType();

  static empty() => const [];

  @override
  ConversationType type() => ConversationType.component;

  @override
  List<Object?> get props => [type()];
}

class PromptButton extends Component {
  const PromptButton(String id, String label, {bool isNeedCallback = true})
      : super(id, label, isNeedCallback: isNeedCallback);

  @override
  ComponentType componentType() => ComponentType.promptButton;

  PromptButton copyWith({bool? isNeedCallback}) => PromptButton(id, label,
      isNeedCallback: isNeedCallback ?? this.isNeedCallback);

  @override
  List<Object?> get props => [componentType(), isNeedCallback];

  @override
  String toString() => 'prompt button $label';
}

class NavigationButton extends Component {
  const NavigationButton(String id, String label, this.route,
      {bool isNeedCallback = false})
      : super(id, label, isNeedCallback: isNeedCallback);

  final String route;

  @override
  ComponentType componentType() => ComponentType.navigationButton;

  NavigationButton copyWith({bool? isNeedCallback}) =>
      NavigationButton(id, label, route,
          isNeedCallback: isNeedCallback ?? this.isNeedCallback);

  @override
  List<Object?> get props => [componentType(), isNeedCallback];
}
