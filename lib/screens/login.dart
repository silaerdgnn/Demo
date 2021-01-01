import 'package:flutter/material.dart';
import 'package:flutter_news_app/screens/register.dart';
import 'package:flutter_news_app/theme/constants.dart';
import 'package:flutter_news_app/widgets/info.dart';

class Login extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Info(
                textEditingController: emailController,
                prefixIcon: Icon(Icons.email),
                labelText: 'Email',
                obscure: false,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Info(
                  textEditingController: passwordController,
                  prefixIcon: Icon(Icons.lock_sharp),
                  labelText: 'Password',
                  obscure: true,
                ),
              ),
              FlatButton(
                color: Colors.pink,
                minWidth: 200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                onPressed: () {
                  print(emailController.text.trim());
                  print(passwordController.text.trim());
                },
                child: Text('Giriş'),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Registor(),
                    ),
                  );
                },
                child: Text('Kayıt ol'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
