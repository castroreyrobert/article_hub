

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});


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
            onPressed: (){},
            icon: Icon(Icons.close),
            style: IconButton.styleFrom(
              backgroundColor: Colors.black26,
              padding: EdgeInsets.zero,
              minimumSize: Size.square(24)
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Please enter your email and password to login your account",
                style: TextStyle(fontWeight: FontWeight.w100)
            ),
            SizedBox(height: 16.0),
            Text("Email address", style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.black45)),
            SizedBox(height: 8.0),
            TextField(
              decoration: InputDecoration(
                hintText: "Your email",
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(6.0))
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.0))
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text("Password", style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.black45)),
            SizedBox(height: 8.0),
            TextField(
              decoration: InputDecoration(
                hintText: "Your password",
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(6.0))

                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    borderSide: BorderSide(color: Colors.black45, width: 1.0)
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0))
                ),
                onPressed: (){},
                child: Text("Login")
              )
            )
          ],
        ),
      ),
    );
  }
}
