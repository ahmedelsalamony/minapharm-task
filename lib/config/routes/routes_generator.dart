import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minapharm_flutter_task/bloc/movie_cubit/movie_cubit.dart';
import 'package:minapharm_flutter_task/config/routes/routes.dart';
import 'package:minapharm_flutter_task/data/repository/movie_repo.dart';
import 'package:minapharm_flutter_task/data/webservices/movies_webservices.dart';
import 'package:minapharm_flutter_task/presentation/screens/dashboard/dashboard.dart';
import 'package:minapharm_flutter_task/presentation/screens/login/login.dart';
import 'package:minapharm_flutter_task/presentation/screens/login/register.dart';

import '../../bloc/auth_cubit/auth_cubit.dart';

class RouteGenerator {
  AuthCubit? authCubit;
  MovieCubit? movieCubit;
  RouteGenerator() {
    authCubit = AuthCubit();
    movieCubit = MovieCubit(MovieRepo(MoviesWebServices()));
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    // final Object params = settings.arguments;
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<AuthCubit>.value(
                  value: authCubit!,
                  child: const LoginScreen(),
                ));

      case Routes.register:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<AuthCubit>.value(
                value: authCubit!, child: const RegisterScreen()));

      default:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider<MovieCubit>.value(
                      value: movieCubit!,
                    ),
                    BlocProvider<AuthCubit>.value(value: authCubit!),
                  ],
                  child: const Dashboard(),
                ));
    }
  }
}
