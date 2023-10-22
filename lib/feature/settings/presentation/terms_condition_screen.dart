import 'package:flutter/material.dart';

import '../../../core/presentation/custom_header.dart';
import '../../../core/presentation/custom_scaffold.dart';
import '../../../core/presentation/custom_stretched_layout.dart';
import '../../../core/presentation/custom_text_new.dart';
import '../../../core/styles/asklora_text_styles.dart';
import '../../../generated/l10n.dart';

class TermsAndConditionScreen extends StatelessWidget {
  static const route = '/terms_and_condition_screen';
  const TermsAndConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: CustomStretchedLayout(
        header: CustomHeader(
            title: S.of(context).termsAndConditions, isShowBottomBorder: true),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextNew(
              'Sed ut perspiciatis unde omnis',
              style: AskLoraTextStyles.subtitle2,
            ),
            const SizedBox(height: 5),
            CustomTextNew(
              'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et ',
              style: AskLoraTextStyles.body1,
            ),
            const SizedBox(height: 20),
            CustomTextNew(
                'Itaque earum rerum hic tenetur a sapiente delectus occaecati cupiditate ',
                style: AskLoraTextStyles.subtitle2),
            const SizedBox(height: 5),
            CustomTextNew(
                'omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.',
                style: AskLoraTextStyles.body1),
          ],
        ),
      ),
    );
  }

  static void open(BuildContext context) => Navigator.pushNamed(context, route);
}
