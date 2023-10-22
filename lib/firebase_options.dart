import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }
  }

  static FirebaseOptions android = FirebaseOptions(
    apiKey: dotenv.get('FIREBASE_OPTION_ANDROID_API_KEY'),
    appId: dotenv.get('FIREBASE_ANDROID_DEV_APP_ID'),
    messagingSenderId: dotenv.get('MESSAGING_SENDER_ID'),
    projectId: 'asklora-dev',
    storageBucket: 'asklora-dev.appspot.com',
  );

  static FirebaseOptions ios = FirebaseOptions(
    apiKey: dotenv.get('FIREBASE_OPTION_IOS_API_KEY'),
    appId: dotenv.get('FIREBASE_IOS_DEV_APP_ID'),
    messagingSenderId: dotenv.get('MESSAGING_SENDER_ID'),
    projectId: 'asklora-dev',
    storageBucket: 'asklora-dev.appspot.com',
    iosClientId: dotenv.get('IOS_CLIENT_ID'),
    iosBundleId: 'ai.asklora.app.dev',
  );
}
