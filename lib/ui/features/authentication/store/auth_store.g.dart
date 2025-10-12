// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on _AuthStore, Store {
  late final _$currentUserAtom =
      Atom(name: '_AuthStore.currentUser', context: context);

  @override
  UserModel? get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(UserModel? value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_AuthStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_AuthStore.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$checkAuthStateAsyncAction =
      AsyncAction('_AuthStore.checkAuthState', context: context);

  @override
  Future<void> checkAuthState() {
    return _$checkAuthStateAsyncAction.run(() => super.checkAuthState());
  }

  late final _$signInWithEmailAsyncAction =
      AsyncAction('_AuthStore.signInWithEmail', context: context);

  @override
  Future<bool> signInWithEmail(String email, String password) {
    return _$signInWithEmailAsyncAction
        .run(() => super.signInWithEmail(email, password));
  }

  late final _$signUpWithEmailAsyncAction =
      AsyncAction('_AuthStore.signUpWithEmail', context: context);

  @override
  Future<bool> signUpWithEmail(String email, String password, String userName) {
    return _$signUpWithEmailAsyncAction
        .run(() => super.signUpWithEmail(email, password, userName));
  }

  late final _$signInWithGoogleAsyncAction =
      AsyncAction('_AuthStore.signInWithGoogle', context: context);

  @override
  Future<bool> signInWithGoogle() {
    return _$signInWithGoogleAsyncAction.run(() => super.signInWithGoogle());
  }

  late final _$signInWithAppleAsyncAction =
      AsyncAction('_AuthStore.signInWithApple', context: context);

  @override
  Future<bool> signInWithApple() {
    return _$signInWithAppleAsyncAction.run(() => super.signInWithApple());
  }

  late final _$resetPasswordAsyncAction =
      AsyncAction('_AuthStore.resetPassword', context: context);

  @override
  Future<bool> resetPassword(String email) {
    return _$resetPasswordAsyncAction.run(() => super.resetPassword(email));
  }

  late final _$signOutAsyncAction =
      AsyncAction('_AuthStore.signOut', context: context);

  @override
  Future<void> signOut() {
    return _$signOutAsyncAction.run(() => super.signOut());
  }

  late final _$updateUserProfileAsyncAction =
      AsyncAction('_AuthStore.updateUserProfile', context: context);

  @override
  Future<void> updateUserProfile(String username) {
    return _$updateUserProfileAsyncAction
        .run(() => super.updateUserProfile(username));
  }

  @override
  String toString() {
    return '''
currentUser: ${currentUser},
isLoading: ${isLoading},
errorMessage: ${errorMessage}
    ''';
  }
}
