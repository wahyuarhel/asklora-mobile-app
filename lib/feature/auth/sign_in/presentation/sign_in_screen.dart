import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/repository/user_journey_repository.dart';
import '../../../../core/domain/token/repository/token_repository.dart';
import '../../../../core/presentation/custom_scaffold.dart';
import '../../../../core/utils/storage/shared_preference.dart';
import '../../../backdoor/domain/backdoor_repository.dart';
import '../../../onboarding/kyc/repository/account_repository.dart';
import '../../../onboarding/ppi/repository/ppi_response_repository.dart';
import '../../repository/auth_repository.dart';
import '../bloc/sign_in_bloc.dart';
import 'sign_in_form.dart';

class SignInScreen extends StatelessWidget {
  static const String route = '/sign_in';

  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: BlocProvider(
          create: (context) => SignInBloc(
              accountRepository: AccountRepository(),
              authRepository: AuthRepository(
                TokenRepository(),
                BackdoorRepository(),
              ),
              userJourneyRepository: UserJourneyRepository(),
              sharedPreference: SharedPreference(),
              ppiResponseRepository: PpiResponseRepository()),
          child: const SignInForm(),
        ),
      ),
    );
  }

  static void open(BuildContext context) =>
      Navigator.of(context).pushNamed(route);
}
