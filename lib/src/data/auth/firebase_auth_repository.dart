import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:prospector/src/domain/auth/auth_failure.dart';
import 'package:prospector/src/domain/auth/i_auth_repository.dart';

class FirebaseAuthRepository implements IAuthRepository {
  final FirebaseAuth _firebaseAuthInstance;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthRepository(this._firebaseAuthInstance, this._googleSignIn)
      : assert(_firebaseAuthInstance != null, _googleSignIn != null);

  @override
  Stream<bool> get isUserAuthenticated => _firebaseAuthInstance.authStateChanges().map((user) => user != null);

  @override
  Future<Either<AuthFailure, Unit>> googleSignIn() {
    // TODO: implement googleSignIn
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
      {String email, String password}) async {
    try {
      await _firebaseAuthInstance.createUserWithEmailAndPassword(email: email, password: password);
      return right(unit); //TODO: return user entity
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
      {String email, String password}) async {
    // TODO: implement signInWithEmailAndPassword
    try {
      await _firebaseAuthInstance.signInWithEmailAndPassword(
              email: email,
              password:
                  password); // TODO: transform user credential to User Entity
      return right(unit); //TODO: return user entity
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        return left(const AuthFailure.invalidEmailAndPasswordCombination());
      } else {
        return left(const AuthFailure.serverError());
      }
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuthInstance.signOut();
  }
}
