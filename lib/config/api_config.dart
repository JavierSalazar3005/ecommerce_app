class ApiConfig {
  /// ⚠️ AJUSTA esta URL a tu backend.
  /// En Android emulator, usa: http://10.0.2.2:PORT/api
  /// En web/escritorio, puedes usar https://localhost:PORT/api
  static const String baseUrl = "https://app-251027161509.azurewebsites.net/api";

  /// Timeout por defecto en milisegundos para requests.
  static const int defaultTimeoutMs = 15000;

  /// Construye la URL completa combinando la baseUrl con el path proporcionado
  static String url(String path) {
    if (path.startsWith('/')) {
      path = path.substring(1);
    }
    return '$baseUrl/$path'.replaceAll(RegExp(r'([^:])//+'), r'$1/');
  }
}
