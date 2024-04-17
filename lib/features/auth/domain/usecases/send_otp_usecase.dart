import '../../../../common/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class SendOtpUsecase implements Usecase<Future<void>, String> {
  final AuthRepository _authRepository;

  SendOtpUsecase({required AuthRepository authRepository}) : _authRepository = authRepository;

  @override
  Future<void> execute(String email) async {
    try {
      return _authRepository.sendOtp(email: email);
    } catch (error) {
      rethrow;
    }
  }
}
