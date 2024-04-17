import 'package:aasa_emr/common/usecase/usecase.dart';

import '../repository/auth_repository.dart';

class DeleteUserUsecase implements Usecase<Future<void>, String> {
  final AuthRepository _authRepository;

  DeleteUserUsecase({required AuthRepository authRepository}) : _authRepository = authRepository;
  @override
  Future<void> execute(String params) async {
    try {
      return _authRepository.deleteUser(userId: params);
    } catch (e) {
      rethrow;
    }
  }
}
