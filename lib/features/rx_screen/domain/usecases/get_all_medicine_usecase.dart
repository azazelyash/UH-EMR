import 'package:aasa_emr/features/settings/domain/repository/settings_repository.dart';

import '../../../../common/usecase/usecase.dart';
import '../../data/models/medicine.dart';
import '../repository/rx_repository.dart';

class GetAllMedicineUseCase extends Usecase<Future<List<Medicine>>, GetMedicineParams> {
  final RxRepository rxRepository;

  GetAllMedicineUseCase({required this.rxRepository, required SettingsRepository settingsRepository});

  @override
  Future<List<Medicine>> execute(GetMedicineParams params) async {
    try {
      return await rxRepository.getAllMedicine(params);
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
