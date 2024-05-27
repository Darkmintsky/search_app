import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final settingsProvider = StateNotifierProvider<UserSettingsNotifier, UserSettings>((ref) {
  return UserSettingsNotifier();
});

class UserSettings {
  String language;
  String theme;
  UserSettings({this.language = 'English', this.theme = 'Light'});
}

class UserSettingsNotifier extends StateNotifier<UserSettings> {
  UserSettingsNotifier() : super(UserSettings()) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final language = prefs.getString('language') ?? 'English';
    final theme = prefs.getString('theme') ?? 'Light';
    state = UserSettings(language: language, theme: theme);
  }

  Future<void> updateLanguage(String newLanguage) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', newLanguage);
    state = UserSettings(language: newLanguage, theme: state.theme);
  }
  
  Future<void> updateTheme(String newTheme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', newTheme);
    state = UserSettings(language: state.language, theme: newTheme);
  }
}