part of 'toggleable_price_text_bloc.dart';

abstract class ToggleState {
  final bool showPriceDifference;

  ToggleState(this.showPriceDifference);
}

class ShowPriceDifferenceState extends ToggleState {
  ShowPriceDifferenceState(bool showPriceDifference)
      : super(showPriceDifference);
}
