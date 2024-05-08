import 'package:flutter/material.dart';

class FormWidget extends StatefulWidget {
  const FormWidget(
      {super.key,
      required this.formkey,
      required this.etEmail,
      required this.etPassword});
  final GlobalKey<FormState> formkey;
  final TextEditingController etEmail;
  final TextEditingController etPassword;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formkey,
      child: Column(
        children: [
          const SizedBox(height: 16),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: widget.etEmail,
            decoration: const InputDecoration(
              labelText: "Email",
              hintText: "Enter your email address",
              prefixIcon: Icon(Icons.email),
            ),
            validator: (value) {
              bool valid = RegExp(r"@").hasMatch(value!);
              if (value.isEmpty) {
                return "Masukkan email dengan benar";
              } else if (!valid) {
                return "Harus ada @";
              }
              return null;
            },
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: widget.etPassword,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: "Password",
              hintText: "Enter your Password",
              prefixIcon: Icon(Icons.lock),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Masukkan Password dengan benar";
              } else if (value.length < 6) {
                return "Masukkan minimal 6 characters";
              }
              return null;
            },
          )
        ],
      ),
    );
  }
}
