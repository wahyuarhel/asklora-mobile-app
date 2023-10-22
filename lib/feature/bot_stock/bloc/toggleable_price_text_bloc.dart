import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/storage/shared_preference.dart';
import '../../../core/utils/storage/storage_keys.dart';

part 'toggleable_price_text_event.dart';

part 'toggleable_price_text_state.dart';

class ToggleablePriceTextBloc extends Bloc<ToggleEvent, ToggleState> {
  ToggleablePriceTextBloc({required SharedPreference sharedPreference})
      : _sharedPreference = sharedPreference,
        super(ShowPriceDifferenceState(false)) {
    on<TogglePriceDifferenceEvent>(_mapTogglePriceDifferenceEventToState);
    _loadUserChoice();
  }

  final SharedPreference _sharedPreference;

  void _mapTogglePriceDifferenceEventToState(
      TogglePriceDifferenceEvent event, Emitter<ToggleState> emit) {
    final showPriceDifference =
        event.showPriceDifference ?? !state.showPriceDifference;

    emit(ShowPriceDifferenceState(showPriceDifference));

    _saveUserChoice(showPriceDifference);
  }

  Future<void> _loadUserChoice() async {
    final choice = await _sharedPreference
            .readBoolData(StorageKeys.sfShowPriceDifference) ??
        false;
    add(TogglePriceDifferenceEvent(showPriceDifference: choice));
  }

  Future<void> _saveUserChoice(bool showPriceDifference) async =>
      _sharedPreference.writeBoolData(
          StorageKeys.sfShowPriceDifference, showPriceDifference);
}
