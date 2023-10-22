import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/tab_util.dart';

part 'tab_screen_event.dart';

part 'tab_screen_state.dart';

class TabScreenBloc extends Bloc<TabScreenEvent, TabScreenState> {
  TabScreenBloc({required TabPage initialTabPage})
      : super(TabScreenState(
            currentTabPage: initialTabPage,
            backgroundImageType: initialTabPage.backgroundImageType)) {
    on<TabChanged>(_onTabChanged);
    on<OnAiOverlayClick>(_onAiOverlayClick);
    on<CloseAiOverLay>(_onCloseAiOverlay);
    on<BackButtonClicked>(_onBackButtonClicked);
    on<BackgroundImageTypeChanged>(_onBackgroundImageTypeChanged);
  }

  _onTabChanged(TabChanged event, Emitter<TabScreenState> emit) {
    final subPage = state.currentTabPage.getArguments;

    if (!state.aiPageSelected) {
      if (event.tabPage == TabPage.forYou) {
        if (subPage.path == SubTabPage.recommendationsBotStockDetails.value) {
          emit(state.copyWith(isBotDetailScreenOpened: true));
        } else {
          emit(state.copyWith(isBotDetailScreenOpened: false));
        }
      } else if (event.tabPage == TabPage.portfolio) {
        if (event.tabPage == TabPage.portfolio &&
            subPage.path == SubTabPage.portfolioBotStockDetails.value) {
          emit(state.copyWith(isPortfolioDetailScreenOpened: true));
        } else {
          emit(state.copyWith(isPortfolioDetailScreenOpened: false));
        }
      }
    }

    if (state.currentTabPage != event.tabPage) {
      //Remove the data when tab change.
      state.currentTabPage.setData();
    }
    emit(state.copyWith(
        currentTabPage: event.tabPage,
        aiPageSelected: false,
        backgroundImageType: event.tabPage == state.currentTabPage
            ? state.backgroundImageType
            : event.tabPage.backgroundImageType));
  }

  _onAiOverlayClick(OnAiOverlayClick event, Emitter<TabScreenState> emit) {
    /// if the AI overlay screen is opened then close, vice-versa.
    emit(state.copyWith(aiPageSelected: !state.aiPageSelected));
  }

  _onCloseAiOverlay(CloseAiOverLay event, Emitter<TabScreenState> emit) {
    emit(state.copyWith(aiPageSelected: false));
  }

  _onBackButtonClicked(
      BackButtonClicked event, Emitter<TabScreenState> emit) async {
    if (state.tabScreenBackState == TabScreenBackState.none) {
      emit(state.copyWith(
          tabScreenBackState: TabScreenBackState.openConfirmation));
      await Future.delayed(const Duration(seconds: 3));
      emit(state.copyWith(tabScreenBackState: TabScreenBackState.none));
    } else if (state.tabScreenBackState ==
        TabScreenBackState.openConfirmation) {
      emit(state.copyWith(tabScreenBackState: TabScreenBackState.closeApp));
    }
  }

  _onBackgroundImageTypeChanged(
          BackgroundImageTypeChanged event, Emitter<TabScreenState> emit) =>
      emit(state.copyWith(
        backgroundImageType: event.backgroundImageType,
      ));
}
