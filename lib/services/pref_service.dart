import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  final SharedPreferences _prefs;

  PrefService._(this._prefs);

  // Kunci penyimpanan untuk counter
  static const _kOpenCount = 'open_count';

  /// Dipanggil sekali saat aplikasi mulai
  static Future<PrefService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return PrefService._(prefs);
  }

  // Getter untuk mengambil jumlah buka aplikasi (default 0 jika belum ada)
  int get openCount => _prefs.getInt(_kOpenCount) ?? 0;

  // Fungsi untuk menambah hitungan buka aplikasi
  Future<void> increaseOpenCount() =>
      _prefs.setInt(_kOpenCount, openCount + 1);
}