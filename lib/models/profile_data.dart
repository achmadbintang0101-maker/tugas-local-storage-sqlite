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
    name: 'Achmad Bintang Dwi P',
    title: 'Bismillah fullstack soon',
    bio: 'Suka membangun aplikasi mobile dan berbagi ilmu.',
  );
}