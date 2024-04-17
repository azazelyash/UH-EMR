import 'dart:io';

import 'package:aasa_emr/features/user/data/data_source/user_local_data_source.dart';
import 'package:aasa_emr/features/user/data/models/dropdown_values.dart';

import '../../../../common/helper/token_manager.dart';
import '../../domain/repository/user_repository.dart';
import '../data_source/user_remote_data_source.dart';
import '../models/clinic.dart';
import '../models/user_model.dart';

class UserRepositoryImpl extends UserRepository {
  final TokenManager _tokenManager;
  final UserRemoteDataSource _userRemoteDataSource;
  final UserLocalDataSource _userLocalDataSource;

  UserRepositoryImpl(
      {required TokenManager tokenManager,
      required UserRemoteDataSource userRemoteDataSource,
      required UserLocalDataSource userLocalDataSource})
      : _tokenManager = tokenManager,
        _userRemoteDataSource = userRemoteDataSource,
        _userLocalDataSource = userLocalDataSource;

  @override
  Future<User> getuser() async {
    try {
      final token = await _tokenManager.getAccessToken();
      if (token != null) {
        return await _userRemoteDataSource.getuser(token);
      }
      throw "Authentication error";
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateUser(User user) async {
    try {
      final token = await _tokenManager.getAccessToken();
      if (token != null) {
        return await _userRemoteDataSource.updateUser(user, token);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Clinic>> getClinics(String userId) async {
    try {
      final token = await _tokenManager.getAccessToken();
      if (token != null) {
        return _userRemoteDataSource.getClinics(token, userId);
      } else {
        throw "Auth error: Try relogin";
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<File> pickImage(PickImageSource imageSource) {
    try {
      return _userLocalDataSource.pickImage(imageSource);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> createClinic(Clinic clinic) async {
    try {
      final token = await _tokenManager.getAccessToken();
      if (token == null) throw "Auth error: Try relogin";
      await _userRemoteDataSource.createClinic(token, clinic);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteClinic(Clinic clinic, String userId) async {
    try {
      final token = await _tokenManager.getAccessToken();
      if (token == null) throw "Auth error: Try relogin";
      await _userRemoteDataSource.deleteClinic(token, clinic, userId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateClinic(Clinic clinic) async {
    try {
      final token = await _tokenManager.getAccessToken();
      if (token == null) throw "Auth error: Try relogin";
      await _userRemoteDataSource.updateClinic(token, clinic);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> createReceptionist(Receptionist receptionist) async {
    try {
      final token = await _tokenManager.getAccessToken();
      if (token == null) throw "Auth error: Try relogin";
      await _userRemoteDataSource.createReceptionist(token, receptionist);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteReceptionist(Receptionist receptionist, String userId) async {
    try {
      final token = await _tokenManager.getAccessToken();
      if (token == null) throw "Auth error: Try relogin";
      await _userRemoteDataSource.deleteReceptionist(token, receptionist, userId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Receptionist>> getReceptionists() async {
    try {
      final token = await _tokenManager.getAccessToken();
      if (token == null) throw "Auth error: Try relogin";
      return await _userRemoteDataSource.getReceptionists(token);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateReceptionist(Receptionist receptionist) async {
    try {
      final token = await _tokenManager.getAccessToken();
      if (token == null) throw "Auth error: Try relogin";
      return _userRemoteDataSource.updateReceptionist(token, receptionist);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DropdownValues> getDropdownValues() async {
    try {
      final token = await _tokenManager.getAccessToken();
      if (token == null) throw "Auth error: Try relogin";
      return await _userRemoteDataSource.getDropdownValues(token);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> checkIfUserExists(String email) async {
    try {
      final token = await _tokenManager.getAccessToken();
      if (token == null) throw "Auth error: Try relogin";
      return _userRemoteDataSource.checkIfUserExists(token, email);
    } catch (e) {
      rethrow;
    }
  }
}
