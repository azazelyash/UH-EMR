import 'package:aasa_emr/common/usecase/usecase.dart';
import 'package:aasa_emr/features/settings/domain/repository/settings_repository.dart';
import 'package:aasa_emr/features/user/data/models/user_model.dart';

class UpdateUserUseCase extends Usecase<Future<void>, User> {
  final SettingsRepository settingsRepository;

  UpdateUserUseCase({required this.settingsRepository});

  @override
  Future<void> execute(User params) async {
    try {
      return await settingsRepository.updateUser(params);
    } catch (e) {
      rethrow;
    }
  }
}
