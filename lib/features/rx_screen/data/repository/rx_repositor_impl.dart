import 'package:aasa_emr/features/dashboard/data/models/rx_model.dart';
import 'package:aasa_emr/features/rx_screen/domain/usecases/send_rx_to_patient_usecase.dart';

import '../../../../common/helper/token_manager.dart';
import '../data_source/rx_remote_data_source.dart';
import '../models/medicine.dart';
import '../../domain/repository/rx_repository.dart';
import '../../domain/usecases/get_all_medicine_usecase.dart';

class RxRepositoryImpl implements RxRepository {
  final TokenManager _tokenManager;
  final RxRemoteDataSource _rxRemoteDataSource;

  RxRepositoryImpl({
    required TokenManager tokenManager,
    required RxRemoteDataSource rxRemoteDataSource,
  })  : _tokenManager = tokenManager,
        _rxRemoteDataSource = rxRemoteDataSource;

  @override
  Future<List<Medicine>> getAllMedicine(GetMedicineParams params) async {
    try {
      final token = await _tokenManager.getAccessToken();
      if (token != null) {
        return _rxRemoteDataSource.getGlobalMedicines(token, params);
      } else {
        throw "Auth error: Try relogin";
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> createRx(RxModel params) async {
    try {
      final token = await _tokenManager.getAccessToken();
      if (token != null) {
        return _rxRemoteDataSource.createRx(token: token, data: params);
      } else {
        throw "Auth error: Try relogin";
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> sendRxtoPatient(SendToPatientParams params) async {
    try {
      final token = await _tokenManager.getAccessToken();
      if (token != null) {
        return _rxRemoteDataSource.sendRxToPatient(
          token: token,
          name: params.name,
          email: params.email,
          phoneNumber: params.phoneNumber,
          countryCode: params.countryCode,
          rxFile: params.rxFile,
          doctorName: params.doctorName,
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
