// preferences_manager.dart
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class PreferencesManager {
  static Future<Directory> _getLocalDirectory() async {
    return await getApplicationDocumentsDirectory();
  }

  static Future<File> _getPreferencesFile() async {
    final dir = await _getLocalDirectory();
    return File('${dir.path}/preferences.json');
  }

  static Future<void> setHasSeenOnboarding(bool seen) async {
    final file = await _getPreferencesFile();
    final Map<String, dynamic> prefs = {'hasSeenOnboarding': seen};
    await file.writeAsString(jsonEncode(prefs));
  }

  static Future<bool> getHasSeenOnboarding() async {
    final file = await _getPreferencesFile();
    if (await file.exists()) {
      final contents = await file.readAsString();
      final Map<String, dynamic> prefs = jsonDecode(contents);
      return prefs['hasSeenOnboarding'] ?? false;
    } else {
      return false;
    }
  }
}
