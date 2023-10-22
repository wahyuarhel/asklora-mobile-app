import 'base_config.dart';

enum EnvironmentType { dev, staging, production, mock }

class Environment {
  factory Environment() {
    return _singleton;
  }

  Environment._internal();

  static final Environment _singleton = Environment._internal();

  late BaseConfig config;

  initConfig(EnvironmentType environmentType) =>
      config = _getConfig(environmentType);

  BaseConfig _getConfig(EnvironmentType environmentType) {
    switch (environmentType) {
      case EnvironmentType.production:
        return ProdConfig();
      case EnvironmentType.staging:
        return StagingConfig();
      case EnvironmentType.mock:
        return MockConfig();
      default:
        return DevConfig();
    }
  }
}

class DevConfig implements BaseConfig {
  String? backDoorBaseUrl;

  @override
  String get ppiBaseUrl => 'https://ppi-dev.intra.asklora.ai/';

  @override
  String get askLoraApiBaseUrl =>
      backDoorBaseUrl ?? 'https://dev-apca.intra.asklora.ai/';

  @override
  String get askloraAiBaseUrl => 'http://stock-gpt-dev.intra.asklora.ai/';
}

class StagingConfig implements BaseConfig {
  @override
  String get ppiBaseUrl => 'https://ppi-stag.api.asklora.ai/';

  @override
  String get askLoraApiBaseUrl => 'https://stag-apca.api.asklora.ai/';

  @override
  String get askloraAiBaseUrl => 'https://stock-gpt-stag.api.asklora.ai/';
}

class ProdConfig implements BaseConfig {
  @override
  String get ppiBaseUrl => 'https://ppi.api.asklora.ai/';

  @override
  String get askLoraApiBaseUrl => 'https://apca.api.asklora.ai/';

  @override
  String get askloraAiBaseUrl => 'wss://apca.services.asklora.ai/prodConfig';
}

class MockConfig implements BaseConfig {
  @override
  String get ppiBaseUrl => 'https://ppi-stag.api.asklora.ai/';

  @override
  String get askLoraApiBaseUrl => 'https://stag-apca.api.asklora.ai/';

  @override
  String get askloraAiBaseUrl => 'https://stock-gpt-stag.api.asklora.ai/';
}
