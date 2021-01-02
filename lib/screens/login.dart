import 'package:flutter/material.dart';
import 'package:flutter_news_app/screens/home.dart';
import 'package:flutter_news_app/screens/register.dart';
import 'package:flutter_news_app/services/aservice.dart';
import 'package:flutter_news_app/theme/constants.dart';
import 'package:flutter_news_app/widgets/info.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Image.asset(
                    "assets/images/news.png",
                    width: 200,
                    height: 200,
                  ),
                ),
                Info(
                  textEditingController: emailController,
                  prefixIcon: Icon(Icons.email, color: kIcons),
                  labelText: 'E-posta giriniz.',
                  obscure: false,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Info(
                    textEditingController: passwordController,
                    prefixIcon: Icon(Icons.lock_sharp, color: kIcons),
                    labelText: 'Şifre giriniz.',
                    obscure: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: FlatButton(
                    color: kTextColorLight,
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ),
                        );
                      } catch (e) {}
                    },
                    child: Text('Giriş Yap',
                        style: TextStyle(color: kTextLight, fontSize: 20)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Registor(),
                        ),
                      );
                    },
                    child: Text('Kayıt ol',
                        style: TextStyle(color: kTextColorDark, fontSize: 20)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
