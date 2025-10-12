import 'package:desafio_loomi/data/model/user_model.dart';
import 'package:desafio_loomi/data/repository/firebase_repository.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  final FirebaseRepository _repository;

  _AuthStore(this._repository);

  @observable
  UserModel? currentUser;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future<void> checkAuthState() async {
    isLoading = true;
    try {
      currentUser = await _repository.getCurrentUser();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> signInWithEmail(String email, String password) async {
    isLoading = true;
    try {
      currentUser = await _repository.signInWithEmail(email, password);
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> signUpWithEmail(String email, String password, String userName) async {
    isLoading = true;
    try {
      currentUser = await _repository.signUpWithEmail(email, password, userName);
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> signInWithGoogle() async {
    isLoading = true;
    try {
      currentUser = await _repository.signInWithGoogle();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> signInWithApple() async {
    isLoading = true;
    try {
      currentUser = await _repository.signInWithApple();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> resetPassword(String email) async {
    isLoading = true;
    try {
      await _repository.sendPasswordResetEmail(email);
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> signOut() async {
    await _repository.signOut();
    currentUser = null;
  }

  @action
Future<void> updateUserProfile(String username) async {
  isLoading = true;
  try {
    await _repository.updateUser(username: username);
    await _repository.completeOnboarding();
  } catch (e) {
    errorMessage = e.toString();
  } finally {
    isLoading = false;
  }
}
}