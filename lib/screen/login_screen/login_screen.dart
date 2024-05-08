import 'package:flutter/material.dart';
import 'package:ucp2/screen/pertama_screen.dart';
import 'package:ucp2/widget/login/footer_widget.dart';
import 'package:ucp2/widget/login/form_widget.dart';
import 'package:ucp2/widget/login/header_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var email = TextEditingController();
    var password = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            const HeaderWidget(),
            FormWidget(
              etEmail: email,
              etPassword: password,
              formkey: formKey,
            ),
            FooterWidget(
              onPressedLogin: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => PertamaScreen()),
                      (route) => false);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Lanjut"),
                  ));
                }
              },
            )
          ]),
        ),
      )),
    );
  }
}
