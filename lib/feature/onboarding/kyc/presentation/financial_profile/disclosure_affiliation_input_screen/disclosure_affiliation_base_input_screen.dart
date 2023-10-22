import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/presentation/custom_text_new.dart';
import '../../../../../../core/presentation/navigation/bloc/navigation_bloc.dart';
import '../../../../../../core/presentation/text_fields/master_text_field.dart';
import '../../../../../../core/styles/asklora_colors.dart';
import '../../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../../core/utils/formatters/custom_formatters.dart';
import '../../../bloc/kyc_bloc.dart';
import '../../widgets/kyc_base_form.dart';

class DisclosureAffiliationBaseInputScreen extends StatelessWidget {
  final double progress;
  final String initialFirstNameValue;
  final String initialLastNameValue;
  final Function(String) onFirstNameChanged;
  final Function(String) onLastNameChanged;
  final Widget bottomButton;

  const DisclosureAffiliationBaseInputScreen(
      {required this.progress,
      Key? key,
      required this.onFirstNameChanged,
      required this.onLastNameChanged,
      this.initialFirstNameValue = '',
      this.initialLastNameValue = '',
      required this.bottomButton})
      : super(key: key);

  static const double _spaceHeightDouble = 36;
  final SizedBox _spaceHeight = const SizedBox(height: _spaceHeightDouble);

  @override
  Widget build(BuildContext context) {
    return KycBaseForm(
      progress: progress,
      onTapBack: () =>
          context.read<NavigationBloc<KycPageStep>>().add(const PagePop()),
      title: 'Set Up Financial Profile',
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
              'Please provide the name of affiliated person.',
              style: AskLoraTextStyles.body1
                  .copyWith(color: AskLoraColors.charcoal),
            ),
            _spaceHeight,
            _textInput(
                initialValue: initialFirstNameValue,
                label: 'English First Name',
                onChanged: onFirstNameChanged,
                hintText: 'English First Name'),
            _spaceHeight,
            _textInput(
              initialValue: initialLastNameValue,
              label: 'English Last Name',
              onChanged: onLastNameChanged,
              hintText: 'English Last Name',
            ),
          ],
        ),
      ),
      bottomButton: bottomButton,
    );
  }

  Widget _textInput(
          {required String label,
          String initialValue = '',
          required Function(String) onChanged,
          String hintText = ''}) =>
      MasterTextField(
        initialValue: initialValue,
        textCapitalization: TextCapitalization.words,
        onChanged: onChanged,
        labelText: label,
        hintText: hintText,
        textInputFormatterList: [fullEnglishNameFormatter()],
        textInputType: TextInputType.text,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      );
}
