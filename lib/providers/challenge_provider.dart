import 'package:flutter/material.dart';
import 'package:mino/core/data/model/response/user_challenge_response_model.dart';
import 'package:mino/models/challenge_data.dart'; // Sesuaikan path model ChallengeData-mu

class ChallengeProvider extends ChangeNotifier {
  // ── 1. DATA MASTER VISUAL (100% AMAN & UTUH) ───────────────────────────
  final List<ChallengeData> allChallenges = [
    ChallengeData(
      id: 1,
      title: 'Benefits of a Clean Home.',
      imageAsset: 'assets/images/clean.png',
      detailImageAsset: 'assets/images/cleans.png',
      description: 'Cleaning your home is not just about neatness, it also has a direct impact on your health and overall comfort. A clean home helps reduce dust, germs, and allergens that can cause illnesses such as coughs, flu, or allergies. In addition, a tidy environment makes your mind feel calmer and more focused, allowing you to be more productive when studying or working. Cleaning activities also count as light physical exercise, which is beneficial for your body, especially when done regularly. Just as important, a clean home creates a comfortable and pleasant atmosphere to live in with your family. So, start making cleaning a regular habit, because the benefits are immediately felt by both your body and mind.',
      diamondReward: 40,
      durationDays: 20,
      dateInfo: 'June 2026',
    ),
    ChallengeData(
      id: 2,
      title: 'Digital detox',
      imageAsset: 'assets/images/detox.png',
      detailImageAsset: 'assets/images/detoxs.png',
      description: 'Take a break from constant notifications and endless scrolling. This challenge helps you reduce screen time and reconnect with the real world around you. By limiting digital distractions, your mind becomes calmer, your focus improves, and you gain more control over how you spend your time. Use this moment to rest your eyes, clear your thoughts, and be more present in your daily life.',
      diamondReward: 60,
      durationDays: 30,
      dateInfo: 'June 2026',
    ),
    ChallengeData(
      id: 3,
      title: 'Morning routine',
      imageAsset: 'assets/images/routine.png',
      detailImageAsset: 'assets/images/routines.png',
      description: 'Start your day with intention and structure. This challenge helps you build a consistent morning routine that sets the tone for the rest of your day. By doing simple activities like planning your tasks, stretching, or enjoying a quiet moment, you create a sense of control and clarity. A good morning routine can boost your productivity, improve your mood, and help you feel more prepared to face the day ahead.',
      diamondReward: 40,
      durationDays: 20,
      dateInfo: 'June 2026',
    ),
    ChallengeData(
      id: 4,
      title: 'Eat Healthy',
      imageAsset: 'assets/images/eat.png',
      detailImageAsset: 'assets/images/eats.png',
      description: 'Fuel your body with the nutrients it needs to function at its best. This challenge encourages you to make healthier food choices and be more mindful of what you eat. A balanced diet supports your energy, focus, and long-term health. Small changes in your eating habits can lead to meaningful results.',
      diamondReward: 40,
      durationDays: 20,
      dateInfo: 'June 2026',
    ),
    ChallengeData(
      id: 5,
      title: 'Morning run',
      imageAsset: 'assets/images/run.png',
      detailImageAsset: 'assets/images/runs.png',
      description: 'Start your day with energy and a clear mind through a refreshing morning run. This challenge encourages you to build a healthy routine by moving your body early in the day. Running in the morning helps improve your stamina, boost your mood, and increase your focus for the rest of the day. The fresh air and quiet atmosphere can also give you a sense of calm and motivation. It\'s not about speed or distance—it\'s about consistency and showing up for yourself.',
      diamondReward: 40,
      durationDays: 20,
      dateInfo: 'June 2026',
    ),
    ChallengeData(
      id: 6,
      title: 'Drink 8 Glasses',
      imageAsset: 'assets/images/drink.png',
      detailImageAsset: 'assets/images/drinks.png',
      description: 'Stay hydrated and take care of your body from within. This challenge helps you build the simple yet powerful habit of drinking enough water every day. Proper hydration supports your energy, focus, and overall health. It may seem small, but consistency in this habit can make a big difference in how you feel daily.',
      diamondReward: 30,
      durationDays: 60,
      dateInfo: 'June 2026',
    ),
    ChallengeData(
      id: 7,
      title: 'No phone before bed',
      imageAsset: 'assets/images/nophone.png',
      detailImageAsset: 'assets/images/phones.png',
      description: 'Give your mind a chance to rest before sleep by staying away from your phone at least 30 minutes before bedtime. Instead of scrolling through social media or watching videos, use this time to relax, read a book, reflect on your day, or prepare for tomorrow. This simple habit can help improve sleep quality, reduce mental fatigue, and create a healthier nighttime routine.',
      diamondReward: 60,
      durationDays: 30,
      dateInfo: 'June 2026',
    ),
    ChallengeData(
      id: 8,
      title: 'Deep Work',
      imageAsset: 'assets/images/deepwork.png',
      detailImageAsset: 'assets/images/works.png',
      description: 'Train yourself to work without distractions by dedicating a focused block of time to a single task. Turn off notifications, avoid multitasking, and give your full attention to what matters most. Deep work helps improve concentration, productivity, and the quality of your results while reducing the stress caused by constant interruptions.',
      diamondReward: 60,
      durationDays: 30,
      dateInfo: 'June 2026',
    ),
    ChallengeData(
      id: 9,
      title: 'Gratitude Challenge',
      imageAsset: 'assets/images/gratitude.png',
      detailImageAsset: 'assets/images/grats.png',
      description: 'Take a few moments each day to appreciate the good things in your life, no matter how small they may seem. Write down things you\'re grateful for, meaningful moments, or acts of kindness you experienced. Practicing gratitude helps shift your focus from what is missing to what is already valuable, leading to a more positive mindset and greater emotional well-being.',
      diamondReward: 40,
      durationDays: 20,
      dateInfo: 'June 2026',
    ),
    ChallengeData(
      id: 10,
      title: 'Face Yoga',
      imageAsset: 'assets/images/face.png',
      detailImageAsset: 'assets/images/yogas.png',
      description: 'Take a moment to care for your skin in a natural and relaxing way. This challenge introduces simple facial exercises that help improve your skin\'s health and appearance over time. By gently stimulating your facial muscles, you can boost blood circulation, improve skin elasticity, and reduce signs of aging such as fine lines and wrinkles. Face yoga is not just about beauty—it\'s also about relaxation. It helps release tension in your face while giving you a calm and mindful self-care moment. With consistency, your skin will look healthier, brighter, and more radiant.',
      diamondReward: 60,
      durationDays: 30,
      dateInfo: 'June 2026',
    ),
    ChallengeData(
      id: 11,
      title: 'Skincare Challenge',
      imageAsset: 'assets/images/skincare.png',
      detailImageAsset: 'assets/images/skincares.png',
      description: 'Give your hair the attention it deserves. This challenge focuses on maintaining healthy hair through simple care routines like using treatments or reducing damage. Taking care of your hair regularly helps improve its strength, shine, and overall appearance. Small efforts can make a noticeable difference.',
      diamondReward: 60,
      durationDays: 30,
      dateInfo: 'June 2026',
    ),
  ];

  // ── 2. DYNAMIC VISUAL HELPER ───────────────────────────────────────────
  ChallengeData? getChallengeById(int id) {
    try {
      return allChallenges.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  // ── 3. DATA MENU KATEGORI Halaman Discovery ─────────────────────────────
  List<ChallengeData> getTrendingChallenges() {
    return allChallenges.where((c) => c.id <= 3).toList();
  }

  List<ChallengeData> getHealthyHabits() {
    return allChallenges.where((c) => c.id >= 4 && c.id <= 6).toList();
  }

  List<ChallengeData> getProductivityChallenges() {
    return allChallenges.where((c) => c.id >= 7 && c.id <= 9).toList();
  }

  List<ChallengeData> getSkincareChallenges() {
    return allChallenges.where((c) => c.id >= 10 && c.id <= 11).toList();
  }

  // ── 4. STATE UNTUK ROUTINE USER (YANG BARU DITAMBAHKAN) ──────────────────
  final List<ChallengeData> _userChallenges = [];
  List<ChallengeData> get userChallenges => _userChallenges;

  void joinChallenge(ChallengeData challenge) {
    if (!_userChallenges.any((c) => c.id == challenge.id)) {
      _userChallenges.add(challenge);
      notifyListeners();
    }
  }

  // ── 🔥 5. FIX BARU: STATE & FUNGSIONALITAS POPUP REMINDER ──────────────────
  bool _showWarning = false;

  // Getter agar UI bisa membaca status popup
  bool get showWarning => _showWarning;

  // Fungsi untuk memunculkan warning popup (bisa dipanggil saat validasi gagal)
  void triggerWarning() {
    _showWarning = true;
    notifyListeners();
  }

  // Fungsi untuk menutup popup reminder saat tombol close ditekan
  void dismissWarning() {
    _showWarning = false;
    notifyListeners();
  }

  // ── 6. SINKRONISASI DENGAN NETWORK DATA (FIXED) ──────────────────
  
  // Fungsi untuk mengosongkan list tantangan aktif milik user
  void clearChallenges() {
    _userChallenges.clear();
    notifyListeners();
  }

  // Fungsi menerima data bertipe UserChallenge hasil parsing dari API/BLoC
  void addChallengeFromNetwork(UserChallenge networkChallenge) {
    // Hubungkan challengeId dari server dengan id master data lokal kamu
    final masterData = getChallengeById(networkChallenge.challengeId);

    if (masterData != null) {
      // Cek apakah data ini sudah ada di list agar tidak duplikat
      if (!_userChallenges.any((c) => c.id == masterData.id)) {
        _userChallenges.add(masterData);
      }
    }
    notifyListeners();
  }
}