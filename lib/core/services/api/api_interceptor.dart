import 'package:dio/dio.dart';
import 'package:shatably_app/core/routes/navigatoin_service.dart';
import '../../routes/routes.dart';
import 'end_points.dart';
import 'token_manager.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await TokenManager.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
      options.headers['Content-Type'] = 'application/json';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Check if error is unauthorized
    if (err.response?.statusCode == 401) {
      try {
        final refreshToken = await TokenManager.getRefreshToken();
        final dio = Dio();
        try {
          // Try to refresh the token
          final response = await dio.post<Map<String, dynamic>>(
            '${EndPoints.baseUrl}auth/refresh-token',
            data: {'refreshToken': refreshToken},
          );

          if (response.data != null && response.data!['accessToken'] != null) {
            final newAccessToken = response.data!['accessToken'];
            //* Save new tokens
            await TokenManager.saveAccessToken(newAccessToken);
            //* Retry the original request with new token
            final retryResponse = await dio.fetch<dynamic>(
              RequestOptions(
                path: err.requestOptions.path,
                method: err.requestOptions.method,
                headers: {
                  ...err.requestOptions.headers,
                  'Authorization': 'Bearer $newAccessToken',
                },
                baseUrl: err.requestOptions.baseUrl,
                data: err.requestOptions.data,
                queryParameters: err.requestOptions.queryParameters,
              ),
            );
            if (retryResponse.statusCode == 200 ||
                retryResponse.statusCode == 201) {
              return handler.resolve(retryResponse);
            }
          }
          //! refresh token request succeeded but didn't return valid data
          logout();
        } catch (refreshError) {
          //! If refresh token request fails
          if (refreshError is DioException) {
            if (refreshError.response?.statusCode == 401 ||
                refreshError.response?.statusCode == 403) {
              logout();
            }
          }
        }
      } catch (e) {
        //! Any other error during the refresh process
        logout();
      }
    }
    // If we get here, either it wasn't a 401 error or token refresh failed
    return handler.next(err);
  }

  //? Logout the user
  static Future<void> logout() async {
    await TokenManager.clearTokens();
    NavigationService.instance.pushAndRemoveUntil(path: Routes.loginScreen);
    // navigatorKey.currentState?.pushNamedAndRemoveUntil(
    //   Routes.loginScreen,
    //   (route) => false,
    // );
  }
}
