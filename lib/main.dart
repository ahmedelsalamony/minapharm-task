import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minapharm_flutter_task/config/routes/routes.dart';
import 'config/routes/routes_generator.dart';
import 'package:firebase_core/firebase_core.dart';

late String initialRoute;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //this part handle auto login functionality
  FirebaseAuth.instance.authStateChanges().listen((user) {
    if (user == null) {
      initialRoute = Routes.login;
    } else {
      initialRoute = Routes.dashboard;
    }
  });
  runApp(MyApp(
    appRouter: RouteGenerator(),
  ));
}

class MyApp extends StatelessWidget {
  final RouteGenerator appRouter;
  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: appRouter.generateRoute,
      initialRoute: initialRoute,
    );
  }
}
