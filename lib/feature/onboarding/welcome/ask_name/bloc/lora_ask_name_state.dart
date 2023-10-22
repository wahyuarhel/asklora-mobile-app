part of 'lora_ask_name_bloc.dart';

class LoraAskNameState extends Equatable {
  const LoraAskNameState({
    this.name = '',
    this.response = const BaseResponse(),
  }) : super();

  final String name;
  final BaseResponse response;

  LoraAskNameState copyWith({
    String? name,
    BaseResponse? response,
  }) {
    return LoraAskNameState(
      name: name ?? this.name,
      response: response ?? this.response,
    );
  }

  @override
  List<Object> get props => [name, response];
}
