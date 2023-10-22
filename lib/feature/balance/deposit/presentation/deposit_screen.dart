import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/bloc/app_bloc.dart';
import '../../../../core/domain/base_response.dart';
import '../../../../core/domain/pair.dart';
import '../../../../core/presentation/buttons/primary_button.dart';
import '../../../../core/presentation/custom_expanded_row.dart';
import '../../../../core/presentation/custom_image_picker.dart';
import '../../../../core/presentation/custom_in_app_notification.dart';
import '../../../../core/presentation/custom_layout_with_blur_pop_up.dart';
import '../../../../core/presentation/custom_scaffold.dart';
import '../../../../core/presentation/custom_status_widget.dart';
import '../../../../core/presentation/custom_text_new.dart';
import '../../../../core/presentation/loading/custom_loading_overlay.dart';
import '../../../../core/presentation/lora_popup_message/model/lora_pop_up_message_model.dart';
import '../../../../core/presentation/round_colored_box.dart';
import '../../../../core/presentation/suspended_account_screen.dart';
import '../../../../core/presentation/text_fields/amount_text_field.dart';
import '../../../../core/repository/transaction_repository.dart';
import '../../../../core/styles/asklora_colors.dart';
import '../../../../core/styles/asklora_text_styles.dart';
import '../../../../core/values/app_values.dart';
import '../../../../generated/l10n.dart';
import '../../../onboarding/kyc/presentation/widgets/custom_stepper/custom_stepper.dart';
import '../../widgets/balance_base_form.dart';
import '../bloc/deposit_bloc.dart';
import '../utils/deposit_utils.dart';
import 'deposit_result_screen.dart';

part 'widgets/deposit_notes.dart';
part 'widgets/deposit_step/deposit_base_step.dart';
part 'widgets/deposit_step/transfer_amount_step.dart';
part 'widgets/deposit_step/transfer_detail_step.dart';
part 'widgets/deposit_step/upload_proof_of_remittance_step.dart';

class DepositScreen extends StatelessWidget {
  static const String route = '/deposit_screen';
  final DepositType depositType;

  const DepositScreen({required this.depositType, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DepositBloc(
          transactionRepository: TransactionRepository(),
          depositType: depositType),
      child: BlocConsumer<DepositBloc, DepositState>(
        buildWhen: (previous, current) =>
            previous.response.state != current.response.state,
        listenWhen: (previous, current) =>
            previous.response.state != current.response.state,
        listener: (context, state) {
          CustomLoadingOverlay.of(context).show(state.response.state);
          if (state.response.state == ResponseState.success) {
            CustomLoadingOverlay.of(context).dismiss();
            if (!UserJourney.compareUserJourney(
                context: context, target: UserJourney.deposit)) {
              context
                  .read<AppBloc>()
                  .add(const SaveUserJourney(UserJourney.learnBotPlank));
            }
            DepositResultScreen.open(
                context: context,
                arguments: Pair(depositType, StatusType.success));
          } else if (state.response.state == ResponseState.suspended) {
            SuspendedAccountScreen.open(context);
          }
        },
        builder: (context, state) => CustomScaffold(
          enableBackNavigation: false,
          body: CustomLayoutWithBlurPopUp(
            content: BalanceBaseForm(
                title: S.of(context).deposit,
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ..._getSteps,
                    const SizedBox(
                      height: 20,
                    ),
                    DepositNotes(
                      depositType: depositType,
                    )
                  ],
                ),
                bottomButton: _bottomButton(context)),
            showPopUp: state.response.state == ResponseState.error,
            loraPopUpMessageModel: LoraPopUpMessageModel(
                title: S.of(context).unableToProcessDepositTitle,
                subTitle: S.of(context).unableToProcessDepositSubTitle,
                onPrimaryButtonTap: () =>
                    context.read<DepositBloc>().add(ResetDepositResponse()),
                primaryButtonLabel: S.of(context).buttonBack),
          ),
        ),
      ),
    );
  }

  List<Widget> get _getSteps {
    switch (depositType) {
      case DepositType.firstTime:
        return [
          TransferDetailStep(
            depositType: depositType,
          ),
          TransferAmountStep(
            depositType: depositType,
          ),
          const UploadProofOfRemittanceStep(),
        ];
      case DepositType.changeBankAccount:
        return [
          TransferDetailStep(
            depositType: depositType,
          ),
          TransferAmountStep(
            depositType: depositType,
          ),
          const UploadProofOfRemittanceStep(),
        ];
      case DepositType.type1:
        return [
          TransferDetailStep(
            depositType: depositType,
          ),
          TransferAmountStep(
            depositType: depositType,
          ),
          const UploadProofOfRemittanceStep(),
        ];
      case DepositType.type2:
        return [
          TransferDetailStep(
            depositType: depositType,
          ),
          TransferAmountStep(
            depositType: depositType,
            drawLine: false,
          ),
        ];
    }
  }

  Widget _bottomButton(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 30.0, top: 30),
        child: BlocBuilder<DepositBloc, DepositState>(
            buildWhen: (previous, current) =>
                previous.disableDeposit(depositType) !=
                current.disableDeposit(depositType),
            builder: (context, state) => PrimaryButton(
                  disabled: state.disableDeposit(depositType),
                  label: S.of(context).buttonSubmit,
                  onTap: () => context.read<DepositBloc>().add(
                        SubmitDeposit(),
                      ),
                )),
      );

  static void open(
          {required BuildContext context, required DepositType depositType}) =>
      Navigator.pushNamed(context, route, arguments: depositType);
}
