import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:weather_app/utils/api/i_api.service.dart';
import 'package:weather_app/utils/models/api_response.model.dart';
import 'package:weather_app/utils/models/failure.model.dart';

class ApiService implements IApi {
  late final Dio _dio;

  ApiService() {
    _dio = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(minutes: 2),
        receiveTimeout: const Duration(minutes: 2),
      ),
    );
  }

  @override
  Future delete({
    required String url,
    dynamic body,
    Map<String, String>? headers,
  }) async {
    if (headers != null) {
      _dio.options.headers.addAll(headers);
    }

    log('URL==>$url');
    log('HEADERS==>${_dio.options.headers}');
    log('REQUEST==>$body');

    try {
      final response = await _dio.delete(url, data: body);
      return _handleSuccess(response);
    } catch (e, s) {
      log('ERROR => ${e.toString()}');
      log('ERROR => ${s.toString()}');

      _handleError(e);
    }
  }

  @override
  Future get(String url, {Map<String, String>? headers}) async {
    if (headers != null) {
      _dio.options.headers.addAll(headers);
    }

    log('URL==>$url');
    log('HEADERS==>${_dio.options.headers}');

    try {
      final response = await _dio.get(url);
      return _handleSuccess(response);
    } catch (e, s) {
      log('ERROR => ${e.toString()}');
      log('ERROR => ${s.toString()}');

      _handleError(e);
    }
  }

  @override
  Future patch(
    String url, {
    required body,
    Map<String, String>? headers,
    bool isFormData = false,
  }) async {
    if (headers != null) {
      _dio.options.headers.addAll(headers);
    }

    dynamic data;
    if (isFormData) {
      data = body;
    } else {
      data = json.encode(body);
    }

    log('URL==>$url');
    log('HEADERS==>${_dio.options.headers}');
    if (isFormData) {
      log('REQUEST==>${data.fields.toString()}');
    } else {
      log('REQUEST==>$data');
    }

    try {
      final response = await _dio.patch(url, data: body);
      return _handleSuccess(response);
    } catch (e, s) {
      log('ERROR => ${e.toString()}');
      log('ERROR => ${s.toString()}');

      _handleError(e);
    }
  }

  @override
  Future post(
    String url, {
    required body,
    Map<String, String>? headers,
    bool isFormData = false,
  }) async {
    if (headers != null) {
      _dio.options.headers.addAll(headers);
    }

    dynamic data;
    if (isFormData) {
      data = body;
    } else {
      data = json.encode(body);
    }

    log('URL==>$url');
    log('HEADERS==>${_dio.options.headers}');
    if (isFormData) {
      log('REQUEST==>${data.fields.toString()}');
    } else {
      log('REQUEST==>$data');
    }

    try {
      final response = await _dio.post(url, data: body);
      return _handleSuccess(response);
    } catch (e, s) {
      log('ERROR => ${e.toString()}');
      log('ERROR => ${s.toString()}');

      _handleError(e);
    }
  }

  @override
  Future put(String url, {required body, Map<String, String>? headers}) async {
    if (headers != null) {
      _dio.options.headers.addAll(headers);
    }

    final data = json.encode(body);

    log('URL==>$url');
    log('HEADERS==>${_dio.options.headers}');
    log('REQUEST==>$data');

    try {
      final response = await _dio.put(url, data: data);
      return _handleSuccess(response);
    } catch (e, s) {
      log('ERROR => ${e.toString()}');
      log('ERROR => ${s.toString()}');

      _handleError(e);
    }
  }

  dynamic _handleSuccess(Response<dynamic> response) {
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('RESPONSE DATA==>${response.data}');
        final apiResponse = ApiResponse.fromJson(response.data);
        return apiResponse.data;
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());

      if (e is Failure) {
        rethrow;
      } else {
        throw InternalFailure();
      }
    }
  }

  void _handleError(dynamic error) {
    try {
      if (error is DioException) {
        final response = error.response;

        if (error.type == DioExceptionType.connectionTimeout) {
          throw Failure("Connection  Timeout");
        }

        if (error.type == DioExceptionType.sendTimeout) {
          throw Failure("Connection Timeout");
        }

        if (error.type == DioExceptionType.receiveTimeout) {
          throw Failure("Connection Timeout");
        }

        if (error.type == DioExceptionType.unknown) {
          throw InternalFailure();
        }

        if (response != null) {
          log('API RESPONSE ERROR ==>${response.data}');
          final apiResponse = ApiResponse.fromJson(response.data);
          String message = '';

          if (apiResponse.error != null) {
            message = apiResponse.error!;
          }

          if (apiResponse.message != null) {
            message = apiResponse.message!;
          }

          if (message.isNotEmpty) {
            throw Failure(message);
          }
        }
      }

      throw InternalFailure();
    } catch (e, s) {
      log(e.toString());
      log(s.toString());

      if (e is Failure) {
        rethrow;
      } else {
        throw InternalFailure();
      }
    }
  }
}
