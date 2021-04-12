import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SignInWithAppleHelper {
  Future<AuthorizationCredentialAppleID> getAppleIDCredential({required List<AppleIDAuthorizationScopes> scopes}) {
    try {
      return SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
    } on SignInWithAppleException catch (_) {
      rethrow;
    }
  }
}