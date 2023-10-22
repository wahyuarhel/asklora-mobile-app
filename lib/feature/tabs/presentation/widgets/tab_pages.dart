part of '../tab_screen.dart';

class TabPages extends StatelessWidget {
  final bool canTrade;

  const TabPages({required this.canTrade, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            BlocBuilder<TabScreenBloc, TabScreenState>(
              buildWhen: (previous, current) =>
                  previous.currentTabPage != current.currentTabPage,
              builder: (context, state) {
                switch (state.currentTabPage) {
                  case TabPage.home:
                    return _navigatorPage(HomeScreenForm.route);
                  case TabPage.forYou:
                    return _navigatorPage(ForYouScreenForm.route);
                  case TabPage.aiLandingPage:
                    return _navigatorPage(AiLandingPage.route);
                  case TabPage.portfolio:
                    return _navigatorPage(PortfolioScreen.route,
                        arguments: context);
                  case TabPage.none:
                    return const SizedBox.shrink();
                }
              },
            ),
            canTrade
                ? AiOverlay(
                    maxHeight: constraints.maxHeight,
                    maxWidth: constraints.maxWidth,
                  )
                : const SizedBox.shrink()
          ],
        );
      }),
    );
  }

  Widget _navigatorPage(String route, {dynamic arguments}) => Navigator(
        key: Key(route),
        onGenerateRoute: RouterGenerator.generateRoute,
        initialRoute: route,
      );
}
