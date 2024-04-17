import '../../../../common/usecase/usecase.dart';
import '../../data/models/clinic.dart';
import '../repository/user_repository.dart';

class DeleteClinicUseCase extends Usecase<Future<void>, DeleteClinicUseCaseParams> {
  final UserRepository userRepository;

  DeleteClinicUseCase({required this.userRepository});
  @override
  Future<void> execute(DeleteClinicUseCaseParams params) async {
    try {
      return userRepository.deleteClinic(params.clinic, params.userId);
    } catch (e) {
      rethrow;
    }
  }
}

class DeleteClinicUseCaseParams {
  final Clinic clinic;
  final String userId;

  DeleteClinicUseCaseParams({required this.clinic, required this.userId});
}
