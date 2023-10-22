part of 'backdoor_screen_bloc.dart';

@immutable
abstract class BackdoorScreenEvent {}

class OnBaseUrlChanged extends BackdoorScreenEvent {
  final String baseUrl;

  OnBaseUrlChanged(this.baseUrl);
}

class InitOtpLoginDisabled extends BackdoorScreenEvent {}

class OnLoginVersionChanged extends BackdoorScreenEvent {
  final bool isOtpLoginDisabled;
  OnLoginVersionChanged(this.isOtpLoginDisabled);
}
