
import 'package:desafio_loomi/data/model/user_model.dart';

abstract class FirebaseRepository {
  Future<UserModel> signInWithEmail(String email, String password);
  Future<UserModel> signUpWithEmail(String email, String password, String userName);
  Future<UserModel> signInWithGoogle();
  Future<UserModel> signInWithApple();
  Future<void> signOut();
  Future<UserModel?> getCurrentUser();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> updateUser({required String username});
  Future<void> completeOnboarding();
  Future<void> changePassword(String currentPassword, String newPassword);
  Future<void> deleteAccount(); 
}