import 'package:aasa_emr/features/dashboard/data/models/rx_model.dart';
import 'package:aasa_emr/features/dashboard/domain/usecases/get_appointment_rx_usecase.dart';
import 'package:aasa_emr/features/dashboard/domain/usecases/get_date_appointments_usecase.dart';

import '../../data/models/patients.dart';
import '../../domain/usecases/create_patient_usecase.dart';
import '../../domain/usecases/get_patients_list_usecase.dart';
import '../../domain/usecases/create_appointment_usecase.dart';
import '../../domain/usecases/update_appointment_usecase.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:aasa_emr/features/dashboard/domain/usecases/update_patient_profile_usecase.dart';
import 'package:aasa_emr/features/dashboard/domain/usecases/get_patient_appointment_usecase.dart';

import '../../data/models/appointment.dart';
import '../../../../common/provider/loading_provider.dart';
import '../../domain/usecases/get_appointments_usecase.dart';

class AppointmentProvider extends LoadingProvider {
  final GetAppointmensUseCase getAppointmentsUsecase;
  final UpdateAppointmentUseCase updateAppointmentUseCase;
  final CreateAppointmentUseCase createAppointmentUseCase;
  final GetPatientsListUseCase getPatientsListUseCase;
  final CreatePatientUseCase createPatientUseCase;
  final GetPatientAppointmentUseCase getPatientAppointmentUseCase;
  final UpdatePatientProfileUsecase updatePatientProfileUsecase;
  final GetAppointmentRxUsecase getAppointmentRxUsecase;
  final GetDateAppointmentsUsecase getDateAppointmentsUsecase;

  AppointmentProvider({
    required this.getPatientsListUseCase,
    required this.createPatientUseCase,
    required this.getAppointmentsUsecase,
    required this.updateAppointmentUseCase,
    required this.createAppointmentUseCase,
    required this.updatePatientProfileUsecase,
    required this.getPatientAppointmentUseCase,
    required this.getAppointmentRxUsecase,
    required this.getDateAppointmentsUsecase,
  });

  final PagingController<int, Appointment> upcomingAppointmentController = PagingController(firstPageKey: 0);
  final PagingController<int, Appointment> previousAppointmentController = PagingController(firstPageKey: 0);

  final List<Appointment> previousAppointments = [];
  final List<Appointment> upcomingAppointments = [];
  final List<Appointment>? patientAppointments = [];
  final List<Patient> patientsList = [];

  String? _upcommingSearchKey;
  String? get upcommingSearchKey => _upcommingSearchKey;

  String? _previousSearchKey;
  String? get previousSearchKey => _previousSearchKey;

  RxModel? _appointmentRxInfo;
  RxModel? get appointmentRxInfo => _appointmentRxInfo;

  bool _usingDate = false;
  bool get usingDate => _usingDate;

  Patient? _selectedPatient;
  Patient? get selectedPatient => _selectedPatient;

  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;

  set upcommingSearchKey(String? value) {
    _upcommingSearchKey = value;
    notifyListeners();
  }

  set previousSearchKey(String? value) {
    _previousSearchKey = value;
    notifyListeners();
  }

  set selectedPatient(Patient? value) {
    _selectedPatient = value;
    notifyListeners();
  }

  set selectedDate(DateTime? value) {
    _selectedDate = value;
    notifyListeners();
  }

  bool hasMoreUpcomingAppointments = true;
  bool hasMorePreviuosAppointments = true;

  void updateSelectedPatientVitals(PatientVital patientVital) {
    _selectedPatient?.patientVitals = patientVital;
    notifyListeners();
  }

  Future<List<Appointment>> getPreviousAppointments(GetAppointmentParams params, {bool informListenersAtStart = true}) async {
    try {
      setLoading(true, informListeners: informListenersAtStart);
      final appointments = await getAppointmentsUsecase.execute(params);
      return appointments.first;
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<List<Appointment>> getUpcomingAppointments(GetAppointmentParams params, {bool informListenersAtStart = true}) async {
    try {
      setLoading(true, informListeners: informListenersAtStart);
      final appointments = await getAppointmentsUsecase.execute(params);
      return appointments.last;
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<List<Appointment>> getDatedAppointments(GetAppointmentParams params) async {
    try {
      final appointments = await getDateAppointmentsUsecase.execute(params);
      return appointments;
    } catch (e) {
      rethrow;
    }
  }

  void updateUsingDateStatus(bool isUsingDate) {
    _usingDate = isUsingDate;
    _selectedDate = null;
    notifyListeners();
  }

  Future<void> updateAppointment(Appointment appointment) async {
    try {
      setLoading(true);
      await updateAppointmentUseCase.execute(appointment);
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<List<Patient>> getPatients({required String doctorId, int? page, String? searchKey}) async {
    try {
      setLoading(true);
      final patients = await getPatientsListUseCase.execute(
        GetPatientParam(doctorId: doctorId, page: page, searchKey: searchKey),
      );

      return patients;
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<void> createPatient({required Patient patient}) async {
    try {
      setLoading(true);
      selectedPatient = await createPatientUseCase.execute(patient);
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<Appointment> createAppointment(Appointment appointmentModel) async {
    try {
      setLoading(true);
      return await createAppointmentUseCase.execute(appointmentModel);
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<void> getPatientAppointments({required String patientId}) async {
    try {
      setLoading(true);
      patientAppointments?.clear();
      List<Appointment>? appointments = await getPatientAppointmentUseCase.execute(patientId);
      if (appointments!.isNotEmpty) {
        patientAppointments?.addAll(appointments);
      }
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<void> updatePatientProfile({required Patient patient}) async {
    try {
      setLoading(true);
      await updatePatientProfileUsecase.execute(patient);
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<void> getAppointmentRx({required String? appointmentId}) async {
    try {
      setLoading(true);
      if (appointmentId != null) {
        _appointmentRxInfo = await getAppointmentRxUsecase.execute(appointmentId);
      } else {
        throw "Appointment Id Missing";
      }
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<void> fetchUpcomingAppointmentsWithPagination(int pageKey, String userId, List<String> clinicIds) async {
    try {
      final newItems = await getUpcomingAppointments(GetAppointmentParams(userId: userId, clinicIds: clinicIds, page: pageKey, dateTime: selectedDate), informListenersAtStart: false);
      final isLastPage = newItems.length < 10;
      if (isLastPage) {
        upcomingAppointmentController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        upcomingAppointmentController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      upcomingAppointmentController.error = error;
    }
  }

  Future<void> fetchPreviousAppointmentsWithPagination(int pageKey, String userId, List<String> clinicIds) async {
    try {
      final newItems = await getPreviousAppointments(
        GetAppointmentParams(userId: userId, clinicIds: clinicIds, page: pageKey, dateTime: selectedDate),
        informListenersAtStart: false,
      );
      final isLastPage = newItems.length < 10;
      if (isLastPage) {
        previousAppointmentController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        previousAppointmentController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      previousAppointmentController.error = error;
    }
  }
}
