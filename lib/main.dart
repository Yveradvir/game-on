import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameon/utils/multi_bloc_part.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providersList,
      child: const MaterialApp(
        initialRoute: '/welcome',
        onGenerateRoute: onGenerateRoute
      ),
    );
  }
}
