import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/custom_scaffold.dart';
import '../../../../core/utils/storage/shared_preference.dart';
import '../bloc/sign_up_bloc.dart';
import '../repository/sign_up_repository.dart';
import 'sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  static const String route = '/sign_up';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      enableBackNavigation: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: BlocProvider(
          create: (context) {
            return SignUpBloc(
                signUpRepository: SignUpRepository(),
                sharedPreference: SharedPreference());
          },
          child: const SignUpForm(),
        ),
      ),
    );
  }

  static void open(BuildContext context) =>
      Navigator.of(context).pushNamed(route);
}
