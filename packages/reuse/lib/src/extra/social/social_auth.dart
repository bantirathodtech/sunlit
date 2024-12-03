// // lib/common/social_auth.dart
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
//
// // Singleton for social authentication
// class SocialAuth {
//   // FirebaseAuth instance
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   // Google Sign-In instance
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//
//   // Facebook Sign-In instance
//   final FacebookAuth _facebookAuth = FacebookAuth.instance;
//
//   // Sign in with Google
//   Future<User?> signInWithGoogle() async {
//     try {
//       // Trigger the Google authentication flow
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) return null; // User canceled the sign-in
//
//       // Obtain the auth details from the request
//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//
//       // Create a new credential
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//
//       // Sign in with the credential
//       final UserCredential userCredential = await _auth.signInWithCredential(credential);
//       return userCredential.user;
//     } catch (e) {
//       print('Error signing in with Google: $e');
//       return null;
//     }
//   }
//
//   // Sign in with Facebook
//   Future<User?> signInWithFacebook() async {
//     try {
//       // Trigger the Facebook authentication flow
//       final LoginResult result = await _facebookAuth.login();
//
//       if (result.status != LoginStatus.success) return null; // User canceled the sign-in
//
//       // Create a new credential
//       final credential = FacebookAuthProvider.credential(result.accessToken!.token);
//
//       // Sign in with the credential
//       final UserCredential userCredential = await _auth.signInWithCredential(credential);
//       return userCredential.user;
//     } catch (e) {
//       print('Error signing in with Facebook: $e');
//       return null;
//     }
//   }
//
//   // Sign out
//   Future<void> signOut() async {
//     try {
//       await _auth.signOut();
//       await _googleSignIn.signOut();
//       await _facebookAuth.logOut();
//     } catch (e) {
//       print('Error signing out: $e');
//     }
//   }
//
//   // Check if user is signed in
//   User? get currentUser => _auth.currentUser;
// }
//Purpose: Manages social authentication integrations, such as Google and Facebook logins.
// Usage: Used to integrate and manage social authentication providers.
