import 'package:flutter/material.dart';
import 'pages/profile_page.dart';
import 'services/pref_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await PrefService.init();
  debugPrint('Isi prefs: ${prefs.debugKeys}');
  await prefs.increaseOpenCount();

  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatefulWidget {
  final PrefService prefs;

  const MyApp({super.key, required this.prefs});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _isDark;

  @override
  void initState() {
    super.initState();
    // Ambil status tema yang tersimpan
    _isDark = widget.prefs.isDarkMode;
  }

  void _toggleTheme(bool value) async {
    await widget.prefs.setDarkMode(value);
    setState(() {
      _isDark = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kartu Profil Digital',
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: ProfilePage(
        prefs: widget.prefs,
        isDark: _isDark,
        onThemeChanged: _toggleTheme,
      ),
    );
  }
}