import 'package:flutter/material.dart';

import '../../../../core/presentation/custom_text_new.dart';
import '../../../../core/styles/asklora_text_styles.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../generated/l10n.dart';

class EmptyTransactionPlaceholder extends StatelessWidget {
  const EmptyTransactionPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraint) => SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: constraint.maxHeight,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getPngImage('transaction_empty', height: 100, width: 100),
                const SizedBox(
                  height: 20,
                ),
                CustomTextNew(
                  S.of(context).noTransactions,
                  style: AskLoraTextStyles.subtitle2,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 4,
                ),
                CustomTextNew(
                  S.of(context).noTransactionsYet,
                  style: AskLoraTextStyles.body1,
                  textAlign: TextAlign.center,
                ),
              ],
            )),
          ),
        ),
      );
}
