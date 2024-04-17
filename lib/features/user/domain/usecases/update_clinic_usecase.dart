import '../../../../common/usecase/usecase.dart';
import '../../data/models/clinic.dart';
import '../repository/user_repository.dart';

class UpdateClinicUseCase extends Usecase<Future<void>, Clinic> {
  final UserRepository userRepository;

  UpdateClinicUseCase({required this.userRepository});
  @override
  Future<void> execute(Clinic params) async {
    try {
      return userRepository.updateClinic(params);
    } catch (e) {
      rethrow;
    }
  }
}
