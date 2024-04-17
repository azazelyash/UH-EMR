import '../../../../common/usecase/usecase.dart';
import '../../data/models/clinic.dart';
import '../repository/user_repository.dart';

class GetClinicsUseCase extends Usecase<Future<List<Clinic>>, String> {
  final UserRepository userRepository;

  GetClinicsUseCase({required this.userRepository});
  @override
  Future<List<Clinic>> execute(String params) async {
    try {
      return await userRepository.getClinics(params);
    } catch (e) {
      rethrow;
    }
  }
}
