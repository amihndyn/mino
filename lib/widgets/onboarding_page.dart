import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onNext;

  OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Text(description, textAlign: TextAlign.center),
          SizedBox(height: 30),
          ElevatedButton(onPressed: onNext, child: Text("Next")),
        ],
      ),
    );
  }
}
