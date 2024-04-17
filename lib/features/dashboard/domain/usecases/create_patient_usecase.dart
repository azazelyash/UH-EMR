import '../../../../common/usecase/usecase.dart';
import '../../data/models/patients.dart';
import '../repository/appointment_repository.dart';

class CreatePatientUseCase extends Usecase<Future<Patient>, Patient> {
  final AppointmentRepository appointmentRepository;

  CreatePatientUseCase({required this.appointmentRepository});

  @override
  Future<Patient> execute(Patient params) async {
    try {
      return await appointmentRepository.createPatient(params);
    } catch (e) {
      rethrow;
    }
  }
}
