import '../../../../common/helper/token_manager.dart';

class AuthLocalDataSource {
  final TokenManager tokenManager;

  AuthLocalDataSource({required this.tokenManager});
  // final SharedPreferences sharedPreferences;

  // Future<bool> saveAccessToken({required String token}) async {
  //   try {
  //     return await sharedPreferences.setString(LocalStorageKeys.accessToken.asString, token);
  //   } catch (error) {
  //     log(error.toString());
  //     return false;
  //   }
  // }

  // Future<bool> saveRefreshToken({required String token}) async {
  //   try {
  //     return await sharedPreferences.setString(LocalStorageKeys.refreshToken.asString, token);
  //   } catch (error) {
  //     log(error.toString());
  //     return false;
  //   }
  // }

  // Future<bool> clearUserData() async {
  //   try {
  //     return await sharedPreferences.clear();
  //   } catch (error) {
  //     log(error.toString());
  //     return false;
  //   }
  // }

  // Future<String?> getAccessToken() async {
  //   try {
  //     final token = sharedPreferences.getString(LocalStorageKeys.accessToken.asString);
  //     if (token != null) {
  //       final DateTime expiryTime = getTokenExpiryTime(token);
  //       if (expiryTime.isAfter(DateTime.now())) {
  //         log("Token is valid");
  //         return token;
  //       } else {
  //         final refreshTok = await getRefreshToken();
  //         if (refreshTok != null) {
  //           final newToken = await refreshToken(refreshTok);
  //           await saveAccessToken(token: newToken);
  //           return newToken;
  //         } else {
  //           throw "Auth error: Please try relogin";
  //         }
  //       }
  //     }
  //     return null;
  //   } catch (error) {
  //     log(error.toString());
  //     return null;
  //   }
  // }

  // Future<String?> getRefreshToken() async {
  //   try {
  //     return sharedPreferences.getString(LocalStorageKeys.refreshToken.asString);
  //   } catch (error) {
  //     log(error.toString());
  //     return null;
  //   }
  // }

  // DateTime getTokenExpiryTime(String token) {
  //   final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
  //   final int expiryTimeInSeconds = decodedToken['exp'];
  //   final DateTime expiryTime = DateTime.fromMillisecondsSinceEpoch(expiryTimeInSeconds * 1000).toLocal();
  //   return expiryTime;
  // }

  // Future<String> refreshToken(String refreshToken) async {
  //   // ApiService apiService = ApiService(dio: Dio());

  //   try {
  //     final response = await HttpService.post(
  //       EndPoints.refreshTokenUrl,
  //       headers: {
  //         "Content-Type": "application/json",
  //       },
  //       body: json.encode({"token": refreshToken}),
  //     );

  //     final decodedJson = response;
  //     final accessToken = decodedJson['data']['accessToken'];
  //     return accessToken;
  //   } catch (e) {
  //     log(e.toString());
  //     rethrow;
  //   }
  // }
}
