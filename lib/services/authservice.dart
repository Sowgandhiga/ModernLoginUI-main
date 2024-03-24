import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  signInGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? gAuth = await gUser!.authentication;
    final cred = GoogleAuthProvider.credential(
        accessToken: gAuth!.accessToken, idToken: gAuth.idToken);
    return await FirebaseAuth.instance.signInWithCredential(cred);
  }
}
