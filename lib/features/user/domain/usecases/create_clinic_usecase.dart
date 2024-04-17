import 'package:aasa_emr/common/usecase/usecase.dart';
import 'package:aasa_emr/features/user/data/models/clinic.dart';

import '../repository/user_repository.dart';

class CreateClinicUseCase extends Usecase<Future<void>, Clinic> {
  final UserRepository userRepository;

  CreateClinicUseCase({required this.userRepository});
  @override
  Future<void> execute(Clinic params) async {
    try {
      return await userRepository.createClinic(params);
    } catch (e) {
      rethrow;
    }
  }
}
