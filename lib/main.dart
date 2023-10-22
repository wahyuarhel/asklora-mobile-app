import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app/presentation/app.dart';
import 'core/utils/build_configs/app_config_widget.dart';
import 'core/utils/feature_flags.dart';

main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  GoogleFonts.config.allowRuntimeFetching = false;

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);

    final chineseFontLicense =
        await rootBundle.loadString('google_fonts/OFL-NotoSansTC.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], chineseFontLicense);
  });

  // await _initialiseFirebase();
  await _initialiseSentry();
}

Future<void> _initialiseSentry() async {
  if (FeatureFlags.enableSentry) {
    await SentryFlutter.init((options) {
      options.dsn =
          'https://da231b1c031b4ad4bdba03524933a47f@sentry.asklora.ai/3';
      options.tracesSampleRate = 0.3;
      options.sampleRate = 0.3;
    }, appRunner: () => runApp(AppConfigWidget(child: const App())));
  } else {
    runApp(AppConfigWidget(child: const App()));
  }
}
