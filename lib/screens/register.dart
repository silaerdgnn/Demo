import 'package:flutter/material.dart';
import 'package:flutter_news_app/screens/home.dart';
import 'package:flutter_news_app/services/aservice.dart';
import 'package:flutter_news_app/widgets/info.dart';
import 'package:provider/provider.dart';

class Registor extends StatelessWidget {
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
                onPressed: () async {
                  try {
                    await context.read<AService>().login(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ),
                    );
                  } catch (e) {}
                },
                child: Text('Kayıt ol'),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text('Giriş Yap'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
