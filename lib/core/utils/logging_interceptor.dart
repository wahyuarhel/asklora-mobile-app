import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'feature_flags.dart';
import 'log.dart';

class LoggingInterceptor extends Interceptor {
  final StringBuffer _stringBuffer = StringBuffer();
  final StringBuffer _sentryLogs = StringBuffer();

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    write(
        '╔==================================== ☁️ API Request - Start ☁️ =====================================╗');

    writeKeyValue('URI', options.uri);
    writeKeyValue('METHOD', options.method);
    write('HEADERS:');
    options.headers.forEach((key, v) => writeKeyValue(' - $key', v));
    write('BODY:');
    write(_prettifyResponse(options.data ?? ''));
    write(
        '╚==================================== ☁️ API Request - End ☁️ =======================================╝');
    _logPrint(_stringBuffer.toString());
    _sentryLogs.write(_stringBuffer.toString());
    clearLog();
    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    write(
        '╔==================================== ❌ Api Error - Start ❌ =======================================╗');
    write('URI: ${err.requestOptions.uri}');
    if (err.response != null) {
      write('STATUS CODE: ${err.response?.statusCode?.toString()}');
    }
    write('$err');

    if (err.response != null) {
      writeKeyValue('REDIRECT', err.response?.realUri ?? '');
      write('HEADERS:');
      err.response?.headers.forEach((key, v) => writeKeyValue(' - $key', v));
      write('BODY:');
      writeAll(err.response?.data.toString());
    }
    write(
        '╚==================================== ❌ Api Error - End ❌ ==========================================╝');

    _logPrint(_stringBuffer.toString());

    if (FeatureFlags.enableSentry) {
      _sentryLogs.write(_stringBuffer.toString());
      Logger.sendEvent(
          err.requestOptions.path,
          err.response?.headers.value('x-request-id') ?? '',
          _sentryLogs.toString(),
          level: SentryLevel.error);
    }

    clearLog();
    clearSentryLog();
    return handler.next(err);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    write(
        '╔==================================== ✅ Api Response - Start ✅ ====================================╗');

    writeKeyValue('URI', response.requestOptions.uri);

    writeKeyValue('STATUS CODE', response.statusCode ?? '');

    writeKeyValue('REDIRECT', response.isRedirect);

    write('HEADERS:');

    response.headers.forEach((key, v) => writeKeyValue(' - $key', v));

    write('BODY:');

    write(_prettifyResponse(response.data ?? ''));

    write(
        '╚==================================== ✅ Api Response - End ✅ ======================================╝');
    _logPrint(_stringBuffer.toString());

    if (FeatureFlags.enableSentry) {
      _sentryLogs.write(_stringBuffer.toString());
      Logger.sendEvent(response.requestOptions.path,
          response.headers.value('x-request-id') ?? '', _sentryLogs.toString());
    }

    clearLog();
    clearSentryLog();

    return handler.next(response);
  }

  // ignore: unused_element
  void _printKeyValue(String key, Object v) => _logPrint('$key: $v');

  // ignore: unused_element
  void _printAll(msg) => msg.toString().split('\n').forEach(_logPrint);

  void _logPrint(String s) => debugPrint(s);

  String _prettifyResponse(jsonObject) {
    var spaces = ' ' * 2;
    var encoder = JsonEncoder.withIndent(spaces);
    return encoder.convert(jsonObject);
  }

  void write(String log) => _stringBuffer.writeln(log);

  void writeKeyValue(String key, Object v) => _stringBuffer.writeln('$key: $v');

  void clearLog() => _stringBuffer.clear();

  void clearSentryLog() => _sentryLogs.clear();

  void writeAll(msg) => msg.toString().split('\n').forEach(write);
}
