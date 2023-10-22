import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/bloc/app_bloc.dart';
import '../../../styles/asklora_colors.dart';
import '../../custom_text.dart';

class LocalizationToggleButton extends StatelessWidget {
  const LocalizationToggleButton()
      : super(key: const Key('localization_toggle_button'));

  @override
  Widget build(BuildContext context) => AnimatedToggle(
      initialPosition:
          context.read<AppBloc>().state.locale.languageCode == 'en',
      onLanguageChange: (val) {
        context.read<AppBloc>().add(AppLanguageChangeEvent(val));
      });
}

class AnimatedToggle extends StatefulWidget {
  final bool initialPosition;

  const AnimatedToggle(
      {this.initialPosition = true, super.key, required this.onLanguageChange});

  final Function(LocaleType) onLanguageChange;

  @override
  State<AnimatedToggle> createState() => _AnimatedToggleState();
}

class _AnimatedToggleState extends State<AnimatedToggle> {
  bool initialPosition = true;

  @override
  void initState() {
    initialPosition = widget.initialPosition;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 110,
        height: 36,
        child: Stack(children: <Widget>[
          GestureDetector(
              onTap: () async {
                initialPosition = !initialPosition;
                LocaleType localeType = initialPosition
                    ? LocaleType.supportedLocales()[0]
                    : LocaleType.supportedLocales()[1];
                widget.onLanguageChange(localeType);
                setState(() {});
              },
              child: Container(
                  width: 110,
                  height: 36,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border:
                          Border.all(color: AskLoraColors.white, width: 1.5),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        LocaleType.supportedLocales().length,
                        (index) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: CustomText(
                              LocaleType.supportedLocales()[index].label,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w700,
                              type: FontType.smallNote,
                              color: AskLoraColors.white,
                            ))),
                  ))),
          AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              curve: Curves.decelerate,
              alignment: initialPosition
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Container(
                  margin: const EdgeInsets.all(4),
                  width: 52,
                  height: 30,
                  decoration: ShapeDecoration(
                    color: AskLoraColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: CustomText(
                    initialPosition
                        ? LocaleType.supportedLocales()[0].label
                        : LocaleType.supportedLocales()[1].label,
                    fontWeight: FontWeight.w700,
                    type: FontType.smallNote,
                    color: AskLoraColors.charcoal,
                  )))
        ]));
  }
}

class LocaleType {
  final String languageCode;
  final String countryCode;
  final String label;
  final String labelName;
  final String fontType;

  const LocaleType(this.languageCode, this.countryCode, this.label,
      this.labelName, this.fontType);

  static LocaleType findByLanguageCode(String? languageCode) =>
      supportedLocales().firstWhereOrNull(
          (element) => element.languageCode == languageCode) ??
      supportedLocales()[0];

  static const englishLocale =
      LocaleType('en', 'US', 'ENG', 'English', 'Manrope');
  static const chineseLocale =
      LocaleType('zh', 'HK', '中', '繁體中文', 'NotoSansTC');

  static List<LocaleType> supportedLocales() => [
        englishLocale,
        chineseLocale,
      ];

  static LocaleType defaultLocale() => englishLocale;
}
