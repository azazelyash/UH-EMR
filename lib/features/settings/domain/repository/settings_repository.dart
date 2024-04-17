import 'package:aasa_emr/features/settings/domain/usecase/get_all_medicine_usecase.dart';
import 'package:aasa_emr/features/user/data/models/user_model.dart';

import '../../data/model/medicine.dart';

abstract class SettingsRepository {
  Future<List<Medicine>> getAllMedicine(GetMedicineParams params);
  Future<void> updateUser(User params);
}
