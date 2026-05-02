import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;

  final List<Map<String, String>> data = [
    {
      "title": "Build your habits",
      "desc": "Start your journey by creating meaningful habits",
    },
    {
      "title": "Stay consistent",
      "desc": "Dig deeper every day with focused effort",
    },
    {
      "title": "Find your diamond",
      "desc": "Discover the rewards of your persistence",
    },
  ];

  void nextPage() {
    if (currentPage < data.length - 1) {
      _controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      print("Selesai onboarding");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data[index]["title"]!,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(data[index]["desc"]!, textAlign: TextAlign.center),

                SizedBox(height: 40),

                ElevatedButton(onPressed: nextPage, child: Text("Next")),
              ],
            ),
          );
        },
      ),
    );
  }
}
