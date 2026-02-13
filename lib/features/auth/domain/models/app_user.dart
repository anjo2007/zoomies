class AppUser {
  const AppUser({
    required this.uid,
    required this.username,
    required this.kibbleBalance,
    required this.tribe,
    required this.petName,
    required this.petAvatar,
  });

  final String uid;
  final String username;
  final int kibbleBalance;
  final String tribe;
  final String petName;
  final String petAvatar;
}
