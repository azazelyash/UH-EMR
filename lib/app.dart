import 'utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common/helper/token_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/auth/domain/usecases/sign_in_usecase.dart';
import 'features/auth/domain/usecases/sign_up_usecase.dart';
import 'features/auth/domain/usecases/send_otp_usecase.dart';
import 'features/auth/domain/usecases/sign_out_usecase.dart';
import 'features/user/domain/usecases/get_user_usecase.dart';
import 'features/auth/presentations/screens/login_screen.dart';
import 'features/user/domain/usecases/get_clinics_usecase.dart';
import 'features/user/domain/usecases/get_clinics_usecase.dart';
import 'features/user/domain/usecases/update_user_usecase.dart';
import 'features/auth/data/repository/auth_repository_impl.dart';
import 'features/rx_screen/domain/repository/rx_repository.dart';
import 'features/user/data/repository/user_repository_impl.dart';
import 'features/user/presentation/providers/user_provider.dart';
import 'features/auth/presentations/providers/auth_provider.dart';
import 'features/user/domain/usecases/create_clinic_usecase.dart';
import 'features/user/domain/usecases/delete_clinic_usecase.dart';
import 'features/rx_screen/data/repository/rx_repositor_impl.dart';
import 'features/rx_screen/presentation/providers/rx_provider.dart';
import 'features/auth/data/data_source/auth_remote_data_source.dart';
import 'features/user/data/data_source/user_remote_data_source.dart';
import 'features/user/domain/usecases/get_receptionist_usecase.dart';
import 'features/auth/domain/usecases/check_auth_status_usecase.dart';
import 'features/user/domain/usecases/create_recptionist_usecase.dart';
import 'features/dashboard/domain/usecases/create_patient_usecase.dart';
import 'features/rx_screen/data/data_source/rx_remote_data_source.dart';
import 'features/user/domain/usecases/delete_receptionist_usecase.dart';
import 'features/user/domain/usecases/delete_receptionist_usecase.dart';
import 'features/user/domain/usecases/get_dropdown_values_usecase.dart';
import 'features/user/domain/usecases/check_if_user_exists_usecase.dart';
import 'features/dashboard/domain/repository/appointment_repository.dart';
import 'features/dashboard/domain/usecases/get_appointments_usecase.dart';
import 'features/dashboard/domain/usecases/get_patients_list_usecase.dart';
import 'features/dashboard/domain/usecases/create_appointment_usecase.dart';
import 'features/dashboard/domain/usecases/update_appointment_usecase.dart';
import 'features/dashboard/presentations/providers/dashboard_provider.dart';
import 'features/dashboard/presentations/screens/choose_clinic_screen.dart';
import 'features/settings/presentation/providers/header_info_provider.dart';
import 'features/dashboard/data/repository/appointment_repository_impl.dart';
import 'features/dashboard/presentations/providers/appointment_provider.dart';
import 'features/settings/presentation/providers/patient_vitals_provider.dart';
import 'package:aasa_emr/features/auth/domain/usecases/delete_user_usecase.dart';
import 'features/dashboard/data/data_source/appointment_remote_data_source.dart';
import 'package:aasa_emr/features/user/domain/usecases/update_clinic_usecase.dart';
import 'package:aasa_emr/features/rx_screen/domain/usecases/create_rx_usecase.dart';
import 'package:aasa_emr/features/settings/domain/usecase/update_user_usercase.dart';
import 'package:aasa_emr/features/user/data/data_source/user_local_data_source.dart';
import 'package:aasa_emr/features/settings/domain/repository/settings_repository.dart';
import 'package:aasa_emr/features/settings/domain/usecase/get_all_medicine_usecase.dart';
import 'package:aasa_emr/features/user/domain/usecases/update_receptionist_usecase.dart';
import 'package:aasa_emr/features/settings/data/repository/settings_repository_impl.dart';
import 'package:aasa_emr/features/settings/presentation/providers/medication_provider.dart';
import 'package:aasa_emr/features/dashboard/domain/usecases/get_appointment_rx_usecase.dart';
import 'package:aasa_emr/features/rx_screen/domain/usecases/send_rx_to_patient_usecase.dart';
import 'package:aasa_emr/features/settings/data/data_source/settings_remote_data_source.dart';
import 'package:aasa_emr/features/dashboard/domain/usecases/get_date_appointments_usecase.dart';
import 'package:aasa_emr/features/dashboard/domain/usecases/update_patient_profile_usecase.dart';
import 'package:aasa_emr/features/dashboard/domain/usecases/get_patient_appointment_usecase.dart';

class App extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  final SharedPreferences sharedPreferences;
  const App({super.key, required this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    final AuthRepositoryImpl authRepositoryImpl = AuthRepositoryImpl(
      authRemoteDataSource: AuthRemoteDataSource(),
      tokenManager: TokenManager(sharedPreferences: sharedPreferences),
    );
    final UserRepositoryImpl userRepositoryImpl = UserRepositoryImpl(
        tokenManager: TokenManager(sharedPreferences: sharedPreferences),
        userRemoteDataSource: UserRemoteDataSource(),
        userLocalDataSource: UserLocalDataSource(
          imagePicker: ImagePicker(),
        ));

    final AppointmentRepository appointmentRepository = AppointmentRepositoryImpl(
      tokenManager: TokenManager(sharedPreferences: sharedPreferences),
      appointmentRemoteDataSource: AppointmentRemoteDataSource(),
    );

    final RxRepository rxRepository = RxRepositoryImpl(
      tokenManager: TokenManager(sharedPreferences: sharedPreferences),
      rxRemoteDataSource: RxRemoteDataSource(),
    );

    final SettingsRepository settingsRepository = SettingsRepositoryImpl(
      tokenManager: TokenManager(sharedPreferences: sharedPreferences),
      settingsRemoteDataSource: SettingsRemoteDataSource(),
    );

    ScreenUtil.init(context);

    return ScreenUtilInit(
      designSize: const Size(390, 770),
      minTextAdapt: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthProvider>(
              create: (context) => AuthProvider(
                sendOtpUsecase: SendOtpUsecase(authRepository: authRepositoryImpl),
                signInUsecase: SignInUsecase(authRepository: authRepositoryImpl),
                signOutUsecase: SignOutUsecase(authRepository: authRepositoryImpl),
                checkAuthStatusUseCase: CheckAuthStatusUseCase(authRepository: authRepositoryImpl),
                signUpUsecase: SignUpUsecase(authRepository: authRepositoryImpl),
                deleteUserUsecase: DeleteUserUsecase(authRepository: authRepositoryImpl),
              )..checkAuthState(),
            ),
            ChangeNotifierProvider(
              create: (context) => UserProvider(
                getUserUseCase: GetUserUseCase(userRepository: userRepositoryImpl),
                updateUserUseCase: UpadateUseCase(userRepository: userRepositoryImpl),
                getClinicsUseCase: GetClinicsUseCase(userRepository: userRepositoryImpl),
                createClinicUseCase: CreateClinicUseCase(userRepository: userRepositoryImpl),
                updateClinicUseCase: UpdateClinicUseCase(userRepository: userRepositoryImpl),
                deleteClinicUseCase: DeleteClinicUseCase(userRepository: userRepositoryImpl),
                getReceptionistUsecase: GetReceptionistUsecase(userRepository: userRepositoryImpl),
                getDropdownValuesUsecase: GetDropdownValuesUsecase(userRepository: userRepositoryImpl),
                createReceptionistUsecase: CreateReceptionistUsecase(userRepository: userRepositoryImpl),
                updateReceptionistUsecase: UpdateReceptionistUsecase(userRepository: userRepositoryImpl),
                deleteReceptionistUsecase: DeleteReceptionistUsecase(userRepository: userRepositoryImpl),
                checkIfUserExistsUseCase: CheckIfUserExistsUseCase(userRepository: userRepositoryImpl),
              )..getUser(),
            ),
            ChangeNotifierProvider(
              create: (context) => AppointmentProvider(
                getAppointmentsUsecase: GetAppointmensUseCase(appointmentRepository: appointmentRepository),
                updateAppointmentUseCase: UpdateAppointmentUseCase(appointmentRepository: appointmentRepository),
                getPatientsListUseCase: GetPatientsListUseCase(appointmentRepository: appointmentRepository),
                createAppointmentUseCase: CreateAppointmentUseCase(appointmentRepository: appointmentRepository),
                createPatientUseCase: CreatePatientUseCase(appointmentRepository: appointmentRepository),
                getPatientAppointmentUseCase: GetPatientAppointmentUseCase(appointmentRepository: appointmentRepository),
                updatePatientProfileUsecase: UpdatePatientProfileUsecase(appointmentRepository: appointmentRepository),
                getAppointmentRxUsecase: GetAppointmentRxUsecase(appointmentRepository: appointmentRepository),
                getDateAppointmentsUsecase: GetDateAppointmentsUsecase(appointmentRepository: appointmentRepository),
              ),
            ),
            ChangeNotifierProvider<DashboardProvider>(
              create: (context) => DashboardProvider(),
            ),
            ChangeNotifierProvider<RxProvider>(
              create: (context) => RxProvider(
                createRxUseCase: CreateRxUseCase(rxRepository: rxRepository),
                sendRxToPatientUsecase: SendRxToPatientUsecase(rxRepository: rxRepository),
              ),
            ),
            ChangeNotifierProvider(
              create: (context) => PatientVitalsProvider(user: context.read<UserProvider>().user)..initializeVitals(),
            ),
            ChangeNotifierProvider(
              create: (context) => HeaderInfoProvider(user: context.read<UserProvider>().user)..initializeHeaderInfo(),
            ),
            ChangeNotifierProvider(
              create: (context) => MedicationProvider(
                updateUserUseCase: UpdateUserUseCase(settingsRepository: settingsRepository),
                getAllMedicineUseCase: GetAllMedicineUseCase(settingsRepository: settingsRepository),
              ),
            ),
          ],
          child: child,
        );
      },
      child: Consumer<AuthProvider>(
        builder: (context, value, child) => MaterialApp(
          navigatorObservers: <NavigatorObserver>[observer],
          home: value.isAuthenticated ? const ChooseClinicScreen() : const LoginScreen(),
          themeMode: ThemeMode.light,
          theme: TAppTheme.lightTheme,
          darkTheme: TAppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
