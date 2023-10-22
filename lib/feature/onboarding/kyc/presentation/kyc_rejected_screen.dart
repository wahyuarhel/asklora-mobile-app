import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/buttons/button_pair.dart';
import '../../../../core/presentation/custom_scaffold.dart';
import '../../../../core/presentation/custom_status_widget.dart';
import '../../../../core/presentation/custom_text_new.dart';
import '../../../../core/presentation/navigation/bloc/navigation_bloc.dart';
import '../../../../core/styles/asklora_colors.dart';
import '../../../../core/styles/asklora_text_styles.dart';
import '../../../../core/values/app_values.dart';
import '../../../../generated/l10n.dart';
import '../../../tabs/presentation/tab_screen.dart';
import '../bloc/kyc_bloc.dart';

class KycRejectedScreen extends StatelessWidget {
  final String rejectedReason;
  final Function? onGoBack;

  const KycRejectedScreen({
    required this.rejectedReason,
    this.onGoBack,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      enableBackNavigation: false,
      body: Padding(
        padding: AppValues.screenHorizontalPadding,
        child: LayoutBuilder(builder: (context, viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: viewportConstraints.maxHeight),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      CustomStatusWidget(
                        title: S.of(context).kycRejectedScreenTitle,
                        statusType: StatusType.failed,
                      ),
                      const SizedBox(height: 30),
                      CustomTextNew(
                        rejectedReason,
                        key: const Key('rejected_reason'),
                        style: AskLoraTextStyles.subtitle1
                            .copyWith(color: AskLoraColors.charcoal),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  _bottomButton(context, onGoBack)
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _bottomButton(BuildContext context, Function? onGoBack) => ButtonPair(
        primaryButtonOnClick: () {
          context.read<NavigationBloc<KycPageStep>>().add(const PagePop());
          if (onGoBack != null) {
            onGoBack();
          }
        },
        secondaryButtonOnClick: () => TabScreen.openAndRemoveAllRoute(context),
        primaryButtonLabel: S.of(context).buttonGoBack,
        secondaryButtonLabel: S.of(context).buttonBackToHome,
      );
}
