import 'dart:developer';

import 'package:aasa_emr/features/user/data/models/dropdown_values.dart';
import 'package:aasa_emr/features/user/domain/usecases/check_if_user_exists_usecase.dart';
import 'package:aasa_emr/features/user/domain/usecases/create_clinic_usecase.dart';
import 'package:aasa_emr/features/user/domain/usecases/create_recptionist_usecase.dart';
import 'package:aasa_emr/features/user/domain/usecases/delete_clinic_usecase.dart';
import 'package:aasa_emr/features/user/domain/usecases/delete_receptionist_usecase.dart';
import 'package:aasa_emr/features/user/domain/usecases/get_dropdown_values_usecase.dart';
import 'package:aasa_emr/features/user/domain/usecases/get_receptionist_usecase.dart';
import 'package:aasa_emr/features/user/domain/usecases/update_clinic_usecase.dart';

import '../../../../common/provider/loading_provider.dart';
import '../../data/models/clinic.dart';
import '../../data/models/user_model.dart';
import '../../domain/usecases/get_clinics_usecase.dart';
import '../../domain/usecases/get_user_usecase.dart';
import '../../domain/usecases/update_receptionist_usecase.dart';
import '../../domain/usecases/update_user_usecase.dart';

class UserProvider extends LoadingProvider {
  final GetUserUseCase getUserUseCase;
  final UpadateUseCase updateUserUseCase;
  final GetClinicsUseCase getClinicsUseCase;
  final CreateClinicUseCase createClinicUseCase;
  final UpdateClinicUseCase updateClinicUseCase;
  final DeleteClinicUseCase deleteClinicUseCase;
  final GetReceptionistUsecase getReceptionistUsecase;
  final GetDropdownValuesUsecase getDropdownValuesUsecase;
  final CreateReceptionistUsecase createReceptionistUsecase;
  final UpdateReceptionistUsecase updateReceptionistUsecase;
  final DeleteReceptionistUsecase deleteReceptionistUsecase;
  final CheckIfUserExistsUseCase checkIfUserExistsUseCase;

  UserProvider({
    required this.getUserUseCase,
    required this.updateUserUseCase,
    required this.getClinicsUseCase,
    required this.createClinicUseCase,
    required this.updateClinicUseCase,
    required this.deleteClinicUseCase,
    required this.getReceptionistUsecase,
    required this.getDropdownValuesUsecase,
    required this.createReceptionistUsecase,
    required this.updateReceptionistUsecase,
    required this.deleteReceptionistUsecase,
    required this.checkIfUserExistsUseCase,
  });

  User _user = User();
  User get user => _user;

  User? _selectedDoctor;
  User? get selectedDoctor => _selectedDoctor;

  List<Clinic> _clinics = [];
  List<Clinic> get clinics => _clinics;

  final List<Receptionist> _receptionists = [];
  List<Receptionist> get receptionists => _receptionists;

  final List<Clinic> _selectedClinics = [];
  List<Clinic> get selectedClinics => _selectedClinics;

  DropdownValues? _dropdownValues;
  DropdownValues? get dropdownValues => _dropdownValues;

  List<User>? _doctorsAssociatedWithSelectedClinic;
  List<User>? get doctorsAssociatedWithSelectedClinic => _doctorsAssociatedWithSelectedClinic;

  set dropdownValues(DropdownValues? value) {
    _dropdownValues = value;
    notifyListeners();
  }

  set doctorsAssociatedWithSelectedClinic(List<User>? value) {
    _doctorsAssociatedWithSelectedClinic = value;
    notifyListeners();
  }

  set selectedDoctor(User? value) {
    _selectedDoctor = value;
    notifyListeners();
  }

  Future<void> getUser({bool informListenersAtStart = true}) async {
    try {
      setLoading(true, informListeners: informListenersAtStart);
      _user = await getUserUseCase.execute(null);
      _receptionists.clear();
      _receptionists.addAll(_user.profile!.receptionists);
      log("User Name : ${_user.profile?.name!}");
    } catch (e) {
      log(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> updateUser(User user) async {
    try {
      setLoading(true);
      await updateUserUseCase.execute(user);
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<void> getClinics({bool informListenersAtStart = true}) async {
    try {
      setLoading(true, informListeners: informListenersAtStart);
      _clinics = await getClinicsUseCase.execute(user.id!);
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  selectClinic(List<Clinic> clinics) {
    _selectedClinics.clear();
    _selectedClinics.addAll(clinics);
  }

  void makeUserEmpty() {
    _user = User();
  }

  Future<void> createClinic(Clinic clinic) async {
    try {
      setLoading(true);
      await createClinicUseCase.execute(clinic);
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<void> updateClinic(Clinic clinic) async {
    try {
      setLoading(true);
      await updateClinicUseCase.execute(clinic);
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<void> deleteClinic(Clinic clinic, String userId) async {
    try {
      setLoading(true);
      await deleteClinicUseCase.execute(DeleteClinicUseCaseParams(clinic: clinic, userId: userId));
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<void> getReceptionists() async {
    try {
      setLoading(true);
      receptionists.clear();
      final newReceptionists = await getReceptionistUsecase.execute(null);
      _receptionists.addAll(newReceptionists);
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<void> createReceptionist(Receptionist receptionist) async {
    try {
      setLoading(true);
      await createReceptionistUsecase.execute(receptionist);
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<void> updateReceptionist(Receptionist receptionist) async {
    try {
      setLoading(true);
      await updateReceptionistUsecase.execute(receptionist);
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<void> deleteReceptionist(Receptionist receptionist, String userId) async {
    try {
      setLoading(true);
      await deleteReceptionistUsecase.execute(DeleteReceptionistsUsecaseParams(receptionist: receptionist, userId: userId));
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<void> getDropdownValues({bool informListenersAtStart = true}) async {
    try {
      setLoading(true, informListeners: informListenersAtStart);
      dropdownValues = await getDropdownValuesUsecase.execute(null);
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<User> checkIfUserExists(String email) async {
    try {
      setLoading(true);
      return await checkIfUserExistsUseCase.execute(email);
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }
}
