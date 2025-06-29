

import 'package:article_hub/core/utils/dependency_injector.dart';
import 'package:article_hub/ui/home_page.dart';
import 'package:article_hub/ui/authentication/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/remote_authentication_bloc.dart';
import '../bloc/remote_authentication_event.dart';
import '../bloc/remote_authentication_state.dart';


class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Account",
            style: TextStyle(
                fontWeight: FontWeight.bold
            )
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SignupPage()),
              );
            },
            icon: Icon(Icons.close),
            style: IconButton.styleFrom(
                backgroundColor: Colors.black26,
                padding: EdgeInsets.zero,
                minimumSize: Size.square(24)
            ),
          )
        ],
      ),
      body: BlocProvider<RemoteAuthenticationBloc>(
        create: (context) => dependencyInjector<RemoteAuthenticationBloc>(),
        child: BlocListener<RemoteAuthenticationBloc, RemoteAuthenticationState>(
          listener: (context, state) {
            if (state is RemoteAuthSuccess) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomePage()),
                    (Route<dynamic> route) => false,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Login Successful! Welcome ${state.user?.username ?? ''}'), backgroundColor: Colors.green),
              );
            } else if (state is RemoteAuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Login failed'), backgroundColor: Colors.red),
              );
            }
          },
          child: _buildBody(),
        )
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<RemoteAuthenticationBloc, RemoteAuthenticationState>(
        builder: (ctx, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Please enter your email and password to login your account",
                      style: TextStyle(fontWeight: FontWeight.w100)
                  ),
                  SizedBox(height: 16.0),
                  Text("Username", style: Theme
                      .of(ctx)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: Colors.black45)),
                  SizedBox(height: 8.0),
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: "Your username",
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
                  Text("Password", style: Theme
                      .of(ctx)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: Colors.black45)),
                  SizedBox(height: 8.0),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: "Your password",
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
                  SizedBox(height: 8.0),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text("Forgot password",
                        style: TextStyle(color: Colors.black)
                    ),
                  ),
                  SizedBox(height: 32.0),
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
                            ctx.read<RemoteAuthenticationBloc>().add(LoginEvent(
                                username: usernameController.text, password: passwordController.text));
                          },
                          child: state is RemoteAuthLoading ? ?
                          const SizedBox( // Use const if dimensions are fixed
                            height: 20.0, // This is the height of the indicator itself
                            width: 20.0,  // The button's total height will be this + vertical padding
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ) :
                          Text("Log in")
                      )
                  )
                ],
              ),
            );
        }
    );
  }
}
