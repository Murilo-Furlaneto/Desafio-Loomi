import 'package:mobx/mobx.dart';
import 'package:desafio_loomi/data/model/movie_model.dart';
import 'package:desafio_loomi/data/services/api_service.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  final ApiService _apiService = ApiService();

  @observable
  ObservableList<MovieModel> movies = ObservableList<MovieModel>();

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future<void> fetchMovies() async {
    isLoading = true;
    errorMessage = null;
    try {
      final result = await _apiService.getMovies();
      movies = ObservableList.of(result);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }
}
