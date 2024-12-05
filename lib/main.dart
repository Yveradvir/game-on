import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameon/screens/home/screen.dart';
import 'package:gameon/utils/providers.dart';
import 'package:gameon/widgets/error.dart';
import 'package:gameon/widgets/layout.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providersList,
      child: MaterialApp(
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (_) => const HomeScreen());
            default:
              return MaterialPageRoute(
                builder: (_) => const AppLayout(
                  body: AppErrorWidget(message: "Page not Found", statusCode: 433,),
                ),
              );
          }
        },
      ),
    );
  }
}
