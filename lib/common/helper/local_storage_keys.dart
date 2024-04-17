const kUserDataKeyName = "UserData";

enum LocalStorageKeys {
  accessToken,
  refreshToken,
}

extension LocalStorageKeysExtension on LocalStorageKeys {
  String get asString {
    switch (this) {
      case LocalStorageKeys.accessToken:
        return "accessToken";
      case LocalStorageKeys.refreshToken:
        return "refreshToken";
      default:
        return "";
    }
  }
}
