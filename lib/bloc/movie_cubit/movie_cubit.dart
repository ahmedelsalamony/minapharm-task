import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:minapharm_flutter_task/data/repository/movie_repo.dart';

import '../../data/models/movie.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final MovieRepo movieRepo;
  MovieCubit(this.movieRepo) : super(MovieInitial());

  Future<void> getMovieList() async {
    movieRepo.fetchMovies().then((value) {
      if (value.items!.isNotEmpty) {
        emit(MoviesLoadedSuccessfully(value.items!));
      } else {
        emit(MovieFailure(value.errorMessage!));
      }
    });
  }
}
