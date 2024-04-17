import 'package:aasa_emr/features/dashboard/data/models/rx_model.dart';

import '../../data/models/patients.dart';
import '../usecases/get_patients_list_usecase.dart';

import '../../data/models/appointment.dart';
import '../usecases/get_appointments_usecase.dart';

abstract class AppointmentRepository {
  Future<void> updatePatientProfile(Patient patient);
  Future<Patient> createPatient(Patient patient);
  Future<List<Appointment>> getDateAppointments(GetAppointmentParams getAppointmentParams);
  Future<RxModel?> getAppointmentRx(String appointmentId);
  Future<void> updateAppointment(Appointment appointment);
  Future<Appointment> createAppointment(Appointment appointment);
  Future<List<Patient>> getPatients(GetPatientParam getPatientParam);
  Future<List<Appointment>?> getPatientAppointments(String patientId);
  Future<List<List<Appointment>>> getAppointments(GetAppointmentParams getAppointmentParams);
}
