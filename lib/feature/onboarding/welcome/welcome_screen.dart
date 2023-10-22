import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/presentation/animated_text.dart';
import '../../../../../core/presentation/buttons/button_pair.dart';
import '../../../../../core/presentation/custom_scaffold.dart';
import '../../../../../core/presentation/custom_text_new.dart';
import '../../../../../core/presentation/navigation/bloc/navigation_bloc.dart';
import '../../../../../core/presentation/rotate_animated_text.dart';
import '../../../../../core/presentation/round_colored_box.dart';
import '../../../../../core/presentation/we_create/localization_toggle_button/localization_toggle_button.dart';
import '../../../../../core/styles/asklora_colors.dart';
import '../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/values/app_values.dart';
import '../../../../../generated/l10n.dart';
import '../../../core/presentation/buttons/primary_button.dart';
import '../../../core/presentation/custom_stretched_layout.dart';
import '../../../core/presentation/we_create/custom_text_button.dart';
import '../../../core/utils/feature_flags.dart';
import '../../auth/sign_in/presentation/sign_in_screen.dart';
import '../../backdoor/presentation/backdoor_screen.dart';
import 'ask_name/presentation/ask_name_screen.dart';

part 'pages/carousel_page.dart';

part 'pages/welcome_page.dart';

enum WelcomePages { carousel, welcome }

class WelcomeScreen extends StatelessWidget {
  static const route = '/welcome_screen';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    precacheImages(context);
    return CustomScaffold(
      useSafeArea: false,
      appBarBackgroundColor: Colors.transparent,
      enableBackNavigation: false,
      body: BlocProvider(
        create: (_) => NavigationBloc<WelcomePages>(WelcomePages.carousel),
        child: BlocBuilder<NavigationBloc<WelcomePages>,
            NavigationState<WelcomePages>>(builder: (context, state) {
          switch (state.page) {
            case WelcomePages.carousel:
              return const CarouselPage();
            case WelcomePages.welcome:
              return const WelcomePage();
          }
        }),
      ),
    );
  }

  void precacheImages(BuildContext context) {
    precachePngImage('welcome_screen_whistle', context);
    precachePngImage('welcome_screen_chess', context);
    precachePngImage('welcome_screen_setting', context);
  }

  static void open(BuildContext context) =>
      Navigator.of(context).pushNamed(route);

  static void openAndRemoveAllRoute(BuildContext context) =>
      Navigator.of(context)
          .pushNamedAndRemoveUntil(route, (Route<dynamic> route) => false);
}
