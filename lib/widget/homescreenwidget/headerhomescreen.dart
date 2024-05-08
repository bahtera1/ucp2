import 'package:flutter/material.dart';

class HeaderHomeScreen extends StatelessWidget {
  const HeaderHomeScreen({super.key, required this.onPressedLanjut});

  final VoidCallback onPressedLanjut;

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 25),
        Text('Aplikasi Tempat Kuliner'),
        SizedBox(
          height: 25,
        ),
        CircleAvatar(
          backgroundImage: NetworkImage("image"),
          radius: 80,
        ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 40, bottom: 25),
        //   child: ElevatedButton(
        //     onPressed: onPressedLanjut,
        //     child: const Text('Masuk'),
        //   ),
        // ),
      ],
    );
  }
}
