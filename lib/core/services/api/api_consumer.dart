import 'package:dio/dio.dart';

abstract class ApiConsumer {
  Future<dynamic> get(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    Map<String, dynamic>? headers,
  });

  Future<dynamic> post(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    bool isFormData = false,
    Map<String, dynamic>? headers,
    Options? options,
  });

  Future<dynamic> put(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    bool isFormData = false,
    Map<String, dynamic>? headers,
  });

  Future<dynamic> delete(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    bool isFormData = false,
    Map<String, dynamic>? headers,
  });

  Future<dynamic> patch(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    bool isFormData = false,
    Map<String, dynamic>? headers,
  });
}
