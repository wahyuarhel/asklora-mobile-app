import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/domain/base_response.dart';
import '../../../../../core/domain/pair.dart';
import '../../../../../core/presentation/navigation/bloc/navigation_bloc.dart';
import '../../../../../generated/l10n.dart';
import '../../bloc/kyc_bloc.dart';
import '../../bloc/personal_info/personal_info_bloc.dart';
import '../../domain/upgrade_account/save_kyc_request.dart';
import '../widgets/custom_toggle_button.dart';
import '../widgets/kyc_base_form.dart';
import '../../../../../core/presentation/buttons/button_pair.dart';

class ResidentCheckScreen extends StatelessWidget {
  final double progress;

  const ResidentCheckScreen({required this.progress, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<PersonalInfoBloc, PersonalInfoState>(
      listenWhen: (previous, current) =>
          previous.response.state != current.response.state,
      listener: (context, state) {
        if (state.response.state == ResponseState.error) {
          context
              .read<NavigationBloc<KycPageStep>>()
              .add(const PageChanged(KycPageStep.personalInfoRejected));
        } else if (state.response.state == ResponseState.success) {
          context
              .read<NavigationBloc<KycPageStep>>()
              .add(const PageChanged(KycPageStep.personalInfo));
        }
      },
      child: KycBaseForm(
        onTapBack: () =>
            context.read<NavigationBloc<KycPageStep>>().add(const PagePop()),
        title: S.of(context).setupPersonalInfo,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            _isUnitedStatesResident,
            const SizedBox(height: 38),
            _isHongKongResident
          ],
        ),
        bottomButton: _bottomButton,
        progress: progress,
      ),
    );
  }

  Widget get _isUnitedStatesResident =>
      BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
          key: const Key('is_united_states_resident'),
          buildWhen: (previous, current) =>
              previous.isUnitedStateResident != current.isUnitedStateResident,
          builder: (context, state) => CustomToggleButton(
                title: S.of(context).usResidentQuestion,
                onSelected: (value) => context.read<PersonalInfoBloc>().add(
                    PersonalInfoIsUnitedStateResidentChanged(
                        value == S.of(context).yes)),
                initialValue: state.isUnitedStateResident != null
                    ? state.isUnitedStateResident!
                        ? S.of(context).yes
                        : S.of(context).no
                    : null,
                choices: Pair(S.of(context).yes, S.of(context).no),
              ));

  Widget get _isHongKongResident =>
      BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
          key: const Key('is_hong_kong_resident'),
          buildWhen: (previous, current) =>
              previous.isHongKongPermanentResident !=
              current.isHongKongPermanentResident,
          builder: (context, state) => CustomToggleButton(
                title: S.of(context).hkResidentQuestion,
                onSelected: (value) => context.read<PersonalInfoBloc>().add(
                    PersonalInfoIsHongKongPermanentResidentChanged(
                        value == S.of(context).yes)),
                initialValue: state.isHongKongPermanentResident != null
                    ? state.isHongKongPermanentResident!
                        ? S.of(context).yes
                        : S.of(context).no
                    : null,
                choices: Pair(S.of(context).yes, S.of(context).no),
              ));

  Widget get _bottomButton => BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
      buildWhen: (previous, current) =>
          previous.isHongKongPermanentResident !=
              current.isHongKongPermanentResident ||
          previous.isUnitedStateResident != current.isUnitedStateResident,
      builder: (context, state) => ButtonPair(
            disablePrimaryButton: state.isUnitedStateResident == null ||
                state.isHongKongPermanentResident == null,
            primaryButtonOnClick: () =>
                context.read<PersonalInfoBloc>().add(const PersonalInfoNext()),
            secondaryButtonOnClick: () {
              context
                  .read<KycBloc>()
                  .add(SaveKyc(SaveKycRequest.getRequestForSavingKyc(context)));
            },
            primaryButtonLabel: S.of(context).buttonNext,
            secondaryButtonLabel: S.of(context).saveForLater,
          ));
}
