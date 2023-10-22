import '../../../../../core/domain/base_response.dart';
import '../domain/add_user_name_response.dart';
import '../domain/add_user_request.dart';
import '../domain/create_user_client.dart';

class AddUserNameRepository {
  final CreateUserClient _createUserClient = CreateUserClient();

  Future<BaseResponse<AddUserNameResponse>> addUserName(
      {required String name, required String deviceId}) async {
    var response = await _createUserClient.addUser(
      AddUserRequest(name: name, deviceId: deviceId, accountId: ''),
    );
    return BaseResponse.complete(AddUserNameResponse.fromJson(response.data));
  }
}
