import 'package:aasa_emr/common/helper/token_manager.dart';
import 'package:aasa_emr/features/settings/data/data_source/settings_remote_data_source.dart';
import 'package:aasa_emr/features/settings/data/model/medicine.dart';
import 'package:aasa_emr/features/settings/domain/repository/settings_repository.dart';
import 'package:aasa_emr/features/settings/domain/usecase/get_all_medicine_usecase.dart';
import 'package:aasa_emr/features/user/data/models/user_model.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final TokenManager _tokenManager;
  final SettingsRemoteDataSource _settingsRemoteDataSource;

  SettingsRepositoryImpl({
    required TokenManager tokenManager,
    required SettingsRemoteDataSource settingsRemoteDataSource,
  })  : _tokenManager = tokenManager,
        _settingsRemoteDataSource = settingsRemoteDataSource;

  @override
  Future<List<Medicine>> getAllMedicine(GetMedicineParams params) async {
    try {
      final token = await _tokenManager.getAccessToken();
      if (token != null) {
        return _settingsRemoteDataSource.getGlobalMedicines(token, params);
      } else {
        throw "Auth error: Try relogin";
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateUser(User user) async {
    try {
      final token = await _tokenManager.getAccessToken();
      if (token != null) {
        return await _settingsRemoteDataSource.updateUser(user, token);
      }
    } catch (e) {
      rethrow;
    }
  }
}
