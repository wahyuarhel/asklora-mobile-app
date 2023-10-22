import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/bloc/app_bloc.dart';
import '../../../core/presentation/custom_header.dart';
import '../../../core/presentation/custom_scaffold.dart';
import '../../../core/presentation/custom_stretched_layout.dart';
import '../../../core/presentation/we_create/localization_toggle_button/localization_toggle_button.dart';
import '../../../generated/l10n.dart';
import '../widget/menu_selection_button_widget.dart';

class LanguageSelectionScreen extends StatelessWidget {
  static const route = '/language_selection_screen';

  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: CustomStretchedLayout(
            header: CustomHeader(title: S.of(context).language),
            content: BlocBuilder<AppBloc, AppState>(
              buildWhen: (previous, current) =>
                  previous.locale != current.locale,
              builder: (context, state) {
                return Column(
                  children: [
                    MenuSelectionButtonWidget(
                      title: 'English',
                      onTap: () => context.read<AppBloc>().add(
                          AppLanguageChangeEvent(
                              LocaleType.supportedLocales()[0])),
                      isSelected: state.locale.languageCode == 'en',
                    ),
                    MenuSelectionButtonWidget(
                      title: '繁體中文',
                      onTap: () => context.read<AppBloc>().add(
                          AppLanguageChangeEvent(
                              LocaleType.supportedLocales()[1])),
                      showBottomBorder: false,
                      isSelected: state.locale.languageCode == 'zh',
                    ),
                  ],
                );
              },
            )));
  }

  static void open(BuildContext context) => Navigator.pushNamed(context, route);
}
