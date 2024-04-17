import '../../../../common/usecase/usecase.dart';
import '../../data/models/appointment.dart';
import '../repository/appointment_repository.dart';

class GetAppointmensUseCase extends Usecase<Future<List<List<Appointment>>>, GetAppointmentParams> {
  final AppointmentRepository appointmentRepository;

  GetAppointmensUseCase({required this.appointmentRepository});

  @override
  Future<List<List<Appointment>>> execute(GetAppointmentParams params) async {
    try {
      return await appointmentRepository.getAppointments(params);
    } catch (e) {
      rethrow;
    }
  }
}

class GetAppointmentParams {
  String userId;
  List<String> clinicIds;
  DateTime? dateTime;
  int? page;
  int pageSize;
  String? searchKey;

  GetAppointmentParams({
    required this.userId,
    required this.clinicIds,
    this.dateTime,
    this.page,
    this.pageSize = 10,
    this.searchKey,
  });
}
