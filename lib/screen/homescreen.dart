import 'package:flutter/material.dart';
import 'package:ucp2/widget/homescreenwidget/headerhomescreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            HeaderHomeScreen(onPressedLanjut: () {  },),
          ]),
        ),
      )),
    );
  }
}
