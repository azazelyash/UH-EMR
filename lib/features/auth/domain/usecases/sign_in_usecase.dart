import '../../../../common/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class SignInUsecase implements Usecase<Future<void>, SignInUseCaseParams> {
  final AuthRepository _authRepository;

  SignInUsecase({required AuthRepository authRepository}) : _authRepository = authRepository;

  @override
  Future<void> execute(SignInUseCaseParams signInUseCaseParams) async {
    try {
      return _authRepository.signIn(otp: signInUseCaseParams.otp, email: signInUseCaseParams.email);
    } catch (e) {
      rethrow;
    }
  }
}

class SignInUseCaseParams {
  String otp;
  String email;
  SignInUseCaseParams({
    required this.otp,
    required this.email,
  });
}
