import 'package:aasa_emr/features/settings/data/model/medicine.dart';
import 'package:aasa_emr/features/settings/domain/repository/settings_repository.dart';

import '../../../../common/usecase/usecase.dart';

class GetAllMedicineUseCase extends Usecase<Future<List<Medicine>>, GetMedicineParams> {
  final SettingsRepository settingsRepository;

  GetAllMedicineUseCase({required this.settingsRepository});

  @override
  Future<List<Medicine>> execute(GetMedicineParams params) async {
    try {
      return await settingsRepository.getAllMedicine(params);
    } catch (e) {
      rethrow;
    }
  }
}

class GetMedicineParams {
  final int? pageKey;
  final String? searchKey;

  GetMedicineParams({
    this.pageKey,
    this.searchKey,
  });
}
