import 'package:aasa_emr/features/dashboard/data/models/appointment.dart';

import '../../../../common/usecase/usecase.dart';
import '../repository/appointment_repository.dart';

class CreateAppointmentUseCase extends Usecase<Future<Appointment>, Appointment> {
  final AppointmentRepository appointmentRepository;

  CreateAppointmentUseCase({required this.appointmentRepository});

  @override
  Future<Appointment> execute(params) async {
    try {
      return await appointmentRepository.createAppointment(params);
    } catch (e) {
      rethrow;
    }
  }
}
