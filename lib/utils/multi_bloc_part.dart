import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameon/screens/home/bloc/home_bloc.dart';
import 'package:gameon/screens/home/screen.dart';
import 'package:gameon/screens/welcome/screen.dart';
import 'package:gameon/widgets/error.dart';
import 'package:gameon/widgets/layout.dart';

List<BlocProvider> providersList = [
  BlocProvider<HomeBloc>(
    create: (context) => HomeBloc()..add(LoadHomeData()),
  ),
];

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case '/welcome':
      return MaterialPageRoute(builder: (_) => const WelcomeScreen());
    default:
      return MaterialPageRoute(
        builder: (_) => const AppLayout(
          body: AppErrorWidget(
            message: "Page not Found",
            statusCode: 404,
          ),
        ),
      );
  }
}
