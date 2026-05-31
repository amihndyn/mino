import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.4), // Background semi-transparan
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.blue, // Sesuaikan dengan warna tema aplikasimu
        ),
      ),
    );
  }
}