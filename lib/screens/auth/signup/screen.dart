import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameon/screens/auth/signup/bloc/signup_bloc.dart';
import 'package:gameon/screens/auth/signup/components/form.dart';
import 'package:gameon/widgets/layout.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      body: BlocProvider(
        create: (_) => SignupBloc(),
        child: BlocConsumer<SignupBloc, SignupState>(
          listener: (context, state) {
            if (state is SignupSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Signup Successful')),
              );
            } else if (state is SignupError) {
              if (state.generalError != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.generalError!)),
                );
              }
            }
          },
          builder: (context, state) {
            return const SignupForm();
          },
        ),
      ),
    );
  }
}
