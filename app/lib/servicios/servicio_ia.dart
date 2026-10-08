// URL del servidor de análisis. Por defecto es 10.0.2.2, que es la dirección
// con la que el emulador de Android llega al PC donde corre el servidor.
// Para un teléfono físico o un servidor en la nube se cambia al compilar:
//   flutter run --dart-define=API_URL=http://192.168.1.X:8000
//   flutter build apk --release --dart-define=API_URL=https://mi-servidor.com
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../modelos/resultado_analisis.dart';

class ServicioIA {
  static const String _baseUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'http://10.0.2.2:8000',
  );

  static Future<ResultadoAnalisis> analizarVideo({
    required File video,
    required String ejercicio,
  }) async {
    final uri = Uri.parse('$_baseUrl/analizar');

    final request = http.MultipartRequest('POST', uri);
    request.fields['ejercicio'] = ejercicio;
    request.files.add(await http.MultipartFile.fromPath('video', video.path));

    final response = await request.send();
    final body = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      return ResultadoAnalisis.fromJson(jsonDecode(body));
    } else {
      throw Exception('Error del servidor: ${response.statusCode}');
    }
  }
}