import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:prospector/src/domain/auth/auth_failure.dart';
import 'package:prospector/src/domain/auth/i_auth_repository.dart';

class FirebaseAuthRepository implements IAuthRepository {
  final FirebaseAuth _firebaseAuthInstance;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthRepository(this._firebaseAuthInstance, this._googleSignIn)
      : assert(_firebaseAuthInstance != null, _googleSignIn != null);

  @override
  Stream<bool> get isUserAuthenticated =>
      _firebaseAuthInstance.authStateChanges().map((User user) => user != null);

  @override
  Future<Either<AuthFailure, Unit>> googleSignIn() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return left(const AuthFailure.cancelledByUser());
      }

      final googleAuthentication = await googleUser.authentication;

      final authCredential = GoogleAuthProvider.credential(
        idToken: googleAuthentication.idToken,
        accessToken: googleAuthentication.accessToken,
      );

      await _firebaseAuthInstance.signInWithCredential(authCredential);
      return right(unit);
    } on FirebaseAuthException catch (_) {
      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
      {@required String email, @required String password}) async {
    try {
      await _firebaseAuthInstance.createUserWithEmailAndPassword(
          email: email, password: password);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return left(const AuthFailure.emailAlreadyInUse());
      } else {
        return left(const AuthFailure.serverError());
      } // TODO: implement week password failure
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      {@required String email, @required String password}) async {
    try {
      await _firebaseAuthInstance.signInWithEmailAndPassword(
          email: email,
          password: password);
      return right(unit); 
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        return left(const AuthFailure.invalidEmailAndPasswordCombination());
      } else {
        return left(const AuthFailure.serverError());
      }
    }
  }

  @override
  Future<void> signOut() => Future.wait([
    _googleSignIn.signOut(),
    _firebaseAuthInstance.signOut(),
  ]);
}
