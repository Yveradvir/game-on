import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupRequested>(_onSignupRequested);
  }

  Future<void> _onSignupRequested(
      SignupRequested event, Emitter<SignupState> emit) async {
    emit(SignupLoading());
    await Future.delayed(const Duration(seconds: 1));
    
    if (event.email == "test@example.com") {
      emit(SignupError(
        generalError: "User already exists",
        fieldErrors: const {
          "email": "This email is already taken",
        },
      ));
    } else {
      emit(SignupSuccess());
    }
  }
}
