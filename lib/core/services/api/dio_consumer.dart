import 'package:dio/dio.dart';

import 'api_consumer.dart';
import 'end_points.dart';
import 'server_failure.dart';

class DioConsumer implements ApiConsumer {
  final Dio _dio = Dio();

  DioConsumer() {
    _dio.options.baseUrl = EndPoints.baseUrl;
    // _dio.interceptors.add(ApiInterceptor());
  }

  @override
  Future<Response> get(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Map<String, dynamic>? headers,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        endPoint,
        queryParameters: queryParameters,
        options: Options(
          sendTimeout: const Duration(minutes: 1),
          receiveTimeout: const Duration(minutes: 1),
          headers: {
            'Content-Type': 'application/json',
            "Connection": "keep-alive",
          },
        ),
        // options: options ?? Options(headers: headers),
      );
      return response;
    } on DioException catch (e) {
      throw ServerFailure.fromDioException(e);
    }
  }

  @override
  Future<Response> post(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
    bool isFormData = false,
    Map<String, dynamic>? headers,
    Options? options,
  }) async {
    try {
      final postData =
          isFormData
              ? (data is FormData ? data : FormData.fromMap(data))
              : data;

      final response = await _dio.post(
        endPoint,
        queryParameters: queryParameters,
        data: postData,
        options: options ?? Options(headers: headers),
      );
      return response;
    } on DioException catch (e) {
      throw ServerFailure.fromDioException(e);
    }
  }

  @override
  Future<Response> put(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
    bool isFormData = false,
    Map<String, dynamic>? headers,
    Options? options,
  }) async {
    try {
      final response = await _dio.put(
        endPoint,
        queryParameters: queryParameters,
        data: isFormData ? FormData.fromMap(data) : data,
        options: options ?? Options(headers: headers),
      );
      return response;
    } on DioException catch (e) {
      throw ServerFailure.fromDioException(e);
    }
  }

  @override
  Future<Response> delete(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
    bool isFormData = false,
    Map<String, dynamic>? headers,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete(
        endPoint,
        queryParameters: queryParameters,
        data: isFormData ? FormData.fromMap(data) : data,
        options: options ?? Options(headers: headers),
      );
      return response;
    } on DioException catch (e) {
      throw ServerFailure.fromDioException(e);
    }
  }

  @override
  Future<Response> patch(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
    bool isFormData = false,
    Map<String, dynamic>? headers,
    Options? options,
  }) async {
    try {
      final response = await _dio.patch(
        endPoint,
        queryParameters: queryParameters,
        data: isFormData ? FormData.fromMap(data) : data,
        options: options ?? Options(headers: headers),
      );
      return response;
    } on DioException catch (e) {
      throw ServerFailure.fromDioException(e);
    }
  }
}
