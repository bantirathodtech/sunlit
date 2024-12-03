// lib/services/authentication_service.dart

import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Stream to get the current user's authentication state
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Method to sign in with email and password
  Future<void> signInWithEmailPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // Handle errors here
      throw _handleAuthException(e);
    }
  }

  // Method to register a new user with email and password
  Future<void> registerWithEmailPassword(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // Handle errors here
      throw _handleAuthException(e);
    }
  }

  // Method to sign out the current user
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      // Handle errors here
      throw Exception('Sign out failed: $e');
    }
  }

  // Helper method to handle authentication exceptions
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'Invalid email address.';
      case 'user-disabled':
        return 'User has been disabled.';
      case 'user-not-found':
        return 'User not found.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'email-already-in-use':
        return 'Email is already in use.';
      default:
        return 'An unknown error occurred.';
    }
  }
}
//Purpose: Handles authentication-related logic, including login, registration, and user sessions.
// Usage: Used to manage user authentication and sessions.
