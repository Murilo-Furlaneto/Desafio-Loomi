import 'package:desafio_loomi/data/model/user_model.dart';
import 'package:desafio_loomi/data/services/api_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final ApiService _apiService = ApiService();

  Future<UserModel> signInWithEmail(String email, String password) async {
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return _userFromFirebase(result.user!);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<UserModel> signUpWithEmail(
    String email,
    String password,
    String userName,
  ) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _apiService.registerUser(
        username: userName,
        email: email,
        password: password,
        firebaseUid: result.user!.uid,
      );

      return _userFromFirebase(result.user!);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<UserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) throw Exception('Google sign in aborted');

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential result = await _auth.signInWithCredential(
        credential,
      );

      await _apiService.registerUser(
        username: result.user?.displayName ?? '',
        email: result.user?.email ?? '',
        password: '',
        firebaseUid: result.user!.uid,
      );

      return await _apiService.getUserData();
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<UserModel> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final UserCredential result = await _auth.signInWithCredential(
        oauthCredential,
      );

      await _apiService.registerUser(
        username:
            '${appleCredential.givenName ?? ''} ${appleCredential.familyName ?? ''}',
        email: appleCredential.email ?? '',
        password: '',
        firebaseUid: result.user!.uid,
      );

      return await _apiService.getUserData();
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> signOut() async {
    await Future.wait([_auth.signOut(), _googleSignIn.signOut()]);
  }

  Future<UserModel?> getCurrentUser() async {
    final user = _auth.currentUser;
    return user != null ? _userFromFirebase(user) : null;
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw _handleError(e);
    }
  }

  UserModel _userFromFirebase(User user) {
    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
      photoUrl: user.photoURL,
    );
  }

  Future<void> updateUser({required String username}) {
    return _apiService.updateUser(username: username);
  }

  Future<void> completeOnboarding() {
    return _apiService.updateOnboarding();
  }

  Future<void> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not logged in.');
    }

    final credential = EmailAuthProvider.credential(
      email: user.email!,
      password: currentPassword,
    );

    try {
      await user.reauthenticateWithCredential(credential);

      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password' || e.code == 'user-mismatch') {
        throw Exception('The current password entered is incorrect.');
      }
      throw _handleError(e);
    } catch (e) {
      throw Exception('Failed to change password: ${e.toString()}');
    }
  }

  Future<void> deleteAccount() async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('No user logged in');

    try {
      await user.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        throw Exception(
          'You need to re-authenticate before deleting your account.',
        );
      } else {
        throw _handleError(e);
      }
    }
  }

  Exception _handleError(dynamic e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'user-not-found':
          return Exception('No user found with this email.');
        case 'wrong-password':
          return Exception('Wrong password provided.');
        case 'email-already-in-use':
          return Exception('Email is already in use.');
        default:
          return Exception(e.message ?? 'Authentication failed.');
      }
    }
    return Exception('An unexpected error occurred.');
  }
}
