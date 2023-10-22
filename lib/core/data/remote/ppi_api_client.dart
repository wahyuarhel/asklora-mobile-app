import '../../utils/build_configs/build_config.dart';
import 'base_api_client.dart';

class PpiApiClient extends BaseApiClient {
  PpiApiClient._internal() : super();

  static final _singleton = PpiApiClient._internal();

  factory PpiApiClient() => _singleton;

  @override
  String get baseUrl => Environment().config.ppiBaseUrl;
}
