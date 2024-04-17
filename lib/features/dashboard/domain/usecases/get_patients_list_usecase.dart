import '../../../../common/usecase/usecase.dart';
import '../../data/models/patients.dart';
import '../repository/appointment_repository.dart';

class GetPatientsListUseCase extends Usecase<Future<List<Patient>>, GetPatientParam> {
  final AppointmentRepository appointmentRepository;

  GetPatientsListUseCase({required this.appointmentRepository});

  @override
  Future<List<Patient>> execute(GetPatientParam params) async {
    try {
      return await appointmentRepository.getPatients(params);
    } catch (e) {
      rethrow;
    }
  }
}

class GetPatientParam {
  String doctorId;
  int? page;
  String? searchKey;

  GetPatientParam({
    required this.doctorId,
    this.page,
    this.searchKey,
  });
}
