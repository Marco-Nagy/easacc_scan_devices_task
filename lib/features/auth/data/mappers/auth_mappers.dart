import 'package:easacc_scan_devices_task/features/auth/data/models/auth_user_response.dart';
import 'package:easacc_scan_devices_task/features/auth/domain/entities/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMappers {
 static AuthUserResponse mapGoogleUserToDomain(GoogleSignInAccount googleUser) {
    return AuthUserResponse(
      id: googleUser.id,
      name: googleUser.displayName,
      email: googleUser.email,
      avatarUrl: googleUser.photoUrl,
    );
  }
  static AuthUserResponse mapGmailUserToDomain(UserCredential googleUser) {
   debugPrint(' User logged ${
   '${googleUser.user!.uid} ${googleUser.user!.displayName!}\n ${googleUser.user!.email} \n${googleUser.user!.photoURL!}'
   }');
    return AuthUserResponse(
      id: googleUser.user!.uid,
      name: googleUser.user!.displayName,
      email: googleUser.user!.email,
      avatarUrl: googleUser.user!.photoURL,
    );
  }
  static AuthUserResponse mapFacebookUserToDomain(Map<String, dynamic> data) {
    return AuthUserResponse(
      id: data['id']?.toString() ?? '',
      name: data['name'] as String?,
      email: data['email'] as String?,
      avatarUrl: (data['picture']?['data']?['url']) as String?,
    );
  }

}


extension AuthUserResponseMapper on AuthUserResponse {
  AuthUser toDomain() {
    return AuthUser(
      id: id,
      name: name,
      email: email,
      avatarUrl: avatarUrl,
    );
  }
}
