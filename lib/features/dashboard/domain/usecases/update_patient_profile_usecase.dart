import 'package:aasa_emr/common/usecase/usecase.dart';
import 'package:aasa_emr/features/dashboard/data/models/patients.dart';
import 'package:aasa_emr/features/dashboard/domain/repository/appointment_repository.dart';

class UpdatePatientProfileUsecase extends Usecase<Future<void>, Patient> {
  final AppointmentRepository appointmentRepository;

  UpdatePatientProfileUsecase({required this.appointmentRepository});
  @override
  Future<void> execute(Patient params) async {
    try {
      await appointmentRepository.updatePatientProfile(params);
    } catch (e) {
      rethrow;
    }
  }
}
