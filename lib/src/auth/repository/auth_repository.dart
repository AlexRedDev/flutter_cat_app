import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _authFirebase = FirebaseAuth.instance;
  final FacebookAuth _authFacebook = FacebookAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User> signInWithGoogle() async {
    try {
      final googleSignInAccount = await _googleSignIn.signIn();

      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      UserCredential userCredentials =
          await _authFirebase.signInWithCredential(credential);

      final user = userCredentials.user;
      if (user == null) {
        throw Exception('User error google');
      } else {
        return user;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<User> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await _authFacebook.login();
      final facebookAuthCredentials =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      UserCredential userCredential =
          await _authFirebase.signInWithCredential(facebookAuthCredentials);
          
      final user = userCredential.user;
      if (user == null) {
        throw Exception('User error facebook');
      } else {
        return user;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<User> signInWithCredentials({
    required String email,
    required String password,
  }) async {
    await _authFirebase.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = _authFirebase.currentUser;
    if (user == null) {
      throw Exception('Error with Credentials login');
    } else {
      return user;
    }
  }

  Future<User> signUp({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user == null) {
        throw Exception('User error SignUp');
      } else {
        return user;
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> signOut() async {
    _authFirebase.signOut();
    _googleSignIn.signOut();
  }

  bool isAuthenticated() {
    return FirebaseAuth.instance.currentUser != null ? true : false;
  }

  User getUser() {
    return _authFirebase.currentUser!;
  }
}
