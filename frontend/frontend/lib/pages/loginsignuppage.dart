import 'package:flutter/material.dart';
import 'package:train_ez/pages/infopage.dart';

void navigateToLoginSignup(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PersonalInfoPage(),
    ),
  );
}

class LoginSignupPage extends StatelessWidget {
  const LoginSignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20,),

              

              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: (){navigateToLoginSignup(context);},
                    child: Text('Login')
                  ),
              

                  ElevatedButton(
                    onPressed: (){
                      navigateToLoginSignup(context);
                    },
                    child: Text('Signup')
                  ),
                ],
              )
            ],
          ),
          ),
      ),
    );
  }
}