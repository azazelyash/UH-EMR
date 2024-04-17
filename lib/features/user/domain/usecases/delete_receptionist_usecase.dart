import '../../../../common/usecase/usecase.dart';
import '../../data/models/clinic.dart';
import '../repository/user_repository.dart';

class DeleteReceptionistUsecase implements Usecase<Future<void>, DeleteReceptionistsUsecaseParams> {
  final UserRepository userRepository;

  DeleteReceptionistUsecase({required this.userRepository});
  @override
  Future<void> execute(DeleteReceptionistsUsecaseParams params) async {
    try {
      await userRepository.deleteReceptionist(params.receptionist, params.userId);
    } catch (e) {
      rethrow;
    }
  }
}

class DeleteReceptionistsUsecaseParams {
  final Receptionist receptionist;
  final String userId;

  DeleteReceptionistsUsecaseParams({required this.receptionist, required this.userId});
}
