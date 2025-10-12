// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PlayerStore on _PlayerStore, Store {
  late final _$isPlayingAtom =
      Atom(name: '_PlayerStore.isPlaying', context: context);

  @override
  bool get isPlaying {
    _$isPlayingAtom.reportRead();
    return super.isPlaying;
  }

  @override
  set isPlaying(bool value) {
    _$isPlayingAtom.reportWrite(value, super.isPlaying, () {
      super.isPlaying = value;
    });
  }

  late final _$positionAtom =
      Atom(name: '_PlayerStore.position', context: context);

  @override
  Duration get position {
    _$positionAtom.reportRead();
    return super.position;
  }

  @override
  set position(Duration value) {
    _$positionAtom.reportWrite(value, super.position, () {
      super.position = value;
    });
  }

  late final _$durationAtom =
      Atom(name: '_PlayerStore.duration', context: context);

  @override
  Duration get duration {
    _$durationAtom.reportRead();
    return super.duration;
  }

  @override
  set duration(Duration value) {
    _$durationAtom.reportWrite(value, super.duration, () {
      super.duration = value;
    });
  }

  late final _$_PlayerStoreActionController =
      ActionController(name: '_PlayerStore', context: context);

  @override
  void play() {
    final _$actionInfo =
        _$_PlayerStoreActionController.startAction(name: '_PlayerStore.play');
    try {
      return super.play();
    } finally {
      _$_PlayerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void pause() {
    final _$actionInfo =
        _$_PlayerStoreActionController.startAction(name: '_PlayerStore.pause');
    try {
      return super.pause();
    } finally {
      _$_PlayerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void seek(Duration newPosition) {
    final _$actionInfo =
        _$_PlayerStoreActionController.startAction(name: '_PlayerStore.seek');
    try {
      return super.seek(newPosition);
    } finally {
      _$_PlayerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDuration(Duration newDuration) {
    final _$actionInfo = _$_PlayerStoreActionController.startAction(
        name: '_PlayerStore.setDuration');
    try {
      return super.setDuration(newDuration);
    } finally {
      _$_PlayerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isPlaying: ${isPlaying},
position: ${position},
duration: ${duration}
    ''';
  }
}
