import 'package:aasa_emr/features/dashboard/data/models/rx_model.dart';

import '../models/patients.dart';
import '../../domain/usecases/get_patients_list_usecase.dart';

import '../../../../common/helper/token_manager.dart';
import '../../domain/repository/appointment_repository.dart';
import '../../domain/usecases/get_appointments_usecase.dart';
import '../data_source/appointment_remote_data_source.dart';
import '../models/appointment.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final TokenManager _tokenManager;
  final AppointmentRemoteDataSource _appointmentRemoteDataSource;

  AppointmentRepositoryImpl({required TokenManager tokenManager, required AppointmentRemoteDataSource appointmentRemoteDataSource})
      : _tokenManager = tokenManager,
        _appointmentRemoteDataSource = appointmentRemoteDataSource;

  @override
  Future<List<List<Appointment>>> getAppointments(GetAppointmentParams getAppointmentParams) async {
    try {
      final token = await _tokenManager.getAccessToken();
      if (token != null) {
        return _appointmentRemoteDataSource.getAppointments(token, getAppointmentParams);
      } else {
        throw "Auth error: Try relogin";
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateAppointment(Appointment appointment) async {
    try {
      final token = await _tokenManager.getAccessToken();
      if (token != null) {
        return _appointmentRemoteDataSource.updateAppointment(token, appointment);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Patient>> getPatients(GetPatientParam params) async {
    try {
      final token = await _tokenManager.getAccessToken();
      if (token != null) {
        return _appointmentRemoteDataSource.getPatients(
          token,
          params.doctorId,
          params.searchKey,
          params.page,
        );
      } else {
        throw "Auth error: Try Relogin";
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Patient> createPatient(Patient patient) async {
    try {
      final token = await _tokenManager.getAccessToken();
      if (token != null) {
        return await _appointmentRemoteDataSource.createPatient(token, patient);
      } else {
        throw "Auth error: Try Relogin";
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Appointment> createAppointment(Appointment appointment) async {
    try {
      final token = await _tokenManager.getAccessToken();
      if (token != null) {
        return await _appointmentRemoteDataSource.createAppointment(
          token: token,
          appointmentModel: appointment,
        );
      } else {
        throw "Auth error: Try Relogin";
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Appointment>?> getPatientAppointments(String patientId) async {
    try {
      final token = await _tokenManager.getAccessToken();
      if (token != null) {
        return await _appointmentRemoteDataSource.getPatientAppointments(
          token: token,
          patientId: patientId,
        );
      } else {
        throw "Auth error: Try Relogin";
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updatePatientProfile(Patient patient) async {
    try {
      final token = await _tokenManager.getAccessToken();
      if (token != null) {
        await _appointmentRemoteDataSource.updatePatientProfile(token, patient);
      } else {
        throw "Auth error: Try Relogin";
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<RxModel?> getAppointmentRx(String appointmentId) async {
    try {
      final token = await _tokenManager.getAccessToken();
      if (token != null) {
        return await _appointmentRemoteDataSource.getAppointmentRx(token, appointmentId);
      } else {
        throw "Auth error: Try Relogin";
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Appointment>> getDateAppointments(GetAppointmentParams getAppointmentParams) async {
    try {
      final token = await _tokenManager.getAccessToken();
      if (token != null) {
        return await _appointmentRemoteDataSource.getDateAppointments(
          token: token,
          doctorId: getAppointmentParams.userId,
          clinicIds: getAppointmentParams.clinicIds,
          page: getAppointmentParams.page,
          pageSize: getAppointmentParams.pageSize,
          date: getAppointmentParams.dateTime!.toIso8601String(),
        );
      } else {
        throw "Auth error: Try Relogin";
      }
    } catch (e) {
      rethrow;
    }
  }
}
