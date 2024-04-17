// import 'dart:developer';
// import 'package:aasa_emr/features/auth/data/data_source/auth_local_data_source.dart';
// import 'package:dio/dio.dart';
// import 'package:aasa_emr/common/constants/endpoints.dart';

// class ApiService {
//   final Dio _dio;
//   final String _baseUrl;
//   // final AuthLocalDataSource _localStorageServices;


//   ApiService({required Dio dio, String baseUrl = EndPoints.authBaseUrl})
//       : _dio = dio,
//         _baseUrl = baseUrl
//   // _localStorageServices = authLocalDataSouce
//   {
//     // _dio.interceptors.add(
//     // InterceptorsWrapper(
//     //   onRequest: (options, handler) async {
//     //     String? accessToken = await _localStorageServices.getAccessToken();
//     //     if (accessToken != null) {
//     //       options.headers['Authorization'] = 'Bearer $accessToken';
//     //     }
//     //     return handler.next(options);
//     //   },
//     //   onResponse: (response, handler) async {
//     //     return handler.next(response);
//     //   },
//     //   onError: (DioException error, handler) async {
//     //     log("Api Service Error: ${error.response}");
//     //     log("Error Response StatusCode: ${error.response?.data['message'].toString()}");

//     //     if (error.response?.statusCode == 400 && error.requestOptions.headers['Authorization'] != null) {
//     //       final String? newAccessToken = await refreshToken();
//     //       if (newAccessToken != null) {
//     //         _dio.options.headers['Authorization'] = 'Bearer $newAccessToken';
//     //         return handler.resolve(await _dio.fetch(error.requestOptions));
//     //       }
//     //     }
//     //     return handler.next(error);
//     //   },
//     // ),
//     // );
//   }


//   // Future<String?> refreshToken() async {
//   //   try {
//   //     final refreshToken = await _localStorageServices.getRefreshToken();

//   //     final response = await post(
//   //       EndPoints.refreshTokenUrl,
//   //       {"token": refreshToken},
//   //     );
//   //     final String newAccessToken = response.data["data"]["accessToken"];
//   //     await _localStorageServices.saveAccessToken(token: newAccessToken);


//   //     return newAccessToken;
//   //   } catch (error) {
//   //     // Log and handle error
//   //     log("Refresh Token Error: $error");
//   //     // TODO: Clear User Data if refresh token expired and redirect to Login Page
//   //   }
//   //   return null;
//   // }


//   Future<Response> get(
//     String path, {
//     Map<String, dynamic>? queryParameters,
//     CancelToken? cancelToken,
//   }) async {
//     log("/* ----------------------------------- GET ---------------------------------- */");
//     log("GET request: $_baseUrl$path, Params: $queryParameters");
//     try {
//       return await _dio.get(
//         path,
//         queryParameters: queryParameters,
//         cancelToken: cancelToken,
//       );
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<Response> post(
//     String path,
//     dynamic data, {
//     Map<String, dynamic>? queryParameters,
//     CancelToken? cancelToken,
//   }) async {
//     try {
//       log("/* ---------------------------------- POST ---------------------------------- */");
//       log("POST request: $path, Params: $queryParameters, Data: $data");
//       return await _dio.post(
//         path,
//         data: data,
//         queryParameters: queryParameters,
//         cancelToken: cancelToken,
//       );
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<Response> put(
//     String path,
//     dynamic data, {
//     Map<String, dynamic>? queryParameters,
//     CancelToken? cancelToken,
//   }) async {
//     log("/* ----------------------------------- PUT ---------------------------------- */");
//     log("PUT request: $path, Params: $queryParameters, Data: $data");

//     return await _dio.put(
//       path,
//       data: data,
//       queryParameters: queryParameters,
//       cancelToken: cancelToken,
//     );
//   }

//   Future<Response> patch(
//     String path,
//     dynamic data, {
//     Map<String, dynamic>? queryParameters,
//     CancelToken? cancelToken,
//   }) async {
//     log("/* ---------------------------------- PATCH --------------------------------- */");
//     log("PATCH request: $path, Params: $queryParameters, Data: $data");

//     return await _dio.patch(
//       path,
//       data: data,
//       queryParameters: queryParameters,
//       cancelToken: cancelToken,
//     );
//   }

//   Future<Response> delete(
//     String path, {
//     Map<String, dynamic>? queryParameters,
//     CancelToken? cancelToken,
//   }) async {
//     log("/* --------------------------------- DELETE --------------------------------- */");
//     log("DELETE request: $_baseUrl$path, Params: $queryParameters");

//     return await _dio.delete(
//       path,
//       queryParameters: queryParameters,
//       cancelToken: cancelToken,
//     );
//   }
// }
