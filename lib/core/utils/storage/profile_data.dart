import 'shared_preference.dart';
import 'storage_keys.dart';

class ProfileData {
  final SharedPreference _sharedPreference = SharedPreference();

  Future<String> getName() async {
    String firstName =
        await _sharedPreference.readData(StorageKeys.sfKeyPpiName) ?? '';
    String lastName =
        await _sharedPreference.readData(StorageKeys.sfKeyPpiLastName) ?? '';
    return '$firstName $lastName';
  }

  Future<String> getEmail() async {
    return await _sharedPreference.readData(StorageKeys.sfKeyEmail) ?? '';
  }

  Future<ProfileDataModel> getProfileData() async {
    return ProfileDataModel(name: await getName(), email: await getEmail());
  }
}

class ProfileDataModel {
  final String name;
  final String email;

  ProfileDataModel({required this.name, required this.email});
}
