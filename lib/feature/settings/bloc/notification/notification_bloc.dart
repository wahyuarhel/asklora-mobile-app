import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/storage/shared_preference.dart';
import '../../../../core/utils/storage/storage_keys.dart';

part 'notification_event.dart';

part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc({required SharedPreference sharedPreference})
      : _sharedPreference = sharedPreference,
        super(const NotificationState()) {
    on<InitiateNotification>(_onInitiateNotification);
    on<AllowInAppNotification>(_onAllowInAppNotification);
    on<AllowPushNotification>(_onAllowPushNotification);
    on<AllowEmailNotification>(_onAllowEmailNotification);
  }

  final SharedPreference _sharedPreference;

  void _onInitiateNotification(
      InitiateNotification event, Emitter<NotificationState> emit) async {
    bool? isAllowInAppNotification = await _sharedPreference
        .readBoolData(StorageKeys.sfKeyInAppNotification);
    bool? isAllowPushNotification =
        await _sharedPreference.readBoolData(StorageKeys.sfKeyPushNotification);
    bool? isAllowEmailNotification = await _sharedPreference
        .readBoolData(StorageKeys.sfKeyEmailNotification);
    emit(state.copyWith(
        isAllowInAppNotification: isAllowInAppNotification,
        isAllowPushNotification: isAllowPushNotification,
        isAllowEmailNotification: isAllowEmailNotification));
  }

  void _onAllowInAppNotification(
      AllowInAppNotification event, Emitter<NotificationState> emit) async {
    await _sharedPreference.writeBoolData(
        StorageKeys.sfKeyInAppNotification, event.isAllowInAppNotification);
    emit(state.copyWith(
        isAllowInAppNotification: event.isAllowInAppNotification));
  }

  void _onAllowPushNotification(
      AllowPushNotification event, Emitter<NotificationState> emit) async {
    await _sharedPreference.writeBoolData(
        StorageKeys.sfKeyPushNotification, event.isAllowPushNotification);
    emit(
        state.copyWith(isAllowPushNotification: event.isAllowPushNotification));
  }

  void _onAllowEmailNotification(
      AllowEmailNotification event, Emitter<NotificationState> emit) async {
    await _sharedPreference.writeBoolData(
        StorageKeys.sfKeyEmailNotification, event.isAllowEmailNotification);
    emit(state.copyWith(
        isAllowEmailNotification: event.isAllowEmailNotification));
  }
}
