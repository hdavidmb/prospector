import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:prospector/src/features/auth/data/helpers/sign_in_with_apple_helper.dart';
import 'package:prospector/src/features/auth/domain/auth_failure.dart';
import 'package:prospector/src/features/auth/domain/i_auth_repository.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class FirebaseAuthRepository implements IAuthRepository {
  final FirebaseAuth firebaseAuthInstance;
  final GoogleSignIn googleSignIn;
  final FacebookAuth facebookAuth;
  final SignInWithAppleHelper signInWithApple;

  FirebaseAuthRepository({
    @required this.firebaseAuthInstance,
    @required this.googleSignIn,
    @required this.facebookAuth,
    @required this.signInWithApple,
  })  : assert(firebaseAuthInstance != null),
        assert(facebookAuth != null),
        assert(signInWithApple != null),
        assert(googleSignIn != null);

  @override
  Stream<bool> get isUserAuthenticated =>
      firebaseAuthInstance.authStateChanges().map((User user) => user != null);

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
      {@required String email, @required String password}) async {
    try {
      await firebaseAuthInstance.createUserWithEmailAndPassword(
          email: email, password: password);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return manageFirebaseAuthExceptions(errorCode: e.code);
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      {@required String email, @required String password}) async {
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
              FacebookAuthProvider.credential(result.accessToken?.token);
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
          firebaseAuthInstance.signOut(),
        ],
      );

  Either<AuthFailure, Unit> manageFirebaseAuthExceptions(
      {@required String errorCode}) {
    switch (errorCode) {
      case 'email-already-in-use':
        return left(const AuthFailure.emailAlreadyInUse());
      case 'user-not-found':
      case 'wrong-password':
        return left(const AuthFailure.invalidEmailAndPasswordCombination());
      case 'account-exists-with-different-credential':
        return left(const AuthFailure.accountExistsWithDifferentCredential());
      case 'AuthorizationErrorCode.canceled':
        return left(const AuthFailure.cancelledByUser());
      case 'user-not-found-reset-password':
        return left(const AuthFailure.userNotFoundResetPassword());
      default:
        return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> resetPassword({String email}) async {
    try {
      await firebaseAuthInstance.sendPasswordResetEmail(email: email);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return manageFirebaseAuthExceptions(errorCode: '${e.code}-reset-password');
    }
  }
}
