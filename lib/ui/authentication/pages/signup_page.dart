

import 'package:article_hub/ui/authentication/bloc/remote_authentication_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/dependency_injector.dart';
import '../bloc/remote_authentication_bloc.dart';
import '../bloc/remote_authentication_state.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: BlocProvider<RemoteAuthenticationBloc>(
        create: (ctx) => dependencyInjector<RemoteAuthenticationBloc>(),
        child: BlocListener<RemoteAuthenticationBloc, RemoteAuthenticationState>(
          listener: (ctx, state) {
            if (state is RemoteAuthSuccess) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Account created successfully!'), backgroundColor: Colors.green),
              );
            }
          },
          child: BlocBuilder<RemoteAuthenticationBloc, RemoteAuthenticationState>(
            builder: (ctx, state) {
              if (state is RemoteAuthLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email", style: Theme
                          .of(ctx)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: Colors.black45)),
                      SizedBox(height: 8.0),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: 'Your email address',
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black, width: 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(6.0))
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(6.0))
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text('Password', style: Theme
                          .of(ctx)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: Colors.black45)),
                      SizedBox(height: 8.0),
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: 'Your password',
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black, width: 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(6.0))
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(6.0)),
                              borderSide: BorderSide(
                                  color: Colors.black45, width: 1.0)
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                            style: FilledButton.styleFrom(
                                backgroundColor: Colors.black,
                                padding: EdgeInsets.all(16.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.0))
                            ),
                            onPressed: () {
                              ctx.read<RemoteAuthenticationBloc>().add(SignUpEvent(email: emailController.text, password: passwordController.text));
                            },
                            child: Text("Create an account"),
                        ),
                      )
                    ]
                ),
              );
            }
          ),
        ),
      )
    );
  }
}
