import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/domain/base_response.dart';
import '../../../../../core/presentation/ai/utils/ai_utils.dart';
import '../../../../ai/investment_style_question/presentation/ai_investment_style_question_form.dart';
import '../../../presentation/tab_screen.dart';
import '../../../utils/tab_util.dart';
import '../../bloc/for_you_bloc.dart';
import '../../repository/for_you_repository.dart';

class AiInvestmentStyleQuestionForYouScreen extends StatelessWidget {
  static const String route = '/ai_investment_style_question_for_you_screen';
  final AiThemeType aiThemeType;

  const AiInvestmentStyleQuestionForYouScreen(
      {required this.aiThemeType, super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => ForYouBloc(forYouRepository: ForYouRepository()),
        child: Builder(builder: (context) {
          return BlocListener<ForYouBloc, ForYouState>(
            listenWhen: (_, current) =>
                current.response.state == ResponseState.success,
            listener: (context, state) => TabScreen.openAndRemoveAllRoute(
                context,
                initialTabPage: TabPage.forYou),
            child: AiInvestmentStyleQuestionForm(
              aiThemeType: aiThemeType,
              onFinished: () {
                context.read<ForYouBloc>().add(SaveInvestmentStyleState());
              },
            ),
          );
        }),
      );

  static void open(BuildContext context,
          {AiThemeType aiThemeType = AiThemeType.dark}) =>
      Navigator.of(context, rootNavigator: true)
          .pushNamed(route, arguments: aiThemeType);
}
