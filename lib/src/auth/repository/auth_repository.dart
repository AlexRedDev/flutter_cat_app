import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late User? user;

  Future<void> signInWithGoogle() async {
    try {
      final googleSignInAccount = await _googleSignIn.signIn();

      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      UserCredential userCredentials =
          await _auth.signInWithCredential(credential);

      user = userCredentials.user;
      if (user != null) {
        print(user!.displayName);
        print(user!.email);
        print(user!.photoURL);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signInWithFaceBook() async {}

  Future<User?> signInWithCredentials({
    required String email,
    required String password,
  }) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = _auth.currentUser;
    return user;
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    print(userCredential.credential);
  }

  Future<void> signOut() async {
    _auth.signOut();
    _googleSignIn.signOut();
  }

  bool isAuthenticated() {
    return FirebaseAuth.instance.currentUser != null ? true : false;
  }
}
