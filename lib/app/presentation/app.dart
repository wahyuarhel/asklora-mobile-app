import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../core/domain/token/repository/token_repository.dart';
import '../../core/push_notification/bloc/firebase_service_bloc.dart';
import '../../core/styles/asklora_colors.dart';
import '../../core/utils/feature_flags.dart';
import '../../core/utils/route_generator.dart';
import '../../core/utils/storage/secure_storage.dart';
import '../../core/utils/storage/shared_preference.dart';
import '../../feature/onboarding/ppi/presentation/investment_style_question/isq/presentation/isq_onboarding_screen.dart';
import '../../feature/onboarding/welcome/welcome_screen.dart';
import '../../feature/tabs/presentation/tab_screen.dart';
import '../../generated/l10n.dart';
import '../bloc/app_bloc.dart';
import '../repository/user_journey_repository.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  static final Map<int, Color> _colorCodes = {
    50: const Color.fromRGBO(35, 35, 1, .1),
    100: const Color.fromRGBO(35, 35, 1, .2),
    200: const Color.fromRGBO(35, 35, 1, .3),
    300: const Color.fromRGBO(35, 35, 1, .4),
    400: const Color.fromRGBO(35, 35, 1, .5),
    500: const Color.fromRGBO(35, 35, 1, .6),
    600: const Color.fromRGBO(35, 35, 1, .7),
    700: const Color.fromRGBO(35, 35, 1, .8),
    800: const Color.fromRGBO(35, 35, 1, .9),
    900: const Color.fromRGBO(35, 35, 1, 1),
  };

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => AppBloc(
                  tokenRepository: TokenRepository(),
                  userJourneyRepository: UserJourneyRepository(),
                  sharedPreference: SharedPreference(),
                  secureStorage: SecureStorage())
                ..add(AppLaunched())),
          BlocProvider(
              lazy: false,
              create: (_) => FirebaseServiceBLoc()..add(InitFirebase()))
        ],
        child: BlocConsumer<AppBloc, AppState>(
            listener: (_, __) => FlutterNativeSplash.remove(),
            buildWhen: (previous, current) {
              return (previous.status != current.status) ||
                  (previous.locale != current.locale);
            },
            builder: (context, state) => GestureDetector(
                onTap: () {
                  FocusScopeNode focus = FocusScope.of(context);
                  if (!focus.hasPrimaryFocus && focus.focusedChild != null) {
                    focus.focusedChild?.unfocus();
                  }
                },
                child: MaterialApp(
                    builder: (context, child) {
                      return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(textScaleFactor: 1.0),
                          child: child!);
                    },
                    debugShowCheckedModeBanner: false,
                    navigatorObservers: [SentryNavigatorObserver()],
                    localizationsDelegates: const [
                      S.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: const [
                      Locale('en', ''),
                      Locale.fromSubtags(
                          languageCode: 'zh',
                          scriptCode: 'Hant',
                          countryCode: 'HK'),
                    ],
                    locale: Locale(state.locale.languageCode, ''),
                    onGenerateRoute: RouterGenerator.generateRoute,
                    title: 'Asklora',
                    theme: ThemeData(
                        pageTransitionsTheme:
                            const PageTransitionsTheme(builders: {
                          TargetPlatform.android: ZoomPageTransitionsBuilder(),
                          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                        }),
                        useMaterial3: false,
                        fontFamily: state.locale.fontType,
                        primarySwatch: MaterialColor(
                            AskLoraColors.charcoal.value, _colorCodes)),
                    home: _getBody(state)))));
  }

  Widget _getBody(AppState state) {
    switch (state.status) {
      case AppStatus.authenticated:
        if (FeatureFlags.isMockApp &&
            state.userJourney == UserJourney.investmentStyle) {
          return const IsqOnBoardingScreen();
        } else {
          return const TabScreen();
        }
      case AppStatus.unauthenticated:
        return const WelcomeScreen();
      case AppStatus.unknown:
        return const SizedBox();
    }
  }
}
