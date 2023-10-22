part of 'toggleable_price_text_bloc.dart';

// events
abstract class ToggleEvent {}

class TogglePriceDifferenceEvent extends ToggleEvent {
  final bool? showPriceDifference;

  TogglePriceDifferenceEvent({this.showPriceDifference});
}
