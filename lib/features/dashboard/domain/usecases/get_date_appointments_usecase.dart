import 'package:aasa_emr/common/usecase/usecase.dart';
import 'package:aasa_emr/features/dashboard/data/models/appointment.dart';
import 'package:aasa_emr/features/dashboard/domain/repository/appointment_repository.dart';
import 'package:aasa_emr/features/dashboard/domain/usecases/get_appointments_usecase.dart';

class GetDateAppointmentsUsecase extends Usecase<Future<List<Appointment>?>, GetAppointmentParams> {
  final AppointmentRepository appointmentRepository;

  GetDateAppointmentsUsecase({required this.appointmentRepository});
  @override
  Future<List<Appointment>> execute(GetAppointmentParams params) async {
    try {
      return await appointmentRepository.getDateAppointments(params);
    } catch (e) {
      rethrow;
    }
  }
}
