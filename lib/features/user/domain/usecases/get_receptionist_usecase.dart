import 'package:aasa_emr/common/usecase/usecase.dart';
import 'package:aasa_emr/features/user/data/models/clinic.dart';

import '../repository/user_repository.dart';

class GetReceptionistUsecase implements Usecase<Future<List<Receptionist>>, void> {
  final UserRepository userRepository;

  GetReceptionistUsecase({required this.userRepository});
  @override
  Future<List<Receptionist>> execute(void params) async {
    try {
      return await userRepository.getReceptionists();
    } catch (e) {
      rethrow;
    }
  }
}
