import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

import '../bloc/response/user_response_bloc.dart';
import '../presentation/widget/omni_search_question_widget/domain/omni_search_model.dart';

class PpiDefaultAnswer {
  static int getIndex(BuildContext context, String questionId) {
    final response = context
        .read<UserResponseBloc>()
        .state
        .userResponse
        ?.firstWhereOrNull((element) => element.left == questionId);

    final choice = response?.middle.choices
        ?.firstWhereOrNull((e) => e.id == int.parse(response.right));

    final id = choice == null ? -1 : choice.id;
    return id ?? -1;
  }

  static String getString(BuildContext context, String questionId) {
    var response = context
        .read<UserResponseBloc>()
        .state
        .userResponse
        ?.firstWhereOrNull((element) => element.left == questionId);

    return response == null ? '' : response.right;
  }

  static OmniSearchModel getOmniSearch(
      BuildContext context, String questionId) {
    final userResponseState = context.read<UserResponseBloc>().state;

    return OmniSearchModel(
        keywords: userResponseState.cachedDefaultChoices,
        keywordAnswers: userResponseState.cachedSelectedChoices);
  }
}
