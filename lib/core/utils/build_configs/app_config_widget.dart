import 'package:flutter/material.dart';

import 'base_config.dart';
import 'build_config.dart';
import 'environment.dart';

class AppConfigWidget extends InheritedWidget {
  late final BaseConfig baseConfig;

  AppConfigWidget({required Widget child, Key? key})
      : super(child: child, key: key) {
    _initConfig();
  }

  void _initConfig() {
    const String environment =
        String.fromEnvironment('ENVIRONMENT', defaultValue: defaultEnvironment);

    baseConfig = Environment()
        .initConfig(EnvironmentType.values.byName(environment.toLowerCase()));
  }

  static AppConfigWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfigWidget>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
