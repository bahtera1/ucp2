import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 40),
        Text(
          'TEMPAT WISATA KULINER',
          style: TextStyle(
            fontSize: 30,
            color: Color.fromARGB(255, 19, 126, 22),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 50,
        ),
        CircleAvatar(
          radius: 100,
          backgroundImage: AssetImage('assets/images/kuliner.jpg'),
        )
      ],
    );
  }
}
