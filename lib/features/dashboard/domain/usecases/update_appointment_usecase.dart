
import '../../../../common/usecase/usecase.dart';
import '../../data/models/appointment.dart';

import '../repository/appointment_repository.dart';

class UpdateAppointmentUseCase implements Usecase<Future<void>, Appointment> {
  final AppointmentRepository appointmentRepository;

  UpdateAppointmentUseCase({required this.appointmentRepository});
  @override
  Future<void> execute(Appointment params) async {
    try {
      return appointmentRepository.updateAppointment(params);
    } catch (e) {
      rethrow;
    }
  }
}
