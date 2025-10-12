import 'package:desafio_loomi/data/model/user_model.dart';
import 'package:desafio_loomi/data/repository/firebase_repository.dart';
import 'package:desafio_loomi/data/services/firebase_service.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final FirebaseService _firebaseService;

  FirebaseRepositoryImpl(this._firebaseService);

  @override
  Future<UserModel> signInWithEmail(String email, String password) {
    return _firebaseService.signInWithEmail(email, password);
  }

  @override
  Future<UserModel> signUpWithEmail(
    String email,
    String password,
    String userName,
  ) {
    return _firebaseService.signUpWithEmail(email, password, userName);
  }

  @override
  Future<UserModel> signInWithGoogle() {
    return _firebaseService.signInWithGoogle();
  }

  @override
  Future<UserModel> signInWithApple() {
    return _firebaseService.signInWithApple();
  }

  @override
  Future<void> signOut() {
    return _firebaseService.signOut();
  }

  @override
  Future<UserModel?> getCurrentUser() {
    return _firebaseService.getCurrentUser();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) {
    return _firebaseService.sendPasswordResetEmail(email);
  }

  @override
  Future<void> updateUser({required String username}) {
    return _firebaseService.updateUser(username: username);
  }

  @override
  Future<void> completeOnboarding() {
    return _firebaseService.completeOnboarding();
  }

  @override
  Future<void> changePassword(String currentPassword, String newPassword) {
    return _firebaseService.changePassword(currentPassword, newPassword);
  }

  @override
  Future<void> deleteAccount() {
    return _firebaseService.deleteAccount();
  }
}
