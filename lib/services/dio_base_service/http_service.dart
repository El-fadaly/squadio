import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:squadio/views/resources/constants_manager.dart';

import 'logger.dart';

enum Method { POST, GET, PUT, DELETE, PATCH }

class HttpService {
  Dio? _dio;

  Future<HttpService> init() async {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
      ),
    );
    initInterceptors();
    return this;
  }

  void initInterceptors() {
    _dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (requestOptions, handler) {
          print("\n===================== requestOptions =====================");

          logger.i(
              "REQUEST[${requestOptions.method}] => PATH: ${requestOptions.path}"
              "=> REQUEST VALUES: ${requestOptions.queryParameters} => HEADERS: ${requestOptions.headers} => DATA: ${requestOptions.data}");
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) {
          logger
              .i("RESPONSE[${response.statusCode}] => DATA: ${response.data}");
          return handler.next(response);
        },
        onError: (err, handler) {
          logger.i("Error[${err.response?.statusCode}]");
          return handler.next(err);
        },
      ),
    );
  }

  Future<dynamic> request({
    required String url,
    required Method method,
    Map<String, dynamic>? header,
    formData,
    Map<String, dynamic>? params,
    bool isfile = false,
    bool isQueryParam = false,
  }) async {
    Response response;

    try {
      if (method == Method.POST) {
        print("params httpService ${params.toString()}");
        if (isfile) {
          response = await _dio!.post(
            url,
            data: formData,
            options: Options(headers: header),
          );
        } else {
          if (isQueryParam) {
            response = await _dio!.post(
              url,
              queryParameters: params,
              options: Options(headers: header),
            );
          } else {
            response = await _dio!.post(
              url,
              data: json.encode(params),
              options: Options(headers: header),
            );
          }
        }
      } else if (method == Method.PUT) {
        if (isQueryParam) {
          response = await _dio!.put(
            url,
            queryParameters: params,
            options: Options(headers: header),
          );
        } else {
          response = await _dio!.put(
            url,
            data: json.encode(params),
            options: Options(headers: header),
          );
        }
      } else if (method == Method.DELETE) {
        response = await _dio!.delete(
          url,
          data: json.encode(params),
          options: Options(headers: header),
        );
      } else if (method == Method.PATCH) {
        response = await _dio!.patch(url);
      } else {
        response = await _dio!.get(
          url,
          queryParameters: params,
          options: Options(headers: header),
        );
      }

      print(response.statusCode);

      if (((response.statusCode ?? 600) >= 200) &&
          ((response.statusCode ?? 600) < 300)) {
        return response;
      } else {
        throw Exception("Something does wen't wrong");
      }
    } catch (e) {
      logger.e(e);
      throw Exception("Something wen't wrong");
    }
  }
}
