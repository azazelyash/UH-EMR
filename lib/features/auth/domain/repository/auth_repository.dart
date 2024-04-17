import 'package:aasa_emr/features/auth/domain/usecases/sign_up_usecase.dart';

abstract class AuthRepository {
  Future<void> signOut();
  Future<bool> checkAuthStatus();
  Future<void> signIn({required String otp, required String email});
  Future<void> sendOtp({required String email});
  Future<String> signUp({required SignUpUsecaseParams params});
  Future<void> deleteUser({required String userId});
}
