import 'package:aasa_emr/common/helper/exceptions.dart';
import 'package:aasa_emr/features/auth/domain/usecases/sign_up_usecase.dart';

import '../../../../common/helper/token_manager.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_source/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  // final AuthLocalDataSource _authLocalDataSource;
  final TokenManager _tokenManager;

  AuthRepositoryImpl({required AuthRemoteDataSource authRemoteDataSource, required TokenManager tokenManager})
      : _authRemoteDataSource = authRemoteDataSource,
        _tokenManager = tokenManager;

  @override
  Future<void> signIn({required String otp, required String email}) async {
    try {
      final response = await _authRemoteDataSource.signIn(otp: otp, email: email);
      final token = response['data']['accessToken'];
      final refreshToken = response['data']['refreshToken'];
      await _tokenManager.saveAccessToken(token: token);
      await _tokenManager.saveRefreshToken(token: refreshToken);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> sendOtp({required String email}) {
    try {
      return _authRemoteDataSource.sendOtp(email: email);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _tokenManager.clearUserData();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> checkAuthStatus() async {
    try {
      final token = await _tokenManager.getAccessToken();

      if (token != null) {
        await _authRemoteDataSource.getuser();
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> signUp({required SignUpUsecaseParams params}) async {
    try {
      final token = await _tokenManager.getAccessToken();
      if (token == null) throw UnauthorisedException();

      return _authRemoteDataSource.signUp(token, params);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteUser({required String userId}) async {
    try {
      final token = await _tokenManager.getAccessToken();
      if (token == null) throw UnauthorisedException();
      return _authRemoteDataSource.deleteUser(token, userId);
    } catch (e) {
      rethrow;
    }
  }
}
