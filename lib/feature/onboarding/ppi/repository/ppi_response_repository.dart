import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/data/remote/base_api_client.dart';
import '../../../../core/domain/base_response.dart';
import '../../../../core/utils/storage/shared_preference.dart';
import '../../../../core/utils/storage/storage_keys.dart';
import '../domain/ppi_api_repository.dart';
import '../domain/ppi_user_response.dart';
import '../domain/ppi_user_response_request.dart';
import 'bot_recommendation_repository.dart';

class PpiResponseRepository {
  static PpiResponseRepository? _instance;

  factory PpiResponseRepository() => _instance ??= PpiResponseRepository._();

  PpiResponseRepository._();

  final BotRecommendationRepository botRecommendationRepository =
      BotRecommendationRepository();

  final SharedPreference _sharedPreference = SharedPreference();

  final PpiApiRepository _ppiApiRepository = PpiApiRepository();

  Future<BaseResponse<PpiUserResponse>> addAnswer(
      PpiSelectionRequest ppiUserResponseRequest) async {
    try {
      final response =
          await _ppiApiRepository.postQuestionAnswer(ppiUserResponseRequest);

      var ppiUserResponse = PpiUserResponse.fromJson(response.data);
      return BaseResponse.complete(ppiUserResponse);
    } on AskloraApiClientException catch (_) {
      return BaseResponse.error();
    }
  }

  Future<BaseResponse<PpiUserResponse>> addBulkAnswer(
      List<PpiSelectionRequest> ppiUserResponseRequest) async {
    try {
      final response =
          await _ppiApiRepository.postBulkAnswer(ppiUserResponseRequest);
      return BaseResponse.complete(PpiUserResponse.fromJson(response.data));
    } on BadRequestException catch (_) {
      return BaseResponse.error();
    } catch (e) {
      return BaseResponse.error();
    }
  }

  Future<BaseResponse<SnapShot>> getUserSnapShotUserId(dynamic userId) async {
    try {
      var response = await _ppiApiRepository.getUserSnapshotByUserId(userId);
      SnapShot snapshot = SnapShot.fromJson(response.data);
      await saveUserSnapShotToLocal(snapshot);
      return BaseResponse.complete(snapshot);
    } catch (_) {
      return BaseResponse.error(message: 'Failed to get data');
    }
  }

  Future<void> saveUserSnapShotToLocal(SnapShot snapshot) async {
    await _sharedPreference.writeData(
        StorageKeys.sfKeyPpiAccountId, snapshot.accountId);
    await _sharedPreference.writeIntData(
        StorageKeys.sfKeyPpiUserId, snapshot.id);
    await _sharedPreference.writeData(StorageKeys.sfKeyPpiName, snapshot.name);
    await _sharedPreference.writeData(
        StorageKeys.sfKeyPpiSnapshot, jsonEncode(snapshot));
  }

  Future<SnapShot?> getUserSnapShotFromLocal(
      {bool forceToFetch = false}) async {
    var data = await _sharedPreference.readData(StorageKeys.sfKeyPpiSnapshot);
    if (data == null || forceToFetch) {
      try {
        var askloraId =
            await _sharedPreference.readIntData(StorageKeys.sfKeyAskloraId);
        final response = await getUserSnapshotByAskloraId(askloraId ?? 0);
        return response.data;
      } catch (e) {
        return null;
      }
    } else {
      return SnapShot.fromJson(jsonDecode(data));
    }
  }

  Future<BaseResponse<SnapShot>> getUserSnapshotByAskloraId(
      int askloraId) async {
    try {
      var response =
          await _ppiApiRepository.getUserSnapshotByAskloraId(askloraId);
      SnapShot snapshot = SnapShot.fromJson(response.data);
      await saveUserSnapShotToLocal(snapshot);
      return BaseResponse.complete(snapshot);
    } catch (_) {
      return BaseResponse.error(message: 'Failed to get data');
    }
  }

  Future<BaseResponse<Response>> linkUser(int userId) async {
    try {
      return BaseResponse.complete(await _ppiApiRepository.linkUser(userId));
    } catch (_) {
      return BaseResponse.error();
    }
  }
}
