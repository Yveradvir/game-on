import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
  }

  Future<void> _onLoadHomeData(
      LoadHomeData event, Emitter<HomeState> emit) async {
    log("HomeBloc: LoadHomeData event triggered");
    emit(HomeLoading());

    try {
      emit(HomeLoaded());
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }
}
