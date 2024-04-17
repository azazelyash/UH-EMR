import '../../../../common/usecase/usecase.dart';
import '../../data/models/user_model.dart';
import '../repository/user_repository.dart';

class GetUserUseCase extends Usecase<Future<User>, void> {
  final UserRepository userRepository;

  GetUserUseCase({required this.userRepository});
  @override
  Future<User> execute(void params) async {
    try {
      return await userRepository.getuser();
    } catch (e) {
      rethrow;
    }
  }
}
