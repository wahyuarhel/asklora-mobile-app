import 'package:asklora_mobile_app/core/utils/storage/shared_preference.dart';
import 'package:asklora_mobile_app/core/utils/storage/storage_keys.dart';
import 'package:asklora_mobile_app/feature/settings/bloc/notification/notification_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'notification_bloc_test.mocks.dart';

@GenerateMocks([SharedPreference])
void main() async {
  group('Bot Stock Bloc Tests', () {
    late MockSharedPreference sharedPreference;
    late NotificationBloc notificationBloc;

    setUpAll(() async {
      sharedPreference = MockSharedPreference();
    });

    setUp(() async {
      notificationBloc = NotificationBloc(sharedPreference: sharedPreference);
    });

    test('Notification Bloc init state response should be default one', () {
      expect(notificationBloc.state, const NotificationState());
    });

    blocTest<NotificationBloc, NotificationState>(
        'emits `isAllowEmailNotification=false, isAllowPushNotification=true, isAllowInAppNotification=false` WHEN '
        'initiating notification',
        build: () {
          when(sharedPreference
                  .readBoolData(StorageKeys.sfKeyInAppNotification))
              .thenAnswer((_) => Future.value(false));
          when(sharedPreference.readBoolData(StorageKeys.sfKeyPushNotification))
              .thenAnswer((_) => Future.value(true));
          when(sharedPreference
                  .readBoolData(StorageKeys.sfKeyEmailNotification))
              .thenAnswer((_) => Future.value(false));
          return notificationBloc;
        },
        act: (bloc) => bloc.add(InitiateNotification()),
        expect: () => {
              const NotificationState(
                  isAllowEmailNotification: false,
                  isAllowPushNotification: true,
                  isAllowInAppNotification: false)
            });

    blocTest<NotificationBloc, NotificationState>(
        'emits `isAllowInAppNotification=true` WHEN '
        'enable in app notification',
        build: () {
          when(sharedPreference.writeBoolData(
                  StorageKeys.sfKeyInAppNotification, true))
              .thenAnswer((_) => Future.value(false));
          return notificationBloc;
        },
        act: (bloc) => bloc.add(const AllowInAppNotification(true)),
        expect: () =>
            {const NotificationState(isAllowInAppNotification: true)});

    blocTest<NotificationBloc, NotificationState>(
        'emits `isAllowPushNotification=true` WHEN '
        'enable push notification',
        build: () {
          when(sharedPreference.writeBoolData(
                  StorageKeys.sfKeyPushNotification, true))
              .thenAnswer((_) => Future.value(false));
          return notificationBloc;
        },
        act: (bloc) => bloc.add(const AllowPushNotification(true)),
        expect: () => {const NotificationState(isAllowPushNotification: true)});

    blocTest<NotificationBloc, NotificationState>(
        'emits `isEmailNotification=true` WHEN '
        'enable in email notification',
        build: () {
          when(sharedPreference.writeBoolData(
                  StorageKeys.sfKeyEmailNotification, true))
              .thenAnswer((_) => Future.value(false));
          return notificationBloc;
        },
        act: (bloc) => bloc.add(const AllowEmailNotification(true)),
        expect: () =>
            {const NotificationState(isAllowEmailNotification: true)});

    tearDown(() => {notificationBloc.close()});
  });
}
