import 'dart:convert';
import 'dart:developer';

import 'package:aasa_emr/features/dashboard/data/models/rx_model.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';

import '../../../../common/constants/endpoints.dart';
import '../../../../common/helper/exceptions.dart';
import '../../../../common/helper/http_service.dart';
import '../models/medicine.dart';
import '../../domain/usecases/get_all_medicine_usecase.dart';

class RxRemoteDataSource {
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

  Future<void> createRx({required String token, required RxModel data}) async {
    try {
      String url = EndPoints.createRxUrl;

      final response = await HttpService.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
        body: json.encode(data),
      );

      log(response.toString());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendRxToPatient({
    required String token,
    required PlatformFile rxFile,
    required String name,
    required String email,
    required String phoneNumber,
    required String countryCode,
    required String doctorName,
  }) async {
    String path = EndPoints.sendRxToPatient;
    try {
      Map<String, dynamic> param = {};
      param["name"] = name;
      param["email"] = email;
      param["phoneNumber"] = phoneNumber;
      param["countryCode"] = countryCode;
      param["doctorName"] = doctorName;

      if (rxFile.path != null) {
        param['file'] = await MultipartFile.fromFile(
          rxFile.path!,
          filename: rxFile.path?.split('/').last,
          contentType: MediaType('application', 'pdf'),
        );
      }

      var formData = FormData.fromMap(param);

      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';

      await dio.post(
        path,
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );
    } catch (error) {
      rethrow;
    }
  }
}
