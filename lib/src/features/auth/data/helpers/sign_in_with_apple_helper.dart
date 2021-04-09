import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:meta/meta.dart';

class SignInWithAppleHelper {
  Future<AuthorizationCredentialAppleID> getAppleIDCredential({@required List<AppleIDAuthorizationScopes> scopes}) {
    try {
      return SignInWithApple.getAppleIDCredential( //TODO test response on cancelled
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