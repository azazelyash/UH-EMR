import '../../../../common/usecase/usecase.dart';
import '../../data/models/user_model.dart';
import '../repository/user_repository.dart';

class CheckIfUserExistsUseCase extends Usecase<Future<User>, String> {
  final UserRepository _userRepository;

  CheckIfUserExistsUseCase({required UserRepository userRepository}) : _userRepository = userRepository;
  @override
  Future<User> execute(String params) async {
    try {
      return _userRepository.checkIfUserExists(params);
    } catch (e) {
      rethrow;
    }
  }
}
