import 'dart:convert';

import 'package:aasa_emr/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:flutter/services.dart';

import '../../../../common/constants/endpoints.dart';
import '../../../../common/helper/http_service.dart';

class AuthRemoteDataSource {
  // final ApiService _apiService;

  AuthRemoteDataSource();

  Future<void> sendOtp({required String email}) async {
    try {
      Map<String, dynamic> data = {
        "email": {"emailAddress": email}
      };
      await HttpService.post(EndPoints.sendOtpUrl,
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode(data));
    } on PlatformException catch (e) {
      throw e.message ?? "An Error Occurred";
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> signIn({required String otp, required String email}) async {
    try {
      Map<String, dynamic> data = {"email": email, "otp": otp};
      var response = await HttpService.post(
        EndPoints.signInUrl,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(data),
      );
      return response;
    } on PlatformException catch (e) {
      throw e.message ?? "An Error Occurred";
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getuser() async {
    // try {
    //   await _apiService.get(EndPoints.getUserUrl);
    // } on DioException catch (e) {
    //   throw e.response ?? "An Error Occurred";
    // } catch (e) {
    //   throw "An error occured";
    // }
  }
  Future<String> signUp(String token, SignUpUsecaseParams params) async {
    try {
      final data = await HttpService.post(
        EndPoints.signUpUrl,
        headers: {
          "Authorization": "Bearer $token",
        },
        body: json.encode(params.toJson()),
      );

      final id = data['data']['_id'];
      return id;
    } on PlatformException catch (e) {
      throw e.message ?? "An Error Occurred";
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUser(String token, String userId) async {
    try {
      await HttpService.delete(
        "${EndPoints.deleteUserUrl}/$userId",
        headers: {
          "Authorization": "Bearer $token",
        },
      );
    } on PlatformException catch (e) {
      throw e.message ?? "An Error Occurred";
    } catch (e) {
      rethrow;
    }
  }
}
