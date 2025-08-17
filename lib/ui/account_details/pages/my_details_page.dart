
import 'package:flutter/material.dart';

class MyDetailsPage extends StatefulWidget {
  const MyDetailsPage({super.key});

  @override
  State<MyDetailsPage> createState() => _MyDetailsPageState();
}

class _MyDetailsPageState extends State<MyDetailsPage> {

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Details"),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: "Enter your email",
              labelText: "Email",
            ),
          ),
          const SizedBox( // Use const if dimensions are fixed
            height: 20.0, // This is the height of the indicator itself
            width: 20.0,  // The button's total height will be this + vertical padding
            child: Text("Create an account")
          )
        ]
      )
    );
  }
}
