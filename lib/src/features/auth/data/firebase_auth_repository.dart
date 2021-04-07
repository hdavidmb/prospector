import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:prospector/src/features/auth/domain/auth_failure.dart';
import 'package:prospector/src/features/auth/domain/i_auth_repository.dart';

class FirebaseAuthRepository implements IAuthRepository {
  final FirebaseAuth firebaseAuthInstance;
  final GoogleSignIn googleSignIn;
  final FacebookAuth facebookAuth;

  FirebaseAuthRepository(
      {@required this.firebaseAuthInstance,
      @required this.googleSignIn,
      @required this.facebookAuth})
      : assert(firebaseAuthInstance != null),
        assert(facebookAuth != null),
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
  Future<Either<AuthFailure, Unit>> signInWithApple() {
    // TODO: implement signInWithApple
    return null;
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
  Future<void> signOut() => Future.wait(
        [
          googleSignIn.signOut(),
          firebaseAuthInstance.signOut(),
        ],
      );

  Either<AuthFailure, Unit> manageFirebaseAuthExceptions({@required String errorCode}) {
    switch (errorCode) {
      case 'email-already-in-use':
        return left(const AuthFailure.emailAlreadyInUse());
      case 'user-not-found':
      case 'wrong-password':
        return left(const AuthFailure.invalidEmailAndPasswordCombination());
      case 'account-exists-with-different-credential':
        return left(const AuthFailure.accountExistsWithDifferentCredential());
      default:
        return left(const AuthFailure.serverError());
    }
  }
}
