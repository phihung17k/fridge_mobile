class ApiPath {
  // static String get uri => "https://localhost:7160";
  static String get uri => "https://10.0.2.2:7160";

  static String get ingredients => "/api/Ingredient/list";

  static String getUrl(String path) => "$uri$path";
}
