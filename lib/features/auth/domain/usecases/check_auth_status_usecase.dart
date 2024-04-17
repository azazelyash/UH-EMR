import '../../../../common/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class CheckAuthStatusUseCase implements Usecase<Future<bool>, void> {
  final AuthRepository _authRepository;

  CheckAuthStatusUseCase({required AuthRepository authRepository}) : _authRepository = authRepository;

  @override
  Future<bool> execute(void p) {
    return _authRepository.checkAuthStatus();
  }
}
