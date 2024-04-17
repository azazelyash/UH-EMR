import 'package:aasa_emr/common/usecase/usecase.dart';
import 'package:aasa_emr/features/user/data/models/clinic.dart';
import 'package:aasa_emr/features/user/domain/repository/user_repository.dart';

class CreateReceptionistUsecase implements Usecase<Future<void>, Receptionist> {
  final UserRepository _userRepository;

  CreateReceptionistUsecase({required UserRepository userRepository}) : _userRepository = userRepository;
  @override
  Future<void> execute(Receptionist params) async {
    try {
      await _userRepository.createReceptionist(params);
    } catch (e) {
      rethrow;
    }
  }
}
