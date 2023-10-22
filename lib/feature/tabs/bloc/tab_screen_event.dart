part of 'tab_screen_bloc.dart';

abstract class TabScreenEvent {
  const TabScreenEvent();
}

class TabChanged extends TabScreenEvent {
  final TabPage tabPage;

  const TabChanged(this.tabPage);
}

class OnAiOverlayClick extends TabScreenEvent {
  const OnAiOverlayClick();
}

class CloseAiOverLay extends TabScreenEvent {
  const CloseAiOverLay();
}

class BackButtonClicked extends TabScreenEvent {}

class BackgroundImageTypeChanged extends TabScreenEvent {
  final BackgroundImageType backgroundImageType;

  const BackgroundImageTypeChanged(this.backgroundImageType);
}
