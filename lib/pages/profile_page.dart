import 'package:flutter/material.dart';
import '../models/profile_data.dart';
import '../services/pref_service.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  final PrefService prefs;
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;

  const ProfilePage({
    super.key,
    required this.prefs,
    required this.isDark,
    required this.onThemeChanged,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileData _profile;

  @override
  void initState() {
    super.initState();
    _profile = widget.prefs.profile;
  }

  Future<void> _editProfile() async {
    final updated = await Navigator.of(context).push<ProfileData>(
      MaterialPageRoute(
        builder: (_) => EditProfilePage(initial: _profile),
      ),
    );

    if (updated != null) {
      await widget.prefs.saveProfile(updated);
      setState(() {
        _profile = updated;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kartu Profil Digital'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _editProfile,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: colors.primaryContainer,
                    child: Text(
                      _profile.name.isNotEmpty ? _profile.name[0] : '?',
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _profile.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(_profile.title),
                  const SizedBox(height: 12),
                  Text(
                    _profile.bio,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  SwitchListTile(
                    secondary: const Icon(Icons.dark_mode),
                    title: const Text('Mode Gelap'),
                    value: widget.isDark,
                    onChanged: widget.onThemeChanged,
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Text(
                      'Kartu ini sudah dibuka ${widget.prefs.openCount} kali',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}