import '../../../../core/domain/base_response.dart';
import '../../../../core/utils/storage/shared_preference.dart';
import '../../../../core/utils/storage/storage_keys.dart';

class ForYouRepository {
  final _sharedPreference = SharedPreference();

  static ForYouRepository? _instance;

  factory ForYouRepository() => _instance ??= ForYouRepository._();

  ForYouRepository._();

  Future<BaseResponse<bool>> saveInvestmentStyleState() async {
    bool investmentStyleState = true;
    _sharedPreference.writeBoolData(
        StorageKeys.sfKeyInvestmentStyleState, investmentStyleState);
    return BaseResponse.complete(investmentStyleState);
  }

  Future<BaseResponse<bool>> getInvestmentStyleState() async {
    bool? investmentStyleState = await _sharedPreference
        .readBoolData(StorageKeys.sfKeyInvestmentStyleState);
    return BaseResponse.complete(investmentStyleState ?? true);
  }
}
