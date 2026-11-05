import 'package:flutter/material.dart';
import 'pages/profile_page.dart';
import 'services/pref_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await PrefService.init();
  await prefs.increaseOpenCount();

  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final PrefService prefs;

  const MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kartu Profil Digital',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ProfilePage(prefs: prefs),
    );
  }
}