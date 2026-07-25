import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../database/db_helper.dart';

class SyncService {
  static const String b2AuthUrl = 'https://api.backblazeb2.com/b2api/v3/b2_authorize_account';
  static const String bucketName = 'UcuencaExamen';
  // WARNING: Use RESTRICTED key, never the master key in production client app
  static const String b2KeyId = String.fromEnvironment('B2_KEY_ID', defaultValue: 'NOT_SET');
  static const String b2AppKey = String.fromEnvironment('B2_APP_KEY', defaultValue: 'NOT_SET');

  static Future<void> checkForUpdates() async {
    if (b2KeyId == 'NOT_SET' || b2AppKey == 'NOT_SET') {
      print('B2 keys not set in environment. Skipping sync.');
      return;
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      int currentVersion = prefs.getInt('content_version') ?? 1;

      // 1. Authorize Account
      final basicAuth = 'Basic ${base64Encode(utf8.encode('$b2KeyId:$b2AppKey'))}';
      final authResponse = await http.get(
        Uri.parse(b2AuthUrl),
        headers: {'Authorization': basicAuth},
      ).timeout(const Duration(seconds: 15));

      if (authResponse.statusCode != 200) {
        print('B2 Auth failed: ${authResponse.body}');
        return;
      }

      final authData = jsonDecode(authResponse.body);
      final authToken = authData['authorizationToken'];
      final downloadUrl = authData['downloadUrl'];

      // 2. Fetch Manifest
      final manifestUrl = '$downloadUrl/file/$bucketName/manifest.json';
      final manifestResponse = await http.get(
        Uri.parse(manifestUrl),
        headers: {'Authorization': authToken},
      ).timeout(const Duration(seconds: 15));

      if (manifestResponse.statusCode != 200) {
        print('Manifest fetch failed: ${manifestResponse.body}');
        return;
      }

      final manifestData = jsonDecode(manifestResponse.body);
      int remoteVersion = manifestData['content_version'];

      if (remoteVersion > currentVersion) {
        String filePreguntas = manifestData['file_preguntas'];
        String fileTeoria = manifestData['file_teoria'];

        // 3. Download Files
        final pResponse = await http.get(
          Uri.parse('$downloadUrl/file/$bucketName/$filePreguntas'),
          headers: {'Authorization': authToken},
        );
        final tResponse = await http.get(
          Uri.parse('$downloadUrl/file/$bucketName/$fileTeoria'),
          headers: {'Authorization': authToken},
        );

        if (pResponse.statusCode == 200 && tResponse.statusCode == 200) {
          final dir = await getApplicationDocumentsDirectory();
          final fileP = File('${dir.path}/preguntas_update.json');
          final fileT = File('${dir.path}/teoria_update.json');
          
          await fileP.writeAsString(pResponse.body);
          await fileT.writeAsString(tResponse.body);

          await prefs.setBool('use_downloaded_content', true);
          await prefs.setString('downloaded_preguntas_path', fileP.path);
          await prefs.setString('downloaded_teoria_path', fileT.path);
          
          // Trigger migration
          await DBHelper().forzarActualizacionDeContenido();
          await prefs.setInt('content_version', remoteVersion);
        }
      }
    } catch (e) {
      print('Sync failed silently, working offline: $e');
    }
  }
}
