import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class Logger {
  static log(dynamic message) {
    if (kDebugMode) {
      const prefix = 'Asklora debug :';
      debugPrint('$prefix $message');
    }
  }

  static sendSuccessLogsToSentry(
    String endpoint,
    String xRequestId,
    String message,
  ) async =>
      await Sentry.captureMessage(xRequestId,
          template: message,
          hint: Hint.withMap({'x-request-id': xRequestId}), withScope: (scope) {
        scope.setTag('label', xRequestId);
      });

  static sendErrorLogsToSentry(
      String endpoint, String xRequestId, dynamic stackTrace) async {
    await Sentry.captureException(Exception(endpoint),
        stackTrace: stackTrace,
        hint: Hint.withMap({'x-request-id': xRequestId}), withScope: (scope) {
      scope.setTag('x-request-id', xRequestId);
    });
  }

  static sendEvent(String endpoint, String xRequestId, String logs,
      {SentryLevel level = SentryLevel.info}) async {
    SentryEvent event = SentryEvent(
      tags: {
        'x-request-id': xRequestId,
        'label': xRequestId,
        'type': (level == SentryLevel.error) ? 'error' : 'info'
      },
      level: level,
      message: SentryMessage(endpoint),
      type: level.name,
    );

    await Sentry.captureEvent(event, stackTrace: logs, withScope: (scope) {
      scope.setTag('x-request-id', xRequestId);
      scope.level = level;
    });
  }
}
