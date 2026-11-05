import 'dart:convert';

class ProfileData {
  final String name;
  final String title;
  final String bio;

  const ProfileData({
    required this.name,
    required this.title,
    required this.bio,
  });

  static const defaults = ProfileData(
    name: 'Fakhry Firdaus',
    title: 'Software Engineer & Dosen',
    bio: 'Suka membangun aplikasi mobile dan berbagi ilmu.',
  );

  // Konversi dari Object ke Map
  Map<String, dynamic> toMap() => {
        'name': name,
        'title': title,
        'bio': bio,
      };

  // Konversi dari Map ke Object
  factory ProfileData.fromMap(Map<String, dynamic> map) => ProfileData(
        name: map['name'] as String? ?? defaults.name,
        title: map['title'] as String? ?? defaults.title,
        bio: map['bio'] as String? ?? defaults.bio,
      );

  // Konversi ke string JSON
  String toJson() => jsonEncode(toMap());

  // Konversi dari string JSON kembali ke Object
  factory ProfileData.fromJson(String source) =>
      ProfileData.fromMap(jsonDecode(source) as Map<String, dynamic>);
}