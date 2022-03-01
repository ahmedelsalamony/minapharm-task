import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minapharm_flutter_task/bloc/auth_cubit/auth_cubit.dart';
import 'package:minapharm_flutter_task/bloc/movie_cubit/movie_cubit.dart';
import 'package:minapharm_flutter_task/config/constants/pallete.dart';

import '../../../config/routes/routes.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MovieCubit>(context).getMovieList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Pallete.blue,
            actions: [
              InkWell(
                onTap: () async {
                  await BlocProvider.of<AuthCubit>(context).signout();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(Routes.login, (route) => false);
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.logout),
                ),
              )
            ],
          ),
          body: BlocBuilder<MovieCubit, MovieState>(
            builder: (context, state) {
              if (state is MovieLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is MoviesLoadedSuccessfully) {
                return ListView.builder(itemBuilder: (context, index) {
                  return Card(
                    elevation: 6,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 8),
                      child: ListTile(
                        leading: Image.network(state.movies[index].image!),
                        title: Text(state.movies[index].title!),
                      ),
                    ),
                  );
                });
              } else {
                return Container();
              }
            },
          )),
    );
  }
}
