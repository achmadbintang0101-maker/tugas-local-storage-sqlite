import 'package:shared_preferences/shared_preferences.dart';
import '../models/profile_data.dart';

class PrefService {
  final SharedPreferences _prefs;

  PrefService._(this._prefs);

  static const _kOpenCount = 'open_count';
  static const _kDarkMode = 'is_dark_mode';
  static const _kProfile = 'profile_data'; // Ditambahkan untuk data profil

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

  // Mengambil data profil tersimpan (jika kosong/rusak, kembali ke defaults)
  ProfileData get profile {
    final raw = _prefs.getString(_kProfile);
    if (raw == null) return ProfileData.defaults;
    try {
      return ProfileData.fromJson(raw);
    } catch (_) {
      return ProfileData.defaults;
    }
  }

  // Menyimpan profil ke SharedPreferences dalam bentuk JSON
  Future<void> saveProfile(ProfileData profile) =>
      _prefs.setString(_kProfile, profile.toJson());

  // Menghapus data profil
  Future<void> clearProfile() => _prefs.remove(_kProfile);
}