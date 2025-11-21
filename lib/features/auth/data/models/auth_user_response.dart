import 'package:json_annotation/json_annotation.dart';

part 'auth_user_response.g.dart';

@JsonSerializable()
class AuthUserResponse {
  final String id;
  final String? name;
  final String? email;
  final String? avatarUrl;

  const AuthUserResponse({
    required this.id,
    this.name,
    this.email,
    this.avatarUrl,
  });

  factory AuthUserResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthUserResponseToJson(this);
}
