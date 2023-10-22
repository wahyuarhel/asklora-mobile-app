import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/domain/base_response.dart';
import '../../../core/presentation/custom_header.dart';
import '../../../core/presentation/custom_in_app_notification.dart';
import '../../../core/presentation/custom_scaffold.dart';
import '../../../core/presentation/custom_stretched_layout.dart';
import '../../../core/presentation/custom_text_new.dart';
import '../../../core/presentation/loading/custom_loading_overlay.dart';
import '../../../core/styles/asklora_colors.dart';
import '../../../core/styles/asklora_text_styles.dart';
import '../../../generated/l10n.dart';
import '../../auth/utils/auth_utils.dart';
import '../../onboarding/kyc/domain/upgrade_account/personal_info_request.dart';
import '../../onboarding/kyc/repository/account_repository.dart';
import '../bloc/account_information/account_information_bloc.dart';

class AccountInformationScreen extends StatelessWidget {
  static const route = '/account_information_screen';

  const AccountInformationScreen({super.key});

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
              return CustomScaffold(
                body: CustomStretchedLayout(
                  header: CustomHeader(title: S.of(context).accountInformation),
                  content: BlocBuilder<AccountInformationBloc,
                      AccountInformationState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          _accountDetails(
                              S.of(context).userId, state.response.data!.idStr),
                          const SizedBox(height: 40),
                          _accountDetails(
                              S.of(context).fullName,
                              state.response.data!.personalInfo != null
                                  ? _getFullName(
                                      state.response.data!.personalInfo!)
                                  : '-'),
                          const SizedBox(height: 40),
                          _accountDetails(
                              S.of(context).phone,
                              state.response.data!.personalInfo != null
                                  ? _getPhoneNumber(
                                      state.response.data!.personalInfo!)
                                  : '-'),
                          const SizedBox(height: 40),
                          _accountDetails(
                              S.of(context).email, state.response.data!.email),
                          const SizedBox(height: 40),
                          _accountDetails(S.of(context).dateJoined,
                              state.response.data!.dateJoinedFormatted),
                        ],
                      );
                    },
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
    );
  }

  String _getFullName(PersonalInfoRequest personalInfoRequest) =>
      '${personalInfoRequest.firstName} ${personalInfoRequest.lastName}';

  String _getPhoneNumber(PersonalInfoRequest personalInfoRequest) =>
      '(852) ${personalInfoRequest.phoneNumber}';

  Widget _accountDetails(String label, String value) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextNew(
            label,
            style:
                AskLoraTextStyles.body2.copyWith(color: AskLoraColors.darkGray),
          ),
          const SizedBox(height: 12),
          CustomTextNew(value, style: AskLoraTextStyles.body1),
        ],
      );

  static void open(BuildContext context) => Navigator.pushNamed(context, route);
}
