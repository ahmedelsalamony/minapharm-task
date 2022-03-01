part of 'movie_cubit.dart';

@immutable
abstract class MovieState {}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MoviesLoadedSuccessfully extends MovieState {
  final List<Item> movies;

  MoviesLoadedSuccessfully(this.movies);
}

class MovieFailure extends MovieState {
  final String errorMsg;

  MovieFailure(this.errorMsg);
}
