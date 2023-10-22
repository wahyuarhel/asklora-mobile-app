import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/domain/base_response.dart';
import '../../../../../core/domain/pair.dart';
import '../../../../../core/presentation/buttons/button_pair.dart';
import '../../../../../core/presentation/custom_country_picker.dart';
import '../../../../../core/presentation/custom_date_picker.dart';
import '../../../../../core/presentation/custom_in_app_notification.dart';
import '../../../../../core/presentation/custom_phone_number_input.dart';
import '../../../../../core/presentation/custom_text_new.dart';
import '../../../../../core/presentation/loading/custom_loading_overlay.dart';
import '../../../../../core/presentation/navigation/bloc/navigation_bloc.dart';
import '../../../../../core/presentation/text_fields/master_text_field.dart';
import '../../../../../core/styles/asklora_colors.dart';
import '../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../core/utils/build_configs/app_config_widget.dart';
import '../../../../../core/utils/build_configs/build_config.dart';
import '../../../../../core/utils/formatters/custom_formatters.dart';
import '../../../../../core/utils/formatters/upper_case_text_formatter.dart';
import '../../../../../generated/l10n.dart';
import '../../bloc/kyc_bloc.dart';
import '../../bloc/personal_info/personal_info_bloc.dart';
import '../../domain/upgrade_account/personal_info_request.dart';
import '../../domain/upgrade_account/save_kyc_request.dart';
import '../widgets/custom_toggle_button.dart';
import '../widgets/kyc_base_form.dart';
import 'otp/bloc/otp_bloc.dart';

class PersonalInfoScreen extends StatelessWidget {
  final double progress;

  const PersonalInfoScreen({required this.progress, Key? key})
      : super(key: key);

  static const double _spaceHeightDouble = 36;
  final SizedBox _spaceHeight = const SizedBox(height: _spaceHeightDouble);

  @override
  Widget build(BuildContext context) {
    final inputFormatter = _getTextInputFormatter(context);
    return KycBaseForm(
      progress: progress,
      onTapBack: () =>
          context.read<NavigationBloc<KycPageStep>>().add(const PagePop()),
      title: S.of(context).personalInfo,
      content: GestureDetector(
        onTap: () {
          FocusScopeNode focus = FocusScope.of(context);
          if (!focus.hasPrimaryFocus && focus.focusedChild != null) {
            focus.focusedChild?.unfocus();
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextNew(
              S.of(context).personalInfoFormDesc,
              style: AskLoraTextStyles.body1
                  .copyWith(color: AskLoraColors.charcoal),
            ),
            _spaceHeight,
            _textInput(
                initialValue: context.read<PersonalInfoBloc>().state.firstName,
                key: const Key('first_name'),
                label: S.of(context).legalFirstName,
                textInputFormatterList: [inputFormatter, onlyAllowOneSpace()],
                onChanged: (value) => context
                    .read<PersonalInfoBloc>()
                    .add(PersonalInfoFirstNameChanged(value))),
            _spaceHeight,
            _textInput(
                initialValue: context.read<PersonalInfoBloc>().state.lastName,
                key: const Key('last_name'),
                label: S.of(context).legalLastName,
                textInputFormatterList: [inputFormatter, onlyAllowOneSpace()],
                onChanged: (value) => context
                    .read<PersonalInfoBloc>()
                    .add(PersonalInfoLastNameChanged(value))),
            _spaceHeight,
            _selectGender,
            _spaceHeight,
            _hkIdNumberInput,
            _spaceHeight,
            _nationality,
            _spaceHeight,
            _dateOfBirth,
            _spaceHeight,
            _countryOfBirth,
            _spaceHeight,
            _phoneNumberInput
          ],
        ),
      ),
      bottomButton: _bottomButton,
    );
  }

  Widget get _countryOfBirth =>
      BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
        buildWhen: (previous, current) =>
            previous.countryCodeOfBirth != current.countryCodeOfBirth,
        builder: (context, state) => CustomCountryPicker(
          key: const Key('country_of_birth'),
          label: S.of(context).countryOfBirth,
          initialValue: state.countryNameOfBirth,
          onSelect: (Country country) => context.read<PersonalInfoBloc>().add(
              PersonalInfoCountryOfBirthChanged(
                  country.countryCodeIso3, country.name)),
        ),
      );

  Widget get _phoneNumberInput =>
      BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
          buildWhen: (previous, current) =>
              previous.phoneNumber != current.phoneNumber,
          builder: (context, state) => CustomPhoneNumberInput(
                key: const Key('phone_number'),
                label: S.of(context).hkPhoneNo,
                initialValueOfPhoneNumber: state.phoneNumber,
                onChangePhoneNumber: (phoneNumber) => context
                    .read<PersonalInfoBloc>()
                    .add(PersonalInfoPhoneNumberChanged(phoneNumber)),
                errorText: state.phoneNumberErrorText ?? '',
              ));

  Widget get _selectGender => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextNew('Gender'),
          const SizedBox(height: 5),
          BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
              buildWhen: (previous, current) =>
                  previous.gender != current.gender,
              builder: (context, state) => CustomToggleButton(
                    onSelected: (value) => context
                        .read<PersonalInfoBloc>()
                        .add(PersonalInfoGenderChanged(value)),
                    initialValue: state.gender,
                    choices: const Pair('Male', 'Female'),
                  ))
        ],
      );

  Widget get _hkIdNumberInput =>
      BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
        buildWhen: (previous, current) =>
            previous.hkIdNumber != current.hkIdNumber ||
            previous.hkIdErrorText != current.hkIdErrorText,
        builder: (context, state) {
          return MasterTextField(
            key: const Key('hk_id_number'),
            labelText: S.of(context).hkIdNumber,
            hintText: 'A1234567',
            initialValue: state.hkIdNumber,
            textCapitalization: TextCapitalization.words,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            textInputFormatterList: [
              lettersAndNumberFormatter(),
              UpperCaseTextFormatter(),
              LengthLimitingTextInputFormatter(9)
            ],
            textInputType: TextInputType.text,
            onChanged: (value) => context
                .read<PersonalInfoBloc>()
                .add(PersonalInfoHkIdNumberChanged(value)),
            errorText: state.hkIdErrorText ?? '',
          );
        },
      );

  Widget get _nationality => BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
        buildWhen: (previous, current) =>
            previous.nationalityCode != current.nationalityCode,
        builder: (context, state) => CustomCountryPicker(
          key: const Key('nationality'),
          label: S.of(context).nationality,
          hintText: 'Select Nationality',
          initialValue: state.nationalityName,
          onSelect: (Country country) => context.read<PersonalInfoBloc>().add(
              PersonalInfoNationalityChanged(
                  country.countryCodeIso3, country.name)),
        ),
      );

  Widget get _dateOfBirth => BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
        buildWhen: (previous, current) =>
            previous.dateOfBirth != current.dateOfBirth ||
            previous.response.state != current.response.state,
        builder: (context, state) {
          DateTime dateOfBirth = DateTime.parse(state.dateOfBirth);
          return CustomDatePicker(
            key: const Key('date_of_birth'),
            label: S.of(context).dateOfBirth,
            selectedDate: dateOfBirth,
            initialDateTime: dateOfBirth,
            maximumDate: DateTime.now(),
            onDateTimeChanged: (date) => context.read<PersonalInfoBloc>().add(
                  PersonalInfoDateOfBirthChanged(date.toString()),
                ),
          );
        },
      );

  Widget _textInput({
    required String initialValue,
    required String label,
    required Function(String) onChanged,
    required Key key,
    List<TextInputFormatter>? textInputFormatterList,
    String? hintText,
  }) =>
      MasterTextField(
        key: key,
        initialValue: initialValue,
        textCapitalization: TextCapitalization.words,
        onChanged: onChanged,
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        textInputFormatterList: textInputFormatterList,
        textInputType: TextInputType.text,
        hintText: hintText ?? '',
      );

  Widget get _bottomButton => BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
      buildWhen: (previous, current) =>
          _disablePrimaryButton(previous) != _disablePrimaryButton(current),
      builder: (context, state) =>
          BlocListener<PersonalInfoBloc, PersonalInfoState>(
            listenWhen: (previous, current) =>
                previous.response.state != current.response.state,
            listener: (context, state) {
              CustomLoadingOverlay.of(context).show(state.response.state);
              if (state.response.state == ResponseState.error) {
                CustomInAppNotification.show(context, state.response.message);
              } else if ((state.response.state == ResponseState.success)) {
                context.read<OtpBloc>().add(const OtpRequested());
                context
                    .read<NavigationBloc<KycPageStep>>()
                    .add(const PageChanged(KycPageStep.otp));
              }
            },
            child: ButtonPair(
              disablePrimaryButton: _disablePrimaryButton(state),
              primaryButtonOnClick: () {
                final state = context.read<PersonalInfoBloc>().state;
                context
                    .read<PersonalInfoBloc>()
                    .add(PersonalInfoSubmitted(PersonalInfoRequest(
                      firstName: state.firstName,
                      lastName: state.lastName,
                      gender: state.gender,
                      hkIdNumber: state.hkIdNumber,
                      nationality: state.nationalityCode,
                      dateOfBirth: state.dateOfBirth,
                      countryOfBirth: state.countryCodeOfBirth,
                      phoneCountryCode: state.phoneCountryCode,
                      phoneNumber: state.phoneNumber,
                    )));
              },
              secondaryButtonOnClick: () => context
                  .read<KycBloc>()
                  .add(SaveKyc(SaveKycRequest.getRequestForSavingKyc(context))),
              primaryButtonLabel: S.of(context).buttonNext,
              secondaryButtonLabel: S.of(context).saveForLater,
            ),
          ));

  bool _disablePrimaryButton(PersonalInfoState state) {
    if (state.firstName.isEmpty ||
        state.lastName.isEmpty ||
        state.gender.isEmpty ||
        state.hkIdNumber.isEmpty ||
        state.nationalityName.isEmpty ||
        state.dateOfBirth.isEmpty ||
        state.countryNameOfBirth.isEmpty ||
        (state.phoneNumber.isEmpty || state.phoneNumber.length < 8)) {
      return true;
    } else {
      return false;
    }
  }

  FilteringTextInputFormatter _getTextInputFormatter(BuildContext context) {
    final config = AppConfigWidget.of(context);
    if (config != null) {
      if (config.baseConfig is DevConfig ||
          config.baseConfig is StagingConfig) {
        return fullEnglishNameWithHyphenAndUnderScoreFormatter();
      }
    }

    return fullEnglishNameFormatter();
  }
}
