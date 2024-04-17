import 'dart:convert';
import 'dart:developer';

import 'package:aasa_emr/features/user/data/models/dropdown_values.dart';

import '../../../../common/constants/endpoints.dart';
import '../../../../common/helper/http_service.dart';
import '../models/clinic.dart';
import 'package:dio/dio.dart';

import '../models/user_model.dart';

class UserRemoteDataSource {
  // final ApiService apiService;

  UserRemoteDataSource();
  Future<User> getuser(String token) async {
    try {
      final response = await HttpService.get(
        EndPoints.getUserUrl,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      // return User.fromJson(response['data']);
      final data = User.fromJson(response['data']);

      log("[User Data] ${data.toJson()}");

      return data;
    } on DioException catch (e) {
      throw e.response ?? "An Error Occurred";
    } catch (e) {
      log(e.toString());
      throw "An error occured";
    }
  }

  Future<void> updateUser(User user, String token) async {
    try {
      await HttpService.put(
        "${EndPoints.updateUserUrl}/${user.id}",
        headers: {
          "Authorization": "Bearer $token",
        },
        body: json.encode(
          user.toJson(),
        ),
      );
    } on DioException catch (e) {
      throw e.response ?? "An Error Occurred";
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Clinic>> getClinics(String token, String userId) async {
    try {
      final response = await HttpService.get(
        EndPoints.getClinicsUrl,
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      return (response['data'] as List).map((e) => Clinic.fromJson(e)).toList();
    } on DioException catch (e) {
      throw e.response ?? "An Error Occurred";
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createClinic(String token, Clinic clinic) async {
    try {
      await HttpService.post(
        EndPoints.createClinicUrl,
        headers: {
          "Authorization": "Bearer $token",
        },
        body: json.encode(
          clinic.toJson(),
        ),
      );
    } on DioException catch (e) {
      throw e.response ?? "An Error Occurred";
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateClinic(String token, Clinic clinic) async {
    try {
      await HttpService.put(
        "${EndPoints.updateClinicUrl}/${clinic.id}",
        headers: {
          "Authorization": "Bearer $token",
        },
        body: json.encode(
          clinic.toJson(),
        ),
      );
    } on DioException catch (e) {
      throw e.response ?? "An Error Occurred";
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteClinic(String token, Clinic clinic, String userId) async {
    try {
      await HttpService.delete(
          // "${EndPoints.deleteClinicUrl}/${clinic.id}",
          EndPoints.deleteClinicUrl,
          headers: {
            "Authorization": "Bearer $token",
          },
          body: json.encode({
            "clinicId": clinic.id,
            "doctorId": userId,
          }));
    } on DioException catch (e) {
      throw e.response ?? "An Error Occurred";
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Receptionist>> getReceptionists(String token) async {
    try {
      final response = await HttpService.get(
        EndPoints.getAllReceptionistsUrl,
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      return (response['data'] as List)
          .map(
            (e) => Receptionist.fromJson(e),
          )
          .toList();
    } on DioException catch (e) {
      throw e.response ?? "An Error Occurred";
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createReceptionist(String token, Receptionist receptionist) async {
    try {
      await HttpService.post(
        EndPoints.createReceptionistUrl,
        headers: {
          "Authorization": "Bearer $token",
        },
        body: json.encode(
          receptionist.toJson(),
        ),
      );
    } on DioException catch (e) {
      throw e.response ?? "An Error Occurred";
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateReceptionist(String token, Receptionist receptionist) async {
    try {
      await HttpService.put(
        "${EndPoints.updateReceptionistUrl}/${receptionist.id}",
        headers: {
          "Authorization": "Bearer $token",
        },
        body: json.encode(
          receptionist.toJson(),
        ),
      );
    } on DioException catch (e) {
      throw e.response ?? "An Error Occurred";
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteReceptionist(String token, Receptionist receptionist, String userId) async {
    try {
      await HttpService.delete(
          // "${EndPoints.deleteReceptionistUrl}/${receptionist.id}",
          EndPoints.deleteReceptionistUrl,
          headers: {
            "Authorization": "Bearer $token",
          },
          body: json.encode({
            "receptionistId": receptionist.id,
            "doctorId": userId,
          }));
    } on DioException catch (e) {
      throw e.response ?? "An Error Occurred";
    } catch (e) {
      rethrow;
    }
  }

  Future<DropdownValues> getDropdownValues(String token) async {
    try {
      String url = EndPoints.getDropdownValues;
      final response = await HttpService.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      final data = DropdownValues.fromJson(response['data']);

      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<User> checkIfUserExists(String token, String email) async {
    try {
      final response = await HttpService.post(
        EndPoints.checkIfUserExistsUrl,
        headers: {
          "Authorization": "Bearer $token",
        },
        body: json.encode({
          "email": email,
        }),
      );
      if (response['data'].isEmpty) throw "User does not exist";
      return User.fromJson(response['data']);
    } on DioException catch (e) {
      throw e.response ?? "An Error Occurred";
    } catch (e) {
      rethrow;
    }
  }
}
