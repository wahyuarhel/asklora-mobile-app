import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/domain/base_response.dart';
import '../../../../../core/presentation/buttons/primary_button.dart';
import '../../../../../generated/l10n.dart';
import '../../bloc/response/user_response_bloc.dart';

class QuestionNavigationButtonWidget extends StatelessWidget {
  final Function() onNext;
  final Function() onCancel;
  final Function onSubmitSuccess;
  final bool disable;
  final EdgeInsets padding;

  const QuestionNavigationButtonWidget(
      {required this.onSubmitSuccess,
      required this.onNext,
      required this.onCancel,
      this.disable = true,
      this.padding = const EdgeInsets.only(bottom: 35.0, top: 24),
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserResponseBloc, UserResponseState>(
        listenWhen: (previous, current) =>
            previous.responseState != current.responseState,
        listener: (context, state) {
          if (state.responseState == ResponseState.success) {
            onSubmitSuccess();
          } else if (state.responseState == ResponseState.error) {
            //TODO change error handling whenever endpoint is available
            onSubmitSuccess();
          }
        },
        buildWhen: (previous, current) =>
            previous.responseState != current.responseState,
        builder: (context, state) {
          return Padding(
            padding: padding,
            child: PrimaryButton(
              key: const Key('question_next_button'),
              disabled: disable,
              label: S.of(context).buttonNext,
              onTap: onNext,
            ),
          );
        });
  }
}
