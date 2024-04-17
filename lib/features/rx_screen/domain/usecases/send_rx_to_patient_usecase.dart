import 'package:aasa_emr/common/usecase/usecase.dart';
import 'package:aasa_emr/features/rx_screen/domain/repository/rx_repository.dart';
import 'package:file_picker/file_picker.dart';

class SendRxToPatientUsecase extends Usecase<Future<void>, SendToPatientParams> {
  final RxRepository rxRepository;
  SendRxToPatientUsecase({required this.rxRepository});

  @override
  Future<void> execute(SendToPatientParams params) async {
    try {
      await rxRepository.sendRxtoPatient(params);
    } catch (e) {
      rethrow;
    }
  }
}

class SendToPatientParams {
  final PlatformFile rxFile;
  final String name;
  final String email;
  final String phoneNumber;
  final String countryCode;
  final String doctorName;

  SendToPatientParams({
    required this.rxFile,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.countryCode,
    required this.doctorName,
  });
}
