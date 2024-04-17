import '../../../../common/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class SignOutUsecase implements Usecase<Future<void>, void> {
  final AuthRepository _authRepository;

  SignOutUsecase({required AuthRepository authRepository}) : _authRepository = authRepository;

  @override
  Future<void> execute(void p) async {
    try {
      return await _authRepository.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
