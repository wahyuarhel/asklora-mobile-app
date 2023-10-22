import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../firebase_options.dart';
import '../../utils/log.dart';
import '../model/asklora_notification.dart';

part 'firebase_service_event.dart';

part 'firebase_service_state.dart';

/// When using Flutter version 3.3.0 or higher, the message handler must be
/// annotated with @pragma('vm:entry-point') right above the function declaration
/// (otherwise it may be removed during tree shaking for release mode).
///
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  Logger.log('Handling a background message ${message.messageId}');
}

class FirebaseServiceBLoc
    extends Bloc<FirebaseServiceEvent, FirebaseServiceState> {
  FirebaseServiceBLoc() : super(FirebaseServiceInitiate()) {
    Logger.log('Krishna Gupta FCM TOKEN bloc constructor');
    on<InitFirebase>(_onInitFirebase);
  }

  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void _onInitFirebase(
      InitFirebase event, Emitter<FirebaseServiceState> emitter) async {
    try {
      Logger.log('Krishna Gupta FCM TOKEN _onInitFirebase 11');
      /*Logger.log('Krishna Gupta FCM TOKEN _onInitFirebase 11');

      final fcmToken = await FirebaseMessaging.instance.getToken();

      Logger.log('Krishna Gupta FCM TOKEN _onInitFirebase ${fcmToken}');

      Logger.log('Krishna Gupta FCM TOKEN _onInitFirebase');
      FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
        // Note: This callback is fired at each app startup and whenever a new
        // token is generated.
        Logger.log('Krishna Gupta FCM TOKEN ${fcmToken}');
      }).onError((err) {
        Logger.log('Krishna Gupta ERROR WHILE FETCHING FCM TOKEN');
      });*/

      await _initialiseFirebase();

      // FirebaseMessaging.onBackgroundMessage(
      //     _firebaseMessagingBackgroundHandler);

      _onBackgroundNotification();

      _initializeNotification();
      _onForegroundNotification();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _initialiseFirebase() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  Future<void> _initializeNotification() async {
    try {
      Logger.log('Krishna Gupta FCM TOKEN _initializeNotification 11');
      final response = await FirebaseMessaging.instance.requestPermission();
      final status = response.authorizationStatus;
      Logger.log('Krishna Gupta FCM TOKEN _initializeNotification 12');
      if (status == AuthorizationStatus.authorized) {
        Logger.log(
            'Krishna Gupta FCM TOKEN _initializeNotification 13 authorized');
        final token = await FirebaseMessaging.instance.getToken();
        Logger.log(
            'Krishna Gupta FCM TOKEN _initializeNotification 15 ${token}');
        await _sendTokenToServer(token!);
      }
    } catch (e) {
      Logger.log(
          'Krishna Gupta FCM TOKEN _initializeNotification 15 ${e.toString()}');
    }
  }

  Future<void> _sendTokenToServer(String token) {
    return Future.sync(() => null);
  }

  void _onMessageOpened(RemoteMessage message) {
    final notification = message.notification;
    if (notification != null) {
      // TODO:
    }
  }

  void _onForegroundNotification() {
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification != null) {
        final askloraNotification = AskloraNotification(
            title: notification.title!, body: notification.body!);
        Logger.log(
            'Received a Foreground Notification : ${askloraNotification.toString()}');
      }
    });
  }

  void _onBackgroundNotification() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }
}
