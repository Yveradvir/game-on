import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameon/screens/home/bloc/home_bloc.dart';
import 'package:gameon/widgets/error.dart';
import 'package:gameon/widgets/layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log("Dispatching HomeInitial event");

    return AppLayout(
      body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeLoaded) {
          return const Text("Loaded");
        } else if (state is HomeError) {
          return AppErrorWidget(
            message: state.message,
            statusCode: state.statusCode,
          );
        } else {
          return const AppErrorWidget(message: "Not Found", statusCode: 404);
        }
      }),
    );
  }
}
