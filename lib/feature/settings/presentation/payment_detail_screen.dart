import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/domain/base_response.dart';
import '../../../core/presentation/custom_header.dart';
import '../../../core/presentation/custom_in_app_notification.dart';
import '../../../core/presentation/custom_scaffold.dart';
import '../../../core/presentation/custom_stretched_layout.dart';
import '../../../core/presentation/custom_text_new.dart';
import '../../../core/presentation/loading/custom_loading_overlay.dart';
import '../../../core/styles/asklora_text_styles.dart';
import '../../../generated/l10n.dart';
import '../../auth/utils/auth_utils.dart';
import '../../balance/widgets/bank_account_card.dart';
import '../../balance/widgets/change_bank_account_button.dart';
import '../../onboarding/kyc/repository/account_repository.dart';
import '../bloc/account_information/account_information_bloc.dart';
import '../domain/bank_account.dart';

class PaymentDetailScreen extends StatelessWidget {
  static const route = '/payment_details';

  const PaymentDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AccountInformationBloc(accountRepository: AccountRepository())
            ..add(GetLocalAccountInformation()),
      child: BlocConsumer<AccountInformationBloc, AccountInformationState>(
        listenWhen: (previous, current) =>
            previous.response.state != current.response.state,
        listener: (context, state) {
          CustomLoadingOverlay.of(context).show(state.response.state);
          switch (state.response.state) {
            case ResponseState.error:
              CustomInAppNotification.show(
                  context, state.response.validationCode.getText(context));
              break;
            case ResponseState.success:
              break;
            default:
              break;
          }
        },
        builder: (context, state) {
          if (state.response.state == ResponseState.success) {
            BankAccount? response = state.response.data?.bankAccount;
            return CustomScaffold(
              body: CustomStretchedLayout(
                  header: CustomHeader(title: S.of(context).paymentDetails),
                  content: response != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextNew(S.of(context).yourBankAccount,
                                style: AskLoraTextStyles.body1),
                            const SizedBox(height: 32),
                            BankAccountCard(
                              bankAccount: response,
                            ),
                            const SizedBox(height: 32),
                            _changeBankButton(context),
                            const SizedBox(height: 32),
                            CustomTextNew(S.of(context).noteOnPaymentDetails,
                                style: AskLoraTextStyles.body3)
                          ],
                        )
                      : CustomTextNew(
                          S.of(context).yourPaymentInformationIsUnderReview,
                          style: AskLoraTextStyles.body1)),
            );
          } else {
            // TODO : will update UI when response get error
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _changeBankButton(BuildContext context) =>
      const ChangeBankAccountButton();

  static void open(BuildContext context) => Navigator.pushNamed(context, route);
}
