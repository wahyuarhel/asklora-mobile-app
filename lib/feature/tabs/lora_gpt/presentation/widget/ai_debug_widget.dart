import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/presentation/custom_text_new.dart';
import '../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../core/utils/build_configs/app_config_widget.dart';
import '../../../../../core/utils/build_configs/build_config.dart';
import '../../../../../core/values/app_values.dart';
import '../../bloc/lora_gpt_bloc.dart';

class AiDebugWidget extends StatelessWidget {
  const AiDebugWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final config = AppConfigWidget.of(context);
    if (config != null &&
        (config.baseConfig is DevConfig ||
            config.baseConfig is StagingConfig)) {
      return Container(
        padding: AppValues.screenHorizontalPadding.copyWith(bottom: 4, top: 4),
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        constraints: const BoxConstraints(maxHeight: 100),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextNew(
                'DEBUG',
                style: AskLoraTextStyles.body3,
              ),
              BlocBuilder<LoraGptBloc, LoraGptState>(
                  buildWhen: (previous, current) =>
                      previous.debugText != current.debugText,
                  builder: (context, state) {
                    return CustomTextNew(
                      state.debugText,
                      style: AskLoraTextStyles.body3,
                    );
                  }),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
