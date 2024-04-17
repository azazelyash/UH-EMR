import 'package:aasa_emr/common/usecase/usecase.dart';
import 'package:aasa_emr/features/dashboard/data/models/rx_model.dart';
import 'package:aasa_emr/features/dashboard/domain/repository/appointment_repository.dart';

class GetAppointmentRxUsecase extends Usecase<Future<RxModel?>, String> {
  final AppointmentRepository appointmentRepository;

  GetAppointmentRxUsecase({required this.appointmentRepository});
  @override
  Future<RxModel?> execute(String params) async {
    try {
      return await appointmentRepository.getAppointmentRx(params);
    } catch (e) {
      rethrow;
    }
  }
}
