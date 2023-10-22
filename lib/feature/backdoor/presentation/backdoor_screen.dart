import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/presentation/custom_scaffold.dart';
import '../../../core/presentation/custom_text_new.dart';
import '../../../core/styles/asklora_colors.dart';
import '../../../core/styles/asklora_text_styles.dart';
import '../bloc/backdoor_screen_bloc.dart';
import '../domain/backdoor_repository.dart';

class BackdoorScreen extends StatelessWidget {
  static const String route = '/backdoor_screen';

  const BackdoorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: BlocProvider(
          create: (context) => BackdoorScreenBloc(BackdoorRepository())
            ..add(InitOtpLoginDisabled()),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (str) {
                      context
                          .read<BackdoorScreenBloc>()
                          .add(OnBaseUrlChanged(str));
                    },
                    onFieldSubmitted: (str) {
                      context
                          .read<BackdoorScreenBloc>()
                          .add(OnBaseUrlChanged(str));
                    },
                  ),
                  const SizedBox(height: 30),
                  _disabledOtpLoginToggle,
                ],
              ),
            ),
          ),
        ),
        enableBackNavigation: true);
  }

  Widget get _disabledOtpLoginToggle =>
      BlocBuilder<BackdoorScreenBloc, BackdoorScreenState>(
        buildWhen: (previous, current) =>
            previous.isOtpLoginDisabled != current.isOtpLoginDisabled,
        builder: (context, state) {
          return _toggleButton(
            label: 'Disabled OTP',
            onChanged: (value) => context
                .read<BackdoorScreenBloc>()
                .add(OnLoginVersionChanged(value)),
            value: state.isOtpLoginDisabled,
          );
        },
      );

  Widget _toggleButton(
      {Key? key,
      required String label,
      required void Function(bool) onChanged,
      required bool value}) {
    return Row(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: CustomTextNew(
            label,
            style: AskLoraTextStyles.h6,
          ),
        ),
        CupertinoSwitch(
          value: value,
          onChanged: onChanged,
          activeColor: AskLoraColors.charcoal,
        )
      ],
    );
  }

  static open(BuildContext context) {
    Navigator.pushNamed(context, route);
  }
}
