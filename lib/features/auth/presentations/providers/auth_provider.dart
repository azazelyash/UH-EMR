import 'dart:async';

import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../../../common/provider/loading_provider.dart';
import '../../domain/usecases/check_auth_status_usecase.dart';
import '../../domain/usecases/delete_user_usecase.dart';
import '../../domain/usecases/send_otp_usecase.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';

class AuthProvider extends LoadingProvider {
  final SendOtpUsecase sendOtpUsecase;
  final SignInUsecase signInUsecase;
  final SignOutUsecase signOutUsecase;
  final CheckAuthStatusUseCase checkAuthStatusUseCase;
  final SignUpUsecase signUpUsecase;
  final DeleteUserUsecase deleteUserUsecase;

  int _resendOtpRemainingDuration = 60;

  late Timer _resendOtpTimer;
  bool _isResendOtpEnabled = true;

  bool _isAuthenticated = false;
  String _otp = "";

  bool _otpHasError = false;

  AuthProvider({
    required this.sendOtpUsecase,
    required this.signInUsecase,
    required this.signOutUsecase,
    required this.checkAuthStatusUseCase,
    required this.signUpUsecase,
    required this.deleteUserUsecase,
  });
  bool get isAuthenticated => _isAuthenticated;

  bool get isResendOtpEnabled => _isResendOtpEnabled;

  String get otp => _otp;

  set otp(String value) {
    _otp = value;
    notifyListeners();
  }

  bool get otpHasError => _otpHasError;

  set otpHasError(bool value) {
    _otpHasError = value;
    notifyListeners();
  }

  int get resendOtpRemainingDuration => _resendOtpRemainingDuration;

  set resendOtpRemainingDuration(int value) {
    _resendOtpRemainingDuration = value;
    notifyListeners();
  }

  Future<void> checkAuthState() async {
    try {
      _isAuthenticated = await checkAuthStatusUseCase.execute(null);
    } catch (e) {
      _isAuthenticated = false;
      rethrow;
    } finally {
      await Future.delayed(
        const Duration(
          milliseconds: 100,
        ),
      );
      FlutterNativeSplash.remove();

      notifyListeners();
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await deleteUserUsecase.execute(userId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendOtp({required String email}) async {
    setLoading(true);
    try {
      await sendOtpUsecase.execute(email);
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<void> signIn(SignInUseCaseParams signInUseCaseParams) async {
    setLoading(true);
    try {
      await signInUsecase.execute(signInUseCaseParams);
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<void> signOut() async {
    setLoading(true);
    try {
      await signOutUsecase.execute(null);
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<String> signUp(SignUpUsecaseParams params) async {
    try {
      return await signUpUsecase.execute(params);
    } catch (e) {
      rethrow;
    }
  }

  void startResendOtpTimer() {
    _isResendOtpEnabled = false;
    notifyListeners();

    _resendOtpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendOtpRemainingDuration == 0) {
        _resendOtpTimer.cancel();
        _resendOtpRemainingDuration = 60; // Reset the timer duration
        _isResendOtpEnabled = true;
      } else {
        _resendOtpRemainingDuration--;
      }
      notifyListeners();
    });
  }
}
