class AuthUser {
  final String id;
  final String? name;
  final String? email;
  final String? avatarUrl;

  const AuthUser({
    required this.id,
    this.name,
    this.email,
    this.avatarUrl,
  });
}
