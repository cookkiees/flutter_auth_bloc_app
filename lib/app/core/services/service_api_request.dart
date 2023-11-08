abstract class ApiRequest<T> {
  String get path;
  String get method;
  Map<String, String>? get headers;
  Map<String, dynamic>? get params;
  T Function(Map<String, dynamic>) get decoder;
}
