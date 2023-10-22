import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/domain/base_response.dart';
import '../../../../../core/domain/pair.dart';
import '../../../../../core/presentation/buttons/button_pair.dart';
import '../../../../../core/presentation/buttons/primary_button.dart';
import '../../../../../core/presentation/custom_expanded_row.dart';
import '../../../../../core/presentation/custom_layout_with_blur_pop_up.dart';
import '../../../../../core/presentation/custom_scaffold.dart';
import '../../../../../core/presentation/custom_text_new.dart';
import '../../../../../core/presentation/loading/custom_loading_overlay.dart';
import '../../../../../core/presentation/lora_popup_message/model/lora_pop_up_message_model.dart';
import '../../../../../core/presentation/round_colored_box.dart';
import '../../../../../core/styles/asklora_colors.dart';
import '../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../generated/l10n.dart';
import '../../../../onboarding/kyc/presentation/widgets/custom_stepper/custom_stepper.dart';
import '../../../../onboarding/kyc/repository/account_repository.dart';
import '../../../../settings/bloc/account_information/account_information_bloc.dart';
import '../../../../settings/domain/bank_account.dart';
import '../../../../tabs/presentation/tab_screen.dart';
import '../../../widgets/balance_base_form.dart';
import '../../../widgets/bank_account_card.dart';
import '../../../widgets/change_bank_account_button.dart';
import '../../utils/deposit_utils.dart';
import '../deposit_screen.dart';
import 'widgets/deposit_step/domain/deposit_step_model.dart';

part 'widgets/deposit_bank_account.dart';
part 'widgets/deposit_step/deposit_step.dart';
part 'widgets/deposit_step/utils/deposit_step_utils.dart';
part 'widgets/deposit_welcome_notes.dart';

class DepositWelcomeScreen extends StatelessWidget {
  final DepositType? initialDepositType;
  static const String route = '/deposit_welcome_screen';

  final _spaceHeight = const SizedBox(
    height: 38,
  );
  final _spaceHeightSmall = const SizedBox(
    height: 21,
  );

  const DepositWelcomeScreen({
    this.initialDepositType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        AccountInformationBloc accountInformationBloc =
            AccountInformationBloc(accountRepository: AccountRepository());
        if (initialDepositType == null) {
          accountInformationBloc.add(GetAccountInformation());
        }
        return accountInformationBloc;
      },
      child: BlocConsumer<AccountInformationBloc, AccountInformationState>(
        listener: (context, state) {
          CustomLoadingOverlay.of(context).show(state.response.state);
        },
        builder: (context, state) {
          Pair<Widget, Widget> depositScreenArgs =
              _depositScreenArgs(context, state);
          return CustomScaffold(
            enableBackNavigation: false,
            body: CustomLayoutWithBlurPopUp(
              content: BalanceBaseForm(
                  title: S.of(context).deposit,
                  content: depositScreenArgs.left,
                  bottomButton: depositScreenArgs.right),
              showPopUp: state.response.state == ResponseState.error,
              loraPopUpMessageModel: LoraPopUpMessageModel(
                  onPrimaryButtonTap: () => context
                      .read<AccountInformationBloc>()
                      .add(GetAccountInformation()),
                  onSecondaryButtonTap: () => Navigator.pop(context),
                  primaryButtonLabel: S.of(context).buttonReloadPage,
                  secondaryButtonLabel: S.of(context).buttonBack,
                  title: S.of(context).errorGettingInformationTitle,

                  ///TODO : do localisation later as copywriting still not fixed yet
                  subTitle:
                      'There was an error when trying to get your Deposit Information. Please try reloading the page'),
            ),
          );
        },
      ),
    );
  }

  Pair<Widget, Widget> _depositScreenArgs(
      BuildContext context, AccountInformationState accountInformationState) {
    if (accountInformationState.response.state != ResponseState.loading) {
      DepositType depositType =
          _getDepositType(accountInformationState.response.data?.bankAccount);
      return Pair(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DepositStep(
                depositType: depositType,
              ),
              _spaceHeightSmall,
              _spaceHeight,
              DepositBankAccount(
                bankAccount: accountInformationState.response.data?.bankAccount,
                spaceHeightSmall: _spaceHeightSmall,
                spaceHeight: _spaceHeight,
              ),
              DepositWelcomeNotes(
                depositType: depositType,
              ),
            ],
          ),
          _bottomButton(
            context,
            depositType,
          ));
    } else {
      return const Pair(
        SizedBox.shrink(),
        SizedBox.shrink(),
      );
    }
  }

  Widget _bottomButton(BuildContext context, DepositType depositType) {
    switch (depositType) {
      case DepositType.firstTime:
        return Padding(
          padding: const EdgeInsets.only(top: 30),
          child: ButtonPair(
              primaryButtonOnClick: () => DepositScreen.open(
                    context: context,
                    depositType: depositType,
                  ),
              secondaryButtonOnClick: () =>
                  TabScreen.openAndRemoveAllRoute(context),
              primaryButtonLabel: S.of(context).buttonContinue,
              secondaryButtonLabel: S.of(context).buttonMaybeLater),
        );
      default:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: PrimaryButton(
            label: S.of(context).buttonContinue,
            onTap: () => DepositScreen.open(
              context: context,
              depositType: depositType,
            ),
          ),
        );
    }
  }

  static void open({required BuildContext context, DepositType? depositType}) =>
      Navigator.of(context, rootNavigator: true)
          .pushNamed(route, arguments: depositType);

  DepositType _getDepositType(BankAccount? bankAccount) {
    return initialDepositType ??
        (bankAccount != null ? DepositType.type2 : DepositType.firstTime);
  }
}
