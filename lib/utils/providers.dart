import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameon/screens/home/bloc/home_bloc.dart';

List<BlocProvider> providersList = [
  BlocProvider<HomeBloc>(
    create: (context) => HomeBloc()..add(LoadHomeData()),
  ),
];
