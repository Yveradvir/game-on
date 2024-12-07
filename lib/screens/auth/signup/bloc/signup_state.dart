part of 'signup_bloc.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupError extends SignupState {
  final String? generalError;
  final Map<String, String> fieldErrors;

  SignupError({this.generalError, this.fieldErrors = const {}});
}

final class SignupLoading extends SignupState {}

final class SignupSuccess extends SignupState {}
