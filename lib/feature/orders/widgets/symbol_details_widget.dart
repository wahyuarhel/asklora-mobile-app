import 'package:flutter/material.dart';

import '../../../core/presentation/custom_text.dart';
import '../../../core/utils/app_icons.dart';

class SymbolDetailsWidget extends StatelessWidget {
  const SymbolDetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
                flex: 5,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText('Apple Inc', type: FontType.highlight),
                    CustomText(r'AAPL.O', type: FontType.h4SemiBold),
                  ],
                )),
            Expanded(
                flex: 1,
                child: Image.asset(
                  AppIcons.appleLogo,
                  height: 50,
                  width: 50,
                  alignment: Alignment.centerRight,
                ))
          ]),
      const SizedBox(
        height: 20,
      ),
      const Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(r'$144.87', type: FontType.h4Normal),
                    CustomText(r'1.06 (5.45%) Today',
                        type: FontType.bodyText, color: Colors.green),
                  ],
                )),
            Expanded(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomText(r'Buying Power', type: FontType.h4Normal),
                    CustomText(r'$20', type: FontType.bodyText),
                  ],
                ))
          ]),
    ]);
  }
}
