import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({
    super.key,
    required this.onPressedLogin,
  });

  final VoidCallback onPressedLogin;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 45, bottom: 35),
          child: ElevatedButton(
            onPressed: onPressedLogin,
            child: const Text("MASUK"),
          ),
        ),
      ],
    );
  }
}
