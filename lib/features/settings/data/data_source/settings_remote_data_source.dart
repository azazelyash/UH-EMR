import 'dart:convert';

import 'package:aasa_emr/common/constants/endpoints.dart';
import 'package:aasa_emr/common/helper/exceptions.dart';
import 'package:aasa_emr/common/helper/http_service.dart';
import 'package:aasa_emr/features/settings/data/model/medicine.dart';
import 'package:aasa_emr/features/settings/domain/usecase/get_all_medicine_usecase.dart';
import 'package:aasa_emr/features/user/data/models/user_model.dart';

class SettingsRemoteDataSource {
  Future<List<Medicine>> getGlobalMedicines(String token, GetMedicineParams getMedicineParams) async {
    try {
      String url = EndPoints.getAllMedicine;

      if (getMedicineParams.pageKey != null) {
        url += "?page=${getMedicineParams.pageKey}";
      } else {
        url += "?page=1";
      }

      if (getMedicineParams.searchKey != null) {
        url += "&search=${getMedicineParams.searchKey}";
      }

      final response = await HttpService.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      final medicines = response['data']['data'];

      final List<Medicine> globalMedicines = List.generate(
        medicines.length,
        (index) {
          Medicine data = Medicine.fromJson(medicines[index]);

          return data;
        },
      );

      // log("[Global Medicine] : $globalMedicines");

      return globalMedicines;
    } on AppException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUser(User user, String token) async {
    try {
      await HttpService.put(
        "${EndPoints.updateUserUrl}/${user.id}",
        headers: {
          "Authorization": "Bearer $token",
        },
        body: json.encode(
          user.toJson(),
        ),
      );
    } on AppException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
