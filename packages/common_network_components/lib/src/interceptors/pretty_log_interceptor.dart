import 'dart:convert';

import 'package:dio/dio.dart';

class PrettyLogInterceptor extends Interceptor {
  PrettyLogInterceptor({
    this.request = true,
    this.requestHeader = true,
    this.requestBody = true,
    this.responseHeader = true,
    this.responseBody = true,
    this.error = true,
    this.logPrint = print,
  });

  bool request;
  bool requestHeader;
  bool requestBody;
  bool responseBody;
  bool responseHeader;
  bool error;

  void Function(Object object) logPrint;

  static const JsonDecoder _decoder = JsonDecoder();
  static const JsonEncoder _encoder = JsonEncoder.withIndent('  ');

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) {
    final StringBuffer output = StringBuffer();
    output.writeln('*** Request ***');
    output.writeln(_keyValue('uri', options.uri));

    if (request) {
      output.writeln(_keyValue('method', options.method));
      output.writeln(_keyValue('responseType', options.responseType.toString()));
      output.writeln(_keyValue('followRedirects', options.followRedirects));
      output.writeln(_keyValue('connectTimeout', options.connectTimeout));
      output.writeln(_keyValue('sendTimeout', options.sendTimeout));
      output.writeln(_keyValue('receiveTimeout', options.receiveTimeout));
      output.writeln(_keyValue('receiveDataWhenStatusError', options.receiveDataWhenStatusError));
      output.writeln(_keyValue('extra', options.extra));
    }
    if (requestHeader) {
      output.writeln('headers:');
      options.headers.forEach((String key, dynamic v) => output.writeln(_keyValue(' $key', v)));
    }
    if (requestBody) {
      output.writeln('data:');
      if (options.data != null && options.data is FormData) {
        final FormData formData = options.data as FormData;
        output
            .writeln('\tformData files: \n${formData.files.map((MapEntry<String, MultipartFile> e) {
          const String dvr = '\n\t\t\t';
          return '\t\t${e.key}: ${dvr}length: $dvr${e.value.length}${dvr}fileName: ${e.value.filename}${dvr}headers: ${e.value.headers}${dvr}contentType: ${e.value.contentType}\n';
        })}');
        output.writeln('\tformData fields: \n${formData.fields.map((MapEntry<String, String> e) {
          return '\t\t${e.key}: ${e.value}\n';
        })}');
      } else {
        output.writeln(options.data.toString());
      }
    }
    output.writeln();

    logPrint(output.toString());

    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    final StringBuffer output = StringBuffer();
    output.writeln('*** Response ***');
    output.writeln(_getResponseString(response));

    logPrint(output.toString());
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (error) {
      final StringBuffer output = StringBuffer();

      output.writeln('*** DioError ***:');
      output.writeln('uri: ${err.requestOptions.uri}');
      output.writeln('$err');
      if (err.response != null) {
        output.writeln(_getResponseString(err.response!));
      }
      output.writeln();

      logPrint(output.toString());
    }

    handler.next(err);
  }

  String _getResponseString(Response<dynamic> response) {
    final StringBuffer output = StringBuffer();
    output.writeln(_keyValue('uri', response.requestOptions.uri));
    if (responseHeader) {
      output.writeln(_keyValue('statusCode', response.statusCode));
      if (response.isRedirect == true) {
        output.writeln(_keyValue('redirect', response.realUri));
      }

      output.writeln('headers:');
      response.headers
      // ignore: avoid_dynamic_calls
          .forEach((String key, dynamic v) => output.writeln(_keyValue(' $key', v.join('\r\n\t'))));
    }
    if (responseBody) {
      output.writeln('Response Text:');
      String? prettyJson;
      try {
        final dynamic object = _decoder.convert(response.toString());
        prettyJson = _encoder.convert(object);
      } catch (e) {
        /* ignored */
      }

      output.writeln(prettyJson ?? response.toString());
    }
    output.writeln();

    return output.toString();
  }

  String _keyValue(String key, Object? v) => '$key: $v';
}
