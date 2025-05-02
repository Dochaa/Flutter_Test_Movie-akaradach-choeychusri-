import 'package:get/get.dart';
import '../models/movie_model.dart';
import '../services/api_service.dart';

class MovieController extends GetxController {
  RxList<MovieModel> movies = <MovieModel>[].obs;
  RxList<MovieModel> filteredMovies = <MovieModel>[].obs;
  RxBool isLoading = true.obs;
  RxString searchText = ''.obs;

  @override
  void onInit() {
    fetchMovieList();
    debounce(searchText, (_) => filterMovies(), time: Duration(milliseconds: 300));
    super.onInit();
  }

  void fetchMovieList() async {
    isLoading.value = true;
    try {
      final data = await ApiService.fetchMovies();
      movies.value = data;
      filteredMovies.value = data;
    } finally {
      isLoading.value = false;
    }
  }

  void filterMovies() {
    if (searchText.value.isEmpty) {
      filteredMovies.value = movies;
    } else {
      filteredMovies.value = movies
          .where((movie) =>
              movie.title.toLowerCase().contains(searchText.value.toLowerCase()))
          .toList();
    }
  }
}
