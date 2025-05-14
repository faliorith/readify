import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserModel?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        return UserModel.fromFirestore(doc);
      }
    }
    return null;
  }

  Future<UserModel> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user!;
      final userModel = UserModel(
        id: user.uid,
        email: email,
        name: name,
      );

      await _firestore.collection('users').doc(user.uid).set(userModel.toMap());
      return userModel;
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final doc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      return UserModel.fromFirestore(doc);
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> updateProfile({
    required String userId,
    String? name,
    String? photoUrl,
  }) async {
    final updates = <String, dynamic>{};
    if (name != null) updates['name'] = name;
    if (photoUrl != null) updates['photoUrl'] = photoUrl;

    await _firestore.collection('users').doc(userId).update(updates);
  }

  Exception _handleAuthError(dynamic e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'weak-password':
          return Exception('The password provided is too weak.');
        case 'email-already-in-use':
          return Exception('The account already exists for that email.');
        case 'user-not-found':
          return Exception('No user found for that email.');
        case 'wrong-password':
          return Exception('Wrong password provided.');
        default:
          return Exception(e.message ?? 'An unknown error occurred.');
      }
    }
    return Exception('An unknown error occurred.');
  }
} 