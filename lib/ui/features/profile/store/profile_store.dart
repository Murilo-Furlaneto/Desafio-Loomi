import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:desafio_loomi/data/model/user_model.dart';
import 'package:desafio_loomi/di/service_locator.dart';
import 'package:desafio_loomi/data/services/api_service.dart';
import 'package:desafio_loomi/data/repository/firebase_repository.dart';

part 'profile_store.g.dart';

class ProfileStore = _ProfileStoreBase with _$ProfileStore;

abstract class _ProfileStoreBase with Store {
  final ApiService _apiService = getIt<ApiService>();
  final FirebaseRepository _firebaseRepository = getIt<FirebaseRepository>();

  @observable
  UserModel? user;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  String? passwordChangeSuccessMessage;

  @action
  Future<void> fetchUserProfile() async {
    isLoading = true;
    errorMessage = null;
    try {
      final userData = await _apiService.getUserData();
      user = userData;
    } catch (e) {
      errorMessage = 'Failed to fetch user profile: ${e.toString()}';
      debugPrint(errorMessage);
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    isLoading = true;
    errorMessage = null;
    passwordChangeSuccessMessage = null;
    try {
      await _firebaseRepository.changePassword(currentPassword, newPassword);
      passwordChangeSuccessMessage = 'Password changed successfully!';
      return true;
    } catch (e) {
      errorMessage =
          e.toString().contains('Exception:')
              ? e.toString().replaceAll('Exception: ', '')
              : 'Failed to change password. Please check your current password.';
      debugPrint('Password change error: $e');
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> deleteUserAccount() async {
    isLoading = true;
    errorMessage = null;
    try {
      await _firebaseRepository.deleteAccount();
      user = null;
      return true;
    } catch (e) {
      errorMessage = e.toString();
      debugPrint('Erro ao excluir conta: $e');
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  void clearUser() {
    user = null;
  }
}
