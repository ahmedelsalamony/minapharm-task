import 'package:minapharm_flutter_task/data/webservices/movies_webservices.dart';

import '../models/movie.dart';

class MovieRepo {
  final MoviesWebServices moviesWebServices;

  MovieRepo(this.moviesWebServices);

  Future<Movie> fetchMovies() async {
    final movies = await moviesWebServices.getMoviesList();

    return movies;
  }
}
