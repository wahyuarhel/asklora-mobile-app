import 'package:asklora_mobile_app/feature/tabs/bloc/tab_screen_bloc.dart';
import 'package:asklora_mobile_app/feature/tabs/utils/tab_util.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tab Screen Bloc', () {
    late TabScreenBloc tabScreenBloc;

    setUp(() async {
      tabScreenBloc = TabScreenBloc(initialTabPage: TabPage.forYou);
    });
    test('init screen default page should be for you', () {
      expect(
        tabScreenBloc.state,
        const TabScreenState(currentTabPage: TabPage.forYou),
      );
    });
    blocTest<TabScreenBloc, TabScreenState>(
      'screen should be in "for you" screen when user clicked first tab',
      build: () => tabScreenBloc,
      act: (bloc) {
        bloc.add(const TabChanged(TabPage.forYou));
      },
      expect: () => {const TabScreenState(currentTabPage: TabPage.forYou)},
    );
    blocTest<TabScreenBloc, TabScreenState>(
      'aiPageSelected = true when user clicked middle tab (AI)',
      build: () => tabScreenBloc,
      act: (bloc) {
        bloc.add(const OnAiOverlayClick());
      },
      expect: () => {
        const TabScreenState(
            currentTabPage: TabPage.forYou, aiPageSelected: true)
      },
    );
    blocTest<TabScreenBloc, TabScreenState>(
      'screen should be in "portfolio" screen when user clicked third tab',
      build: () => tabScreenBloc,
      act: (bloc) {
        bloc.add(const TabChanged(TabPage.portfolio));
      },
      expect: () => {
        const TabScreenState(currentTabPage: TabPage.forYou),
        const TabScreenState(currentTabPage: TabPage.portfolio),
      },
    );

    tearDown(() => {tabScreenBloc.close()});
  });
}
