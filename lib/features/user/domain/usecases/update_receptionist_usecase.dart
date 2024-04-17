import 'package:aasa_emr/common/usecase/usecase.dart';
import 'package:aasa_emr/features/user/data/models/clinic.dart';
import 'package:aasa_emr/features/user/domain/repository/user_repository.dart';

class UpdateReceptionistUsecase implements Usecase<Future<void>, Receptionist> {
  final UserRepository userRepository;

  UpdateReceptionistUsecase({required this.userRepository});
  @override
  Future<void> execute(Receptionist params) async {
    try {
      await userRepository.updateReceptionist(params);
    } catch (e) {
      rethrow;
    }
  }
}
