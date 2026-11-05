import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  final SharedPreferences _prefs;

  PrefService._(this._prefs);

  // Kunci penyimpanan
  static const _kOpenCount = 'open_count';
  static const _kDarkMode = 'is_dark_mode'; // Ditambahkan untuk tema

  /// Dipanggil sekali saat aplikasi mulai
  static Future<PrefService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return PrefService._(prefs);
  }

  // Penghitung buka aplikasi
  int get openCount => _prefs.getInt(_kOpenCount) ?? 0;
  Future<void> increaseOpenCount() =>
      _prefs.setInt(_kOpenCount, openCount + 1);

  // Pengaturan tema gelap
  bool get isDarkMode => _prefs.getBool(_kDarkMode) ?? false;
  Future<void> setDarkMode(bool value) => _prefs.setBool(_kDarkMode, value);
}