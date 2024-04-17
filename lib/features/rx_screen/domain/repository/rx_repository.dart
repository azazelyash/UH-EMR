
import 'package:aasa_emr/features/dashboard/data/models/rx_model.dart';
import 'package:aasa_emr/features/rx_screen/domain/usecases/send_rx_to_patient_usecase.dart';

import '../../data/models/medicine.dart';
import '../usecases/get_all_medicine_usecase.dart';

abstract class RxRepository {
  Future<List<Medicine>> getAllMedicine(GetMedicineParams params);
  Future<void> sendRxtoPatient(SendToPatientParams params);
  Future<void> createRx(RxModel params);
}
