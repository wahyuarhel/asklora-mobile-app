import 'package:flutter/material.dart';
import '../../../core/presentation/ai/lora_animation_magenta.dart';
import '../../../core/presentation/custom_scaffold.dart';
import '../../../core/presentation/custom_stretched_layout.dart';
import '../../../core/presentation/custom_text_new.dart';
import '../../../core/styles/asklora_colors.dart';
import '../../../core/styles/asklora_text_styles.dart';
import '../../../core/utils/app_icons.dart';
import '../../../core/values/app_values.dart';
import '../../../core/presentation/ai/buttons/glowing_button.dart';
import '../../../core/presentation/ai/utils/ai_utils.dart';
import 'widgets/ai_layout_with_background_layout.dart';

class AiWelcomeScreen extends StatelessWidget {
  final AiThemeType aiThemeType;
  final String title;
  final Widget? child;
  final VoidCallback onBottomButtonTap;
  final bool enableBackgroundImage;

  const AiWelcomeScreen(
      {this.aiThemeType = AiThemeType.light,
      required this.title,
      required this.onBottomButtonTap,
      this.child,
      this.enableBackgroundImage = true,
      super.key});

  @override
  Widget build(BuildContext context) => enableBackgroundImage
      ? AiLayoutWithBackground(
          aiThemeType: aiThemeType,
          content: _content,
        )
      : _content;

  Widget get _content => CustomScaffold(
        enableBackNavigation: false,
        appBarBackgroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        body: CustomStretchedLayout(
          contentPadding: const EdgeInsets.only(top: 0),
          padding:
              AppValues.screenHorizontalPadding.copyWith(bottom: 40, top: 20),
          content: SizedBox(
            width: double.infinity,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              const LoraAnimationMagenta(),
              Center(
                  child: getPngImage('splash_screen', width: 210, height: 100)),
              CustomTextNew(
                title,
                style: AskLoraTextStyles.h5
                    .copyWith(color: aiThemeType.primaryFontColor),
                textAlign: TextAlign.center,
              ),
              if (child != null) child!,
              const SizedBox(
                height: 32,
              ),
              _bottomButton
            ]),
          ),
        ),
      );

  Widget get _bottomButton => GlowingButton(
        height: 75.0,
        width: 75.0,
        onTap: onBottomButtonTap,
        buttonBackgroundColor: aiThemeType.startButtonFillColor,
        glowColor: Colors.grey[350]!.withAlpha(100),
        child: Container(
            margin: const EdgeInsets.all(2),
            padding: const EdgeInsets.only(left: 4),
            decoration: BoxDecoration(
                gradient: RadialGradient(colors: <Color>[
                  AskLoraColors.white.withOpacity(1),
                  AskLoraColors.white.withOpacity(0.6),
                  AskLoraColors.gray,
                ], stops: const <double>[
                  0.6,
                  0.8,
                  1
                ]),
                shape: BoxShape.circle,
                border: Border.all(color: AskLoraColors.darkGray, width: 1)),
            child: getSvgIcon('icon_play',
                color: AskLoraColors.darkGray, fit: BoxFit.none)),
      );
}
