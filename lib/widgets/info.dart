import 'package:flutter/material.dart';
import 'package:flutter_news_app/theme/constants.dart';

class Info extends StatelessWidget {
  final TextEditingController textEditingController;
  final Widget prefixIcon;
  final String labelText;
  final bool obscure;

  const Info(
      {Key key,
      this.textEditingController,
      this.prefixIcon,
      this.labelText,
      this.obscure})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 50,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        obscureText: obscure,
        controller: textEditingController,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.red),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            borderSide: BorderSide(color: kPrimaryColor),
          ),
        ),
      ),
    );
  }
}
