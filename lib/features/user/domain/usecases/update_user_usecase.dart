import '../../data/models/user_model.dart';

import '../../../../common/usecase/usecase.dart';
import '../repository/user_repository.dart';

class UpadateUseCase extends Usecase<Future<void>, User> {
  final UserRepository userRepository;

  UpadateUseCase({required this.userRepository});
  @override
  Future<void> execute(User params) async {
    try {
      return await userRepository.updateUser(params);
    } catch (e) {
      rethrow;
    }
  }
}
