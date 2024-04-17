import 'package:aasa_emr/common/usecase/usecase.dart';
import 'package:aasa_emr/features/dashboard/data/models/appointment.dart';
import 'package:aasa_emr/features/dashboard/domain/repository/appointment_repository.dart';

class GetPatientAppointmentUseCase extends Usecase<Future<List<Appointment>?>, String> {
  final AppointmentRepository appointmentRepository;
  GetPatientAppointmentUseCase({required this.appointmentRepository});

  @override
  Future<List<Appointment>?> execute(String params) async {
    try {
      return await appointmentRepository.getPatientAppointments(params);
    } catch (e) {
      rethrow;
    }
  }
}
