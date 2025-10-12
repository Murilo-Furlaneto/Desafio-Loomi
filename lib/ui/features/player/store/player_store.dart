import 'package:mobx/mobx.dart';

part 'player_store.g.dart';

class PlayerStore = _PlayerStore with _$PlayerStore;

abstract class _PlayerStore with Store {
  @observable
  bool isPlaying = false;

  @observable
  Duration position = Duration.zero;

  @observable
  Duration duration = Duration.zero;

  @action
  void play() => isPlaying = true;

  @action
  void pause() => isPlaying = false;

  @action
  void seek(Duration newPosition) => position = newPosition;

  @action
  void setDuration(Duration newDuration) => duration = newDuration;
}
