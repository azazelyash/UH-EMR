import 'dart:io';

import 'package:aasa_emr/features/user/data/models/dropdown_values.dart';

import '../../data/data_source/user_local_data_source.dart';
import '../../data/models/clinic.dart';
import '../../data/models/user_model.dart';

abstract class UserRepository {
  Future<User> getuser();
  Future<void> updateUser(User user);
  Future<List<Clinic>> getClinics(String userId);
  Future<File> pickImage(PickImageSource imageSource);
  Future<void> createClinic(Clinic clinic);
  Future<void> updateClinic(Clinic clinic);
  Future<void> deleteClinic(Clinic clinic, String userId);
  Future<List<Receptionist>> getReceptionists();
  Future<DropdownValues> getDropdownValues();
  Future<void> createReceptionist(Receptionist receptionist);
  Future<void> updateReceptionist(Receptionist receptionist);
  Future<void> deleteReceptionist(Receptionist receptionist, String userId);
  Future<User> checkIfUserExists(String email);
}
