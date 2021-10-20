import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late User? user;

  Future<void> signInWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

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

  Future<void> signOut() async {}
}
