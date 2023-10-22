import 'package:flutter/material.dart';

import '../../../../core/presentation/lora_bottom_sheet.dart';

class DemonstrationBottomSheet {
  static show(BuildContext context,
      {VoidCallback? onTapBack,
      required VoidCallback onPrimaryButtonTap,
      required VoidCallback onSecondaryButtonTap,
      required String title,
      String? subTitle,
      required String primaryButtonLabel,
      required String secondaryButtonLabel,
      bool isDismissible = true}) {
    showModalBottomSheet(
        isDismissible: isDismissible,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: (context),
        builder: (_) => WillPopScope(
              onWillPop: () async {
                if (onTapBack != null) {
                  onTapBack();
                } else {
                  Navigator.pop(context);
                }
                return false;
              },
              child: LoraBottomSheetContent(
                title: title,
                subTitle: subTitle,
                primaryButtonLabel: primaryButtonLabel,
                secondaryButtonLabel: secondaryButtonLabel,
                onPrimaryButtonTap: onPrimaryButtonTap,
                onSecondaryButtonTap: onSecondaryButtonTap,
              ),
            ));
  }
}
