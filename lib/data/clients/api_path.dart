class ApiPath {
  // static String get uri => "https://localhost:7160";
  // static String get uri => "http://192.168.100.12:5091";
  static String get uri => "http://192.168.1.115:5091";

  static String get ingredients => "/api/Ingredient/list";

  static String getUrl(String path) => "$uri$path";

  static Uri getUri({
    String? scheme = "http",
    String? host = "192.168.1.115",
    int? port = 5091,
    String? path,
    Map<String, dynamic>? queryParameters,
  }) {
    return Uri(
      scheme: scheme,
      host: host,
      port: port,
      path: path,
      queryParameters: queryParameters,
    );
  }
}
