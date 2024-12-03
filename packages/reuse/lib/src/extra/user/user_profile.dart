// lib/services/user_profile.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfileService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch the current user's profile data
  Future<Map<String, dynamic>?> fetchUserProfile() async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user == null) {
        throw Exception('No user logged in');
      }

      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();

      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>?;
      } else {
        throw Exception('User profile not found');
      }
    } catch (e) {
      // Handle errors here
      print('Error fetching user profile: $e');
      rethrow;
    }
  }

  // Update the current user's profile data
  Future<void> updateUserProfile(Map<String, dynamic> data) async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user == null) {
        throw Exception('No user logged in');
      }

      await _firestore.collection('users').doc(user.uid).update(data);
    } catch (e) {
      // Handle errors here
      print('Error updating user profile: $e');
      rethrow;
    }
  }

  // Delete the current user's profile data
  Future<void> deleteUserProfile() async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user == null) {
        throw Exception('No user logged in');
      }

      await _firestore.collection('users').doc(user.uid).delete();
    } catch (e) {
      // Handle errors here
      print('Error deleting user profile: $e');
      rethrow;
    }
  }
}
//Purpose: Manages user profile data and operations related to user accounts.
// Usage: Used to manage user profile information and related operations.
