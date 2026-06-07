# PROJECT CONTEXT: MINO APP

Saya sedang membangun aplikasi bernama MINO menggunakan Flutter (Frontend) dan Laravel 12 + MySQL (Backend API).

Backend Laravel berada di:

D:\proyekmino1

Frontend Flutter berada di:

D:\fmino\mino

Jangan membuat project baru. Gunakan struktur project yang sudah ada dan lanjutkan pengembangannya.

---

# TUJUAN APLIKASI

MINO adalah aplikasi self-improvement yang membantu pengguna membangun kebiasaan positif melalui:

* Habit Tracking
* Focus Timer
* Reward System
* Challenge System
* Reflection System
* Daily Story (AI Narrative)

Tujuan utama aplikasi bukan hanya mencatat habit, tetapi membantu pengguna membangun konsistensi, fokus, refleksi diri, dan pertumbuhan jangka panjang.

---

# CORE CONCEPT

MINO berfokus pada:

Consistency > Intensity

Aplikasi harus mendorong pengguna untuk melakukan kemajuan kecil setiap hari daripada mengejar hasil instan.

---

# USER FLOW

## 1. ONBOARDING

User pertama kali membuka aplikasi.

Flow:

* Welcome Screen
* Pilih tujuan pribadi
* Pilih habit awal
* Masuk ke Dashboard

Contoh tujuan:

* Productivity
* Study
* Fitness
* Reading
* Self Development

---

## 2. HABIT SYSTEM (CORE FEATURE)

Setiap user memiliki daftar habit aktif.

Contoh:

* Read 15 Minutes
* Exercise
* Learn Programming
* Wake Up Early

Fitur:

* Daily Progress
* Day 1 - Day 30
* Streak Tracking
* Habit Completion

Flow:

User membuka habit
↓
Melakukan aktivitas
↓
Menandai habit selesai
↓
Progress bertambah
↓
Streak diperbarui

Database:

habits
user_habits
habit_logs

---

## 3. FOCUS TIMER

Digunakan untuk membantu user menyelesaikan habit.

Contoh:

Belajar Flutter
↓
Start Timer (25 menit)
↓
Timer berjalan
↓
Complete Session

Database:

focus_timers

API:

POST /api/focus/start
POST /api/focus/complete
GET /api/focus/history

Catatan:

Focus Timer bukan fitur utama, tetapi fitur pendukung habit.

---

## 4. REWARD SYSTEM

User mendapatkan diamond sebagai reward.

Contoh:

Habit selesai = +5 diamond
Focus session selesai = +2 diamond
Challenge selesai = +50 diamond

Database:

diamonds
diamond_transactions

API:

GET /api/diamonds
GET /api/transactions

Tujuan:

Meningkatkan motivasi dan engagement.

---

## 5. CHALLENGE SYSTEM

Challenge berbasis konsistensi.

Contoh:

7 Day Challenge
21 Day Challenge
30 Day Challenge

Flow:

Mulai Challenge
↓
Selesaikan habit harian
↓
Progress bertambah
↓
Challenge selesai
↓
Bonus diamond
↓
Unlock habit baru

Database:

challenges
user_challenges

---

## 6. REFLECTION SYSTEM

Setelah menyelesaikan aktivitas, user dapat menulis refleksi.

Tujuan:

Membantu user memahami perkembangan dirinya.

Database:

reflections

Struktur:

* user_id
* user_habit_id (nullable)
* date
* content
* mood

Mood:

* amazing
* good
* okey
* unusual
* bad

Flow:

Isi Mood
↓
Tulis Reflection
↓
Simpan

API:

POST /api/reflections
GET /api/reflections
GET /api/reflections/{date}

Catatan:

Saat ini satu reflection per hari untuk setiap user.

---

## 7. DAILY STORY (UNIQUE FEATURE)

Ini adalah fitur pembeda utama MINO.

Daily Story merupakan narasi otomatis yang dibuat berdasarkan:

* Habit Progress
* Focus Timer
* Reflection
* Mood

Contoh output:

"Today you completed 3 habits and focused for 75 minutes. You showed great consistency and maintained a positive mindset. Keep moving forward."

Database:

daily_stories

API:

POST /api/daily-story/generate
GET /api/daily-story/{date}

Catatan:

Daily Story harus terasa personal, motivasional, dan merepresentasikan aktivitas user pada hari tersebut.

---

# CURRENT BACKEND STATUS

Framework:
Laravel 12

Database:
MySQL

Authentication:
Laravel Sanctum

Sebagian model, migration, seeder, dan API sudah dibuat.

Tugas Anda:

1. Audit struktur database.
2. Cari kemungkinan desain yang kurang efisien.
3. Perbaiki relasi antar tabel jika diperlukan.
4. Berikan rekomendasi best practice Laravel.
5. Perbaiki flow bisnis jika ada yang lebih baik.
6. Hindari overengineering.
7. Fokus pada MVP yang dapat dikembangkan di masa depan.

---

# OUTPUT YANG DIHARAPKAN

Ketika menganalisis project ini:

* Jelaskan kekurangan flow saat ini.
* Berikan usulan flow yang lebih baik.
* Berikan usulan ERD/database.
* Berikan usulan API endpoint yang lebih rapi.
* Berikan contoh implementasi Laravel 12.
* Jelaskan alasan setiap perubahan.

Tujuan akhirnya adalah menghasilkan backend yang scalable, maintainable, dan siap digunakan oleh aplikasi Flutter MINO.
