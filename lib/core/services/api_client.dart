import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;

  ApiClient({required Dio dio}) : _dio = dio;

  Future<Map<String ,dynamic>> post(
    String url, {
    required dynamic body,
    Map<String, String>? headers,
  }) async {
    final response = await _dio.post(
      url,
      data: body,
      options: Options(headers: headers),
    );

    return response.data ?? {};
  }
}
