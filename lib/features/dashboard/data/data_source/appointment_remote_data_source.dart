import 'dart:convert';
import 'dart:developer';

import 'package:aasa_emr/features/dashboard/data/models/rx_model.dart';

import '../models/patients.dart';

import '../../../../common/helper/exceptions.dart';

import '../../../../common/constants/endpoints.dart';
import '../../../../common/helper/http_service.dart';
import '../models/appointment.dart';
import '../../domain/usecases/get_appointments_usecase.dart';

class AppointmentRemoteDataSource {
  Future<List<List<Appointment>>> getAppointments(String token, GetAppointmentParams getAppointmentParams) async {
    try {
      Map<String, dynamic> body = {};
      if (getAppointmentParams.dateTime == null) {
        body = {
          "doctorId": getAppointmentParams.userId,
          "clinicIds": getAppointmentParams.clinicIds,
        };
      } else {
        body = {
          "doctorId": getAppointmentParams.userId,
          "clinicIds": getAppointmentParams.clinicIds,
          "date": getAppointmentParams.dateTime?.toIso8601String(),
        };
      }

      String url = EndPoints.getAppointmentsUrl;

      if (getAppointmentParams.page != null) {
        url += "?page=${getAppointmentParams.page}&pageSize=${getAppointmentParams.pageSize}";
      }
      if (getAppointmentParams.searchKey != null) {
        url += "&search=${getAppointmentParams.searchKey}";
      }

      final response = await HttpService.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
        body: json.encode(body),
      );

      final appointments = response['data'];

      final List<Appointment> previousAppointment = List.generate(
        appointments['previous'].length,
        (index) => Appointment.fromJson(appointments['previous'][index]),
      );
      final List<Appointment> upcomingAppointment = List.generate(
        appointments['upcoming'].length,
        (index) => Appointment.fromJson(appointments['upcoming'][index]),
      );

      return [previousAppointment, upcomingAppointment];
    } on AppException catch (_) {
      rethrow;
    } catch (e) {
      throw "An error occured";
    }
  }

  Future<void> updateAppointment(String token, Appointment appointment) async {
    try {
      await HttpService.put(
        EndPoints.updateAppointmentUrl,
        headers: {
          "Authorization": "Bearer $token",
        },
        body: json.encode(appointment.toJsonWithPatientId()),
      );
    } on AppException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Patient>> getPatients(String token, String doctorId, String? searchKey, int? page) async {
    try {
      String url = "${EndPoints.getPatients}?uids=$doctorId";

      if (page != null) {
        url += "&page=$page";
      }
      if (searchKey != null) {
        url += "&search=$searchKey";
      }

      final response = await HttpService.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      final List<Patient> patients = List.generate(
        response['data']['data'].length,
        (index) => Patient.fromJson(response['data']['data'][index]),
      );

      return patients;
    } on AppException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<Patient> createPatient(String token, Patient patient) async {
    try {
      String url = EndPoints.createPatient;

      final response = await HttpService.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
        body: json.encode(patient.toJson()),
      );

      final Patient patientModel = Patient.fromJson(response['data']);

      return patientModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<Appointment> createAppointment({
    required String token,
    required Appointment appointmentModel,
  }) async {
    try {
      String url = EndPoints.createAppointment;

      final response = await HttpService.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
        body: json.encode({
          "clinic": appointmentModel.clinic,
          "dateTime": appointmentModel.dateTime?.toIso8601String(),
          "userDoctor": appointmentModel.userDoctor,
          "userPatient": appointmentModel.userPatient!.id,
        }),
      );

      Appointment appointment = Appointment.fromJson(response['data']);

      // log("[Appointment] ${appointment.toJson()}");
      return appointment;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Appointment>?> getPatientAppointments({required String token, required String patientId}) async {
    try {
      String url = "${EndPoints.getPatientAppointmentsUrl}/$patientId";

      final response = await HttpService.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      List<Appointment> appointments = List.generate(
        response['data']['data'].length,
        (index) => Appointment.fromJson(response['data']['data'][index]),
      );

      for (var appointment in appointments) {
        log(appointment.toJson().toString());
      }

      return appointments;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updatePatientProfile(String token, Patient patient) async {
    try {
      String url = "${EndPoints.updatePatientUrl}/${patient.id}";

      await HttpService.put(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
        body: json.encode(patient.toJson()),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<RxModel?> getAppointmentRx(String token, String appointmentId) async {
    try {
      String url = "${EndPoints.getAppointmentRx}/$appointmentId";

      final response = await HttpService.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response['data'].length == 0) {
        return null;
      } else {
        return RxModel.fromJson(response['data']);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Appointment>> getDateAppointments({
    required String token,
    required String doctorId,
    required List<String> clinicIds,
    int? page,
    int? pageSize,
    String? date,
  }) async {
    try {
      String url = EndPoints.getDateAppointment;

      final response = await HttpService.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
        body: json.encode({
          "doctorId": doctorId,
          "clinicIds": clinicIds,
          "date": date,
        }),
      );

      final List<Appointment> appointments = List.generate(
        response['data']['appointments'].length,
        (index) => Appointment.fromJson(response['data']['appointments'][index]),
      );

      return appointments;
      // if (response['data'].length == 0) {
      //   return null;
      // } else {
      // }
    } catch (e) {
      rethrow;
    }
  }
}
