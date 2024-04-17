import 'package:aasa_emr/common/usecase/usecase.dart';
import 'package:aasa_emr/features/auth/domain/repository/auth_repository.dart';

class SignUpUsecase implements Usecase<Future<String>, SignUpUsecaseParams> {
  final AuthRepository authRepository;

  SignUpUsecase({required this.authRepository});
  @override
  Future<String> execute(SignUpUsecaseParams params) {
    try {
      return authRepository.signUp(params: params);
    } catch (e) {
      rethrow;
    }
  }
}

class SignUpUsecaseParams {
  String name;
  String email;
  String phoneNumber;
  String role;
  List<String> moduleAccess;

  SignUpUsecaseParams({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.moduleAccess,
  });

  Map<String, dynamic> toJson() {
    return {
      "firstName": name,
      "lastName": "",
      "email": {
        "emailAddress": email,
        'verified': true,
      },
      "phone": {
        "phoneNumber": phoneNumber,
        "countryCode": "IN",
      },
      "role": {
        "roleName": role,
        "moduleAccess": moduleAccess,
      }
    };
  }
}
