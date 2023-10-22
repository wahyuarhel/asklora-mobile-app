import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../styles/asklora_colors.dart';
import '../../../styles/asklora_text_styles.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/feature_flags.dart';
import '../../auto_sized_text_widget.dart';

enum FundingType { fund, withdraw }

class FundingButton extends StatelessWidget {
  final FundingType fundingType;
  final VoidCallback onTap;
  final bool disabled;

  FundingButton(
      {required this.fundingType,
      required this.onTap,
      this.disabled = false,
      Key? key})
      : super(key: key);

  final ButtonStyle _defaultButtonStyle = ElevatedButton.styleFrom(
      elevation: 0,
      minimumSize: const Size(55, 100),
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ));

  @override
  Widget build(BuildContext context) {
    final foregroundColor = disabled
        ? AskLoraColors.darkGray
        : fundingType == FundingType.fund
            ? AskLoraColors.primaryGreen
            : AskLoraColors.primaryMagenta;

    return SizedBox(
      height: 55,
      child: AbsorbPointer(
        absorbing: disabled,
        child: ElevatedButton(
            style: _getDefaultButtonStyle,
            onPressed: () {
              if (!disabled) {
                FocusManager.instance.primaryFocus?.unfocus();
                if (FeatureFlags.isMockApp) return;
                onTap();
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: AutoSizedTextWidget(
                    fundingType == FundingType.fund
                        ? S.of(context).deposit
                        : S.of(context).withdraw,
                    style: AskLoraTextStyles.subtitle1
                        .copyWith(color: foregroundColor),
                    maxLines: 1,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                getSvgIcon(fundingType == FundingType.fund
                    ? 'icon_deposit'
                    : 'icon_withdraw'),
              ],
            )),
      ),
    );
  }

  ButtonStyle get _getDefaultButtonStyle {
    switch (fundingType) {
      case FundingType.fund:
        return _defaultButtonStyle.copyWith(
          backgroundColor: _getColor(
              disabled ? AskLoraColors.gray : AskLoraColors.charcoal,
              AskLoraColors.charcoal.withOpacity(0.9)),
        );
      case FundingType.withdraw:
        return _defaultButtonStyle.copyWith(
          backgroundColor: _getColor(
              disabled ? AskLoraColors.gray : AskLoraColors.charcoal,
              AskLoraColors.charcoal.withOpacity(0.9)),
        );
    }
  }

  MaterialStateProperty<Color> _getColor(Color color, Color colorPressed) {
    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return colorPressed;
      } else {
        return color;
      }
    });
  }
}
