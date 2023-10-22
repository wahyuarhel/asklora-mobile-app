part of 'lora_ask_name_bloc.dart';

abstract class LoraAskNameEvent extends Equatable {
  const LoraAskNameEvent() : super();

  @override
  List<Object> get props => [];
}

class NameChanged extends LoraAskNameEvent {
  const NameChanged(this.name) : super();

  final String name;

  @override
  List<Object> get props => [name];
}

class SubmitUserName extends LoraAskNameEvent {
  const SubmitUserName() : super();

  @override
  List<Object> get props => [];
}

class ReSubmitUserName extends LoraAskNameEvent {
  const ReSubmitUserName() : super();

  @override
  List<Object> get props => [];
}
