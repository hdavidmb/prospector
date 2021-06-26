import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../core/auth/auth_helpers.dart';
import '../domain/auth_failure.dart';
import '../domain/i_auth_repository.dart';
import 'helpers/sign_in_with_apple_helper.dart';

class FirebaseAuthRepository implements IAuthRepository {
  final FirebaseAuth firebaseAuthInstance;
  final GoogleSignIn googleSignIn;
  final FacebookAuth facebookAuth;
  final SignInWithAppleHelper signInWithApple;

  FirebaseAuthRepository({
    required this.firebaseAuthInstance,
    required this.googleSignIn,
    required this.facebookAuth,
    required this.signInWithApple,
  });

  @override
  Stream<bool> get isUserAuthenticated =>
      firebaseAuthInstance.authStateChanges().map((User? user) =>
          user !=
          null); //TODO try .userChanges() to be able to upgrade firebase_auth to 1.1.2

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
      {required String email,
      required String password,
      required String displayName}) async {
    try {
      await firebaseAuthInstance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((credential) async =>
              await credential.user?.updateProfile(displayName: displayName));

      return right(unit);
    } on FirebaseAuthException catch (e) {
      return manageFirebaseAuthExceptions(errorCode: e.code);
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await firebaseAuthInstance.signInWithEmailAndPassword(
          email: email, password: password);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return manageFirebaseAuthExceptions(errorCode: e.code);
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return left(const AuthFailure.cancelledByUser());
      }

      final GoogleSignInAuthentication googleAuthentication =
          await googleUser.authentication;

      final OAuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleAuthentication.idToken,
        accessToken: googleAuthentication.accessToken,
      );

      await firebaseAuthInstance.signInWithCredential(authCredential);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return manageFirebaseAuthExceptions(errorCode: e.code);
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithFacebook() async {
    try {
      final LoginResult result = await facebookAuth.login();
      switch (result.status) {
        case LoginStatus.cancelled:
          return left(const AuthFailure.cancelledByUser());
        case LoginStatus.success:
          final OAuthCredential credential =
              FacebookAuthProvider.credential(result.accessToken!.token);
          await firebaseAuthInstance.signInWithCredential(credential);
          return right(unit);
        default:
          return left(const AuthFailure.serverError());
      }
    } on FirebaseAuthException catch (e) {
      return manageFirebaseAuthExceptions(errorCode: e.code);
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> appleSignIn() async {
    try {
      final AuthorizationCredentialAppleID result =
          await signInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final OAuthProvider appleAuthProvider = OAuthProvider("apple.com");
      final OAuthCredential credential = appleAuthProvider.credential(
        idToken: result.identityToken,
        accessToken: result.authorizationCode,
      );
      await firebaseAuthInstance.signInWithCredential(credential);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return manageFirebaseAuthExceptions(errorCode: e.code);
    } on SignInWithAppleAuthorizationException catch (e) {
      return manageFirebaseAuthExceptions(errorCode: e.code.toString());
    } catch (_) {
      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<void> signOut() => Future.wait(
        [
          googleSignIn.signOut(),
          facebookAuth.logOut(),
          firebaseAuthInstance.signOut(),
        ],
      );

  @override
  Future<Either<AuthFailure, Unit>> resetPassword(
      {required String email}) async {
    try {
      await firebaseAuthInstance.sendPasswordResetEmail(email: email);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return manageFirebaseAuthExceptions(
          errorCode: '${e.code}-reset-password');
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> reloginUser(
      {required String provider, String? password}) async {
    try {
      final AuthCredential credential;
      switch (provider) {
        case 'password':
          final userEmail = firebaseAuthInstance.currentUser!.email;
          credential = EmailAuthProvider.credential(
              email: userEmail!, password: password!);
          break;
        case 'google.com':
          final googleUser = await googleSignIn.signIn();
          if (googleUser == null) {
            return left(const AuthFailure.cancelledByUser());
          }

          final GoogleSignInAuthentication googleAuthentication =
              await googleUser.authentication;

          credential = GoogleAuthProvider.credential(
            idToken: googleAuthentication.idToken,
            accessToken: googleAuthentication.accessToken,
          );
          break;
        case 'facebook.com':
          final LoginResult result = await facebookAuth.login();
          switch (result.status) {
            case LoginStatus.cancelled:
              return left(const AuthFailure.cancelledByUser());
            case LoginStatus.success:
              credential =
                  FacebookAuthProvider.credential(result.accessToken!.token);
              break;
            default:
              return left(const AuthFailure.serverError());
          }
          break;
        case 'apple.com':
          final AuthorizationCredentialAppleID result =
              await signInWithApple.getAppleIDCredential(
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
          );
          final OAuthProvider appleAuthProvider = OAuthProvider("apple.com");
          credential = appleAuthProvider.credential(
            idToken: result.identityToken,
            accessToken: result.authorizationCode,
          );
          break;
        default:
          credential = EmailAuthProvider.credential(email: '', password: '');
          break;
      }
      await firebaseAuthInstance.currentUser!
          .reauthenticateWithCredential(credential);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return manageFirebaseAuthExceptions(errorCode: e.code);
    }
  }
}
