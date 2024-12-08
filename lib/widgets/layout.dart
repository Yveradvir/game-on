import 'package:flutter/material.dart';
import 'package:gameon/utils/styles.dart';

class AppLayout extends StatelessWidget {
  final Widget body;

  const AppLayout({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: const Icon(Icons.menu, color: darkColor),
        centerTitle: true,
        title: const Text("Game - On", style: titleText),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: body,
            ),
          ],
        ),
      ),
    );
  }
}
