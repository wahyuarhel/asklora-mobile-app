import 'package:flutter_bloc/flutter_bloc.dart';
import '../../lora_gpt/bloc/lora_gpt_bloc.dart';

class MainAiLoraGptBloc extends LoraGptBloc {
  MainAiLoraGptBloc(
      {required super.loraGptRepository, required super.sharedPreference});

  @override
  Future<void> onFetchIntros(
      FetchIntros event, Emitter<LoraGptState> emit) async {
    add(SubmitLora(
        future: loraGptRepository.welcomeStarter(
            params: state.getLandingPageIntroRequest)));
    add(SubmitLora(
        future: loraGptRepository.welcomeNews(
            params: state.getLandingPageIntroRequest)));
  }
}
