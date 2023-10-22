import 'package:flutter/cupertino.dart';

import '../../../generated/l10n.dart';

enum PasswordErrorType {
  oldPasswordSameWithNewPassword,
  invalidPassword,
  validPassword,
  doesNotMatch;

  String text(BuildContext context) {
    switch (this) {
      case oldPasswordSameWithNewPassword:
        return S.of(context).oldPasswordSameWithNewPasswordError;
      case invalidPassword:
        return S.of(context).enterValidPassword;
      case doesNotMatch:
        return S.of(context).passwordDoesNotMatch;
      case validPassword:
        return '';
    }
  }
}
