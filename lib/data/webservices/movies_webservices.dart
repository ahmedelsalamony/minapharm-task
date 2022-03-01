import 'package:dio/dio.dart';
import 'package:minapharm_flutter_task/config/constants/endpoints.dart';
import 'package:minapharm_flutter_task/data/models/movie.dart';

class MoviesWebServices {
  late Dio dio;

  Future<Movie> getMoviesList() async {
    Response rowResponse = await Dio().get(EndPoints.movieList);
    return Movie.fromJson(rowResponse.data);
  }
}
