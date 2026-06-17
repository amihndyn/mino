# Plan: Integrasi Challenge - UI, Backend & Logic

## 📌 Ringkasan Fitur yang Akan Dibangun

### Alur Utama:
1. User menekan **"Add to routine"** → challenge masuk ke daftar habit di HomePage
2. Challenge berjalan selama N hari (misal 20 hari)
3. Setiap hari user mencentang habit challenge → streak bertambah, tapi **TIDAK dapat diamond**
4. Jika user **berhasil menyelesaikan** (semua hari berhasil):
   - Dapat **diamond reward** (sesuai `diamondReward` challenge, misal +50)
   - Habit baru dari challenge **muncul di daftar habit** permanen
5. Jika user **melewatkan 1 hari**:
   - Di hari berikutnya muncul **peringatan** bahwa challenge "mati"
   - User punya 2 opsi:
     - **Revive**: Tukar **3 diamond** → challenge hidup lagi, lanjut hari berikutnya (TIDAK ulang dari awal)
     - **Tolak**: Challenge dihapus dari daftar habit, kembali ke list challenge

---

## 🔄 Arsitektur Yang Akan Dibangun

```
┌─────────────────────────────────────────────────────────────────────────┐
│                        FRONTEND (Flutter)                             │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  ┌──────────────────┐     ┌──────────────────┐     ┌────────────────┐ │
│  │  ChallengeDetail │     │    HomePage      │     │ ActiveHabitList│ │
│  │      Page        │     │                  │     │     Page       │ │
│  │                  │     │  • TodayHabits   │     │                │ │
│  │ [Add to routine] │────▶│    dari BLoC     │◀────│  Slidable with │ │
│  │                  │     │  • including     │     │  Check/Delete │ │
│  │                  │     │    challenge     │     │                │ │
│  │                  │     │    habits        │     │                │ │
│  └──────────────────┘     └──────────────────┘     └────────────────┘ │
│           │                        │                        │           │
│           ▼                        ▼                        ▼           │
│  ┌─────────────────────────────────────────────────────────────────┐ │
│  │                    UserChallengeBloc                            │ │
│  │  • _JoinChallenge      → POST /api/user-challenges/join         │ │
│  │  • _CheckInChallenge   → POST /api/user-challenges/check/{id}   │ │
│  │  • _ReviveChallenge    → POST /api/user-challenges/revive/{id}  │ │
│  │  • _FailChallenge     → DELETE /api/user-challenges/{id}        │ │
│  └─────────────────────────────────────────────────────────────────┘ │
│                                │                                        │
│                                ▼                                        │
│  ┌─────────────────────────────────────────────────────────────────┐ │
│  │              DashboardBloc (Habits)                             │ │
│  │  • _ToggleHabit    → toggle regular habit (dapet +10 diamond)  │ │
│  │  • _AddHabit       → tambah habit dari completed challenge       │ │
│  └─────────────────────────────────────────────────────────────────┘ │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
                                  │
                                  ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                        BACKEND (Laravel)                               │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  POST /api/user-challenges/join                                        │
│    → Input: { challenge_id }                                            │
│    → Output: UserChallenge (dengan habitName, progressDays=0, dll)      │
│    → Logic: Buat record baru, generate habit daily di DB                 │
│                                                                         │
│  POST /api/user-challenges/check/{id}                                   │
│    → Input: user_challenge_id                                           │
│    → Output: UserChallenge terupdate OR error "failed_streak"          │
│    → Logic:                                                              │
│      • Cek apakah yesterday sudah check-in                              │
│      • Jika belum → throw "failed_streak"                               │
│      • Jika ya → increment progressDays, update lastProgressDate       │
│      • Jika progressDays == requiredDays → set status="completed",     │
│        trigger diamond reward, trigger add permanent habit            │
│                                                                         │
│  POST /api/user-challenges/revive/{id}                                 │
│    → Input: user_challenge_id                                           │
│    → Output: UserChallenge terupdate OR error insufficient diamond      │
│    → Logic:                                                              │
│      • Cek apakah user punya >= 3 diamond                              │
│      • Jika tidak → throw error                                        │
│      • Jika ya → deduct 3 diamond, set status="active",                  │
│        continue dari hari berikutnya (NOT restart)                      │
│                                                                         │
│  DELETE /api/user-challenges/{id}                                       │
│    → Input: user_challenge_id                                           │
│    → Output: success                                                   │
│    → Logic: Hapus record, challenge kembali ke list (available)          │
│                                                                         │
│  GET /api/dashboard (existing)                                          │
│    → Tambah field: todayHabits BERISI regular habits + challenge habits │
│    → Challenge habits ditandai dengan flag isFromChallenge=true         │
│    → Response:                                                          │
│      {                                                                  │
│        "today_habits": [                                                │
│          { "habit_name": "Morning meditation", "is_from_challenge": false },│
│          { "habit_name": "7 Days Focus", "is_from_challenge": true,      │
│            "user_challenge_id": 5, "challenge_progress_days": 3,        │
│            "challenge_required_days": 7 }                               │
│        ]                                                                │
│      }                                                                  │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## 📝 Langkah Implementasi

### Fase 1: Modifikasi Model Data

#### 1.1 Modifikasi `TodayHabit` (dashboard_response.dart)
Tambah field untuk menandai habit yang berasal dari challenge:

```dart
class TodayHabit {
  final int? userHabitId;
  final String? habitName;
  final int? streak;
  final bool? isCompletedToday;
  // === FIELD BARU ===
  final bool? isFromChallenge;        // Apakah habit ini dari challenge
  final int? userChallengeId;         // ID reference ke UserChallenge (nullable)
  final int? challengeProgressDays;    // Progress hari ke-N dari challenge
  final int? challengeRequiredDays;   // Total hari challenge
  final int? diamondReward;           // Diamond reward saat selesai
}
```

####1.2 Modifikasi `UserChallenge` (user_challenge_response_model.dart)
Tambah field untuk menyimpan diamond reward:

```dart
class UserChallenge {
  final int id;
  final int challengeId;
  final String name;
  final String description;
  final int progressDays;
  final int requiredDays;
  final String status; // 'active', 'completed', 'failed'
  final String? lastProgressDate;
  final bool isCheckedToday;
  // === FIELD BARU ===
  final int diamondReward;  // Diamond yang akan didapat saat selesai
}
```

#### 1.3 Buat Model `ChallengeHabitRequest` (user_challenge_request_model.dart)
Tambah request model untuk revive:

```dart
class UserChallengeRequestModel {
  final int challengeId;
  // Tidak ada perubahan untuk join
}

class ReviveChallengeRequestModel {
  // Tidak perlu body, cukup ID di URL
  // Tapi kita bisa tambahkan untuk konsistensi
}
```

---

### Fase 2: Modifikasi Local Datasource

#### 2.1 Modifikasi `DashboardLocalDatasource`
Tambah kolom baru di tabel `today_habits`:

```sql
CREATE TABLE today_habits(
  user_habit_id INTEGER PRIMARY KEY AUTOINCREMENT,
  habit_name TEXT NOT NULL,
  streak INTEGER DEFAULT 0,
  is_completed_today INTEGER DEFAULT 0,
  -- === KOLOM BARU ===
  is_from_challenge INTEGER DEFAULT 0,
  user_challenge_id INTEGER,
  challenge_progress_days INTEGER DEFAULT 0,
  challenge_required_days INTEGER DEFAULT 0,
  diamond_reward INTEGER DEFAULT 0
)
```

Update fungsi:
- `cacheDashboard()` → parse field baru dari API
- `getLocalDashboard()` → return field baru
- `toggleLocalHabitStatus()` → JIKA `is_from_challenge == true`, JANGAN ubah diamond

#### 2.2 Modifikasi `UserChallengeLocalDatasource`
Tambah field `diamondReward` ke cache:

```dart
Future<void> cacheUserChallenges(List<UserChallenge> challenges) async {
  // Sudah OK, dariMap UserChallenge akan parse diamondReward
}
```

---

### Fase 3: Modifikasi Repository

#### 3.1 Modifikasi `DashboardRepository`
Update fungsi `toggleHabitStatus()`:

```dart
Future<Either<String, bool>> toggleHabitStatus(int userHabitId, bool currentStatus, {bool isFromChallenge = false}) async {
  // ... existing code ...

  // JIKA habit dari challenge, DIAMOND TIDAK BERUBAH
  if (!isFromChallenge) {
    // Update diamond seperti biasa (+10 / -10)
  }
}
```

Update fungsi `addHabit()`:
- Dipanggil saat challenge selesai → tambahkan habit permanen baru

#### 3.2 Modifikasi `UserChallengeRepository`
Tambah fungsi baru:

```dart
// Delete/Abandon Challenge
Future<Either<String, bool>> abandonChallenge(int id) async {
  try {
    final result = await remoteDatasource.abandonChallenge(id);
    return Right(result);
  } catch (e) {
    return Left(e.toString());
  }
}
```

---

### Fase 4: Modifikasi Remote Datasource

#### 4.1 Modifikasi `UserChallengeRemoteDatasource`
Tambah fungsi baru:

```dart
// DELETE /api/user-challenges/{id} — Abandon/hapus challenge
Future<bool> abandonChallenge(int id) async {
  try {
    final headers = await _getHeaders();
    final response = await http.delete(
      Uri.parse('${Variable.baseUrl}/api/user-challenges/$id'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal menghapus tantangan');
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
```

---

### Fase 5: Modifikasi BLoC

#### 5.1 Modifikasi `UserChallengeBloc`
Tambah event dan handler baru:

```dart
// Event baru di user_challenge_event.dart
part of 'user_challenge_bloc.dart';

@freezed
class UserChallengeEvent with _$UserChallengeEvent {
  const factory UserChallengeEvent.started() = _Started;
  const factory UserChallengeEvent.fetchUserChallenges() = _FetchUserChallenges;
  const factory UserChallengeEvent.joinChallenge(int challengeId) = _JoinChallenge;
  const factory UserChallengeEvent.checkInChallenge(int id) = _CheckInChallenge;
  const factory UserChallengeEvent.reviveChallenge(int id) = _ReviveChallenge;
  // === EVENT BARU ===
  const factory UserChallengeEvent.abandonChallenge(int id) = _AbandonChallenge;
}
```

Handler baru di `user_challenge_bloc.dart`:

```dart
// 5. HANDLER ABANDON CHALLENGE (Tolak revive, hapus dari list)
on<_AbandonChallenge>((event, emit) async {
  emit(const _Loading());
  final result = await _repository.abandonChallenge(event.id);
  
  await result.fold(
    (failureMessage) async => emit(_Error(failureMessage)),
    (success) async {
      await _reloadDataAfterAction(emit);
    },
  );
});
```

#### 5.2 Modifikasi `DashboardBloc`
Tambah event untuk add habit dari completed challenge:

```dart
// Event baru di dashboard_event.dart
part of 'dashboard_bloc.dart';

@freezed
class DashboardEvent with _$DashboardEvent {
  const factory DashboardEvent.fetchDashboardData({int? month}) = _FetchDashboardData;
  const factory DashboardEvent.toggleHabit(int userHabitId, bool currentStatus, {bool isFromChallenge = false}) = _ToggleHabit;
  const factory DashboardEvent.deleteHabit(int userHabitId) = _DeleteHabit;
  const factory DashboardEvent.addHabit(String name) = _AddHabit;
  const factory DashboardEvent.editHabit(int userHabitId, String newName) = _EditHabit;
  // === EVENT BARU ===
  const factory DashboardEvent.addHabitFromChallenge(String name, int userChallengeId) = _AddHabitFromChallenge;
}
```

Handler baru:

```dart
// 6. HANDLER ADD HABIT DARI COMPLETED CHALLENGE
on<_AddHabitFromChallenge>((event, emit) async {
  final result = await _dashboardRepository.addHabitFromChallenge(
    event.name,
    event.userChallengeId,
  );
  await result.fold(
    (failureMessage) async => emit(_Error(failureMessage)),
    (success) async {
      await _reloadDataAfterAction(emit);
    },
  );
});
```

---

### Fase 6: Modifikasi Repository (Lanjutan)

#### 6.1 Modifikasi `DashboardRepository`
Tambah fungsi baru:

```dart
// ADD HABIT DARI COMPLETED CHALLENGE
Future<Either<String, bool>> addHabitFromChallenge(String name, int userChallengeId) async {
  try {
    final result = await remoteDatasource.addHabitFromChallenge(name, userChallengeId);
    await localDatasource.addLocalHabit(name);
    return Right(result);
  } catch (e) {
    return Left(e.toString());
  }
}
```

Update `toggleHabitStatus()`:

```dart
Future<Either<String, bool>> toggleHabitStatus(
  int userHabitId,
  bool currentStatus, {
  bool isFromChallenge = false,
}) async {
  try {
    final result = await remoteDatasource.toggleHabitStatus(userHabitId);
    
    // JIKA habit dari challenge, TIDAK update diamond
    if (!isFromChallenge) {
      await localDatasource.toggleLocalHabitStatus(userHabitId, currentStatus);
    } else {
      // Tetap update status completion tapi tanpa ubah diamond
      await localDatasource.toggleLocalHabitStatusNoDiamond(userHabitId, currentStatus);
    }
    return Right(result);
  } catch (e) {
    // Offline fallback
    if (!isFromChallenge) {
      final localResult = await localDatasource.toggleLocalHabitStatus(userHabitId, currentStatus);
      if (localResult) return const Right(true);
    } else {
      final localResult = await localDatasource.toggleLocalHabitStatusNoDiamond(userHabitId, currentStatus);
      if (localResult) return const Right(true);
    }
    return Left("Gagal mengubah status habit: ${e.toString()}");
  }
}
```

#### 6.2 Modifikasi `DashboardRemoteDatasource`
Tambah fungsi baru:

```dart
Future<bool> addHabitFromChallenge(String name, int userChallengeId) async {
  try {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse('${Variable.baseUrl}/api/habits/from-challenge'),
      headers: headers,
      body: jsonEncode({
        'name': name,
        'user_challenge_id': userChallengeId,
      }),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Gagal membuat habit dari challenge');
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

Future<bool> toggleHabitStatus(int userHabitId) async {
  // Existing code...
}
```

#### 6.3 Modifikasi `DashboardLocalDatasource`
Tambah fungsi baru:

```dart
// TOGGLE TANPA DIAMOND (untuk challenge habit)
Future<bool> toggleLocalHabitStatusNoDiamond(int userHabitId, bool currentStatus) async {
  try {
    final db = await instance.database;
    int newStatus = currentStatus ? 0 : 1;

    await db.update(
      tableHabits,
      {'is_completed_today': newStatus},
      where: 'user_habit_id = ?',
      whereArgs: [userHabitId],
    );

    // Update hitungan summary TANPA ubah diamond
    final List<Map<String, dynamic>> summaryMaps = await db.query(
      tableSummary,
      where: 'id = ?',
      whereArgs: [1],
    );
    if (summaryMaps.isNotEmpty) {
      int currentCompleted = summaryMaps.first['habits_completed_today'] ?? 0;
      int newCompleted = currentStatus
          ? (currentCompleted - 1)
          : (currentCompleted + 1);

      await db.update(
        tableSummary,
        {
          'habits_completed_today': newCompleted < 0 ? 0 : newCompleted,
          // DIAMOND TIDAK DIUBAH
        },
        where: 'id = ?',
        whereArgs: [1],
      );
    }

    return true;
  } catch (e) {
    return false;
  }
}

// ADD HABIT DARI CHALLENGE
Future<bool> addLocalHabitFromChallenge(String name, int userChallengeId, int diamondReward) async {
  try {
    final db = await instance.database;
    await db.insert(tableHabits, {
      'habit_name': name,
      'streak': 0,
      'is_completed_today': 0,
      'is_from_challenge': 1,
      'user_challenge_id': userChallengeId,
      'challenge_progress_days': 0,
      'challenge_required_days': 0,
      'diamond_reward': diamondReward,
    });

    await db.rawUpdate(
      'UPDATE $tableSummary SET habits_total = habits_total + 1 WHERE id = 1',
    );
    return true;
  } catch (e) {
    return false;
  }
}
```

---

### Fase 7: Modifikasi UI

#### 7.1 Modifikasi `ChallengeDetailPage`
Hubungkan tombol "Add to my routine" ke BLoC:

```dart
// Di ChallengeDetailPage
CustomButton(
  text: 'Add to my routine',
  onTap: () {
    // Panggil BLoC untuk join challenge
    context.read<UserChallengeBloc>().add(
      UserChallengeEvent.joinChallenge(widget.challenge.id),
    );
    
    // Tampilkan snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('"${widget.challenge.title}" added to your routine!'),
        backgroundColor: Colors.green,
      ),
    );
    
    // Kembali ke halaman sebelumnya
    Navigator.pop(context);
  },
),
```

#### 7.2 Modifikasi `HomePage`
Update section habit untuk menampilkan challenge habits:

```dart
// Di _buildHabitSection, mapping data dari BLoC:
...habits.take(2).map((habit) {
  return _buildHabitItem(
    context, 
    habit.isFromChallenge == true ? '🏆' : '📝',  // Emoji berbeda untuk challenge
    habit.habitName ?? 'No Title',
    isTutorial: habit == habits.first,
    onDelete: () {
      if (habit.isFromChallenge == true && habit.userChallengeId != null) {
        // Konfirmasi hapus challenge habit
        _showAbandonChallengeDialog(context, habit.userChallengeId);
      } else {
        // Hapus habit biasa
        context.read<DashboardBloc>().add(DeleteHabitEvent(habit.userHabitId));
      }
    }
  );
}).toList(),
```

#### 7.3 Modifikasi `ActiveHabitListPage`
Tambahkan dialog konfirmasi untuk abandon challenge:

```dart
void _showAbandonChallengeDialog(BuildContext context, int userChallengeId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: const Color(0xFF332218),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Abandon Challenge?',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'This challenge will be removed from your routine.\nYou can re-join it anytime from the challenge list.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        // Panggil BLoC untuk abandon
                        context.read<UserChallengeBloc>().add(
                          UserChallengeEvent.abandonChallenge(userChallengeId),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE6A84A), width: 1.5),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Abandon',
                          style: TextStyle(color: Color(0xFFE6A84A), fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4A3424),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
```

#### 7.4 Modifikasi `ActiveChallengeListPage`
Update untuk baca dari `UserChallengeBloc` dan tampilkan dialog revive:

```dart
// Di build method:
BlocBuilder<UserChallengeBloc, UserChallengeState>(
  builder: (context, state) {
    return state.when(
      initial: () => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (message) => Center(child: Text("Error: $message")),
      needRevive: (id, message) => _buildReviveDialog(context, id, message),
      success: (challenges) => _buildChallengeList(challenges),
    );
  },
)

// Dialog Revive:
void _showReviveDialog(BuildContext context, int id, String message) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return Dialog(
        backgroundColor: const Color(0xFF332218),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 48),
              const SizedBox(height: 16),
              const Text(
                'Challenge Failed!',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(dialogContext);
                        // Panggil BLoC untuk revive (biaya 3 diamond)
                        context.read<UserChallengeBloc>().add(
                          UserChallengeEvent.reviveChallenge(id),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF1CB0F6), width: 1.5),
                        ),
                        alignment: Alignment.center,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.diamond, color: Color(0xFF1CB0F6), size: 18),
                            SizedBox(width: 4),
                            Text(
                              'Revive (-3💎)',
                              style: TextStyle(color: Color(0xFF1CB0F6), fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(dialogContext);
                        // Panggil BLoC untuk abandon
                        context.read<UserChallengeBloc>().add(
                          UserChallengeEvent.abandonChallenge(id),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4A3424),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Abandon',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
```

#### 7.5 Modifikasi `FindPage`
Update section "Routine" untuk menampilkan active challenges dari BLoC:

```dart
// Tambah BlocBuilder untuk UserChallengeBloc
BlocBuilder<UserChallengeBloc, UserChallengeState>(
  builder: (context, state) {
    return state.when(
      initial: () => const SizedBox.shrink(),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_) => const SizedBox.shrink(),
      needRevive: (_, __) => const SizedBox.shrink(),
      success: (challenges) {
        // Filter hanya challenge yang statusnya 'active'
        final activeChallenges = challenges.where((c) => c.status == 'active').toList();
        if (activeChallenges.isEmpty) return const SizedBox.shrink();
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeaderWithChip('My Routine', 'assets/images/kalender.png'),
            _buildHorizontalChallengeList(activeChallenges),
 ],
        );
      },
    );
  },
)
```

---

### Fase 8: Modifikasi Backend (Laravel) - Catatan untuk Developer Backend

> **NOTE:** modifications di backend harus dilakukan oleh developer backend. Di sini saya hanya mencatat endpoint yang perlu diubah/ditambahkan.

#### 8.1 Endpoint `POST /api/user-challenges/join`
- Input: `{ "challenge_id": int }`
- Logic:
  1. Ambil `Challenge` berdasarkan `challenge_id`
  2. Buat record `UserChallenge` baru dengan:
     - `progress_days = 0`
     - `status = 'active'`
     - `last_progress_date = null`
 3. Return `UserChallenge` yang baru dibuat

#### 8.2 Endpoint `POST /api/user-challenges/check/{id}`
- Input: `user_challenge_id` di URL
- Logic:
  1. Ambil `UserChallenge` berdasarkan ID
  2. Cek apakah `last_progress_date` adalah kemarin
     - Jika `last_progress_date` null (hari pertama) → OK
     - Jika `last_progress_date` != yesterday → throw "failed_streak"
  3. Update:
     - `progress_days += 1`
     - `last_progress_date = today`
     - `is_checked_today = true`
  4. Jika `progress_days == required_days`:
     - `status = 'completed'`
     - Berikan diamond reward ke user
     - Buat habit permanen baru di tabel `user_habits`
  5. Return `UserChallenge` terupdate

#### 8.3 Endpoint `POST /api/user-challenges/revive/{id}`
- Input: `user_challenge_id` di URL
- Logic:
  1. Ambil `UserChallenge` berdasarkan ID
  2. Cek apakah user punya >= 3 diamond
     - Jika tidak → throw error "Insufficient diamonds"
  3. Update:
     - Kurangi 3 diamond dari user
     - `status = 'active'`
     - `last_progress_date = today` (lanjutkan, bukan restart)
  4. Return `UserChallenge` terupdate

#### 8.4 Endpoint `DELETE /api/user-challenges/{id}`
- Input: `user_challenge_id` di URL
- Logic:
  1. Hapus record `UserChallenge`
  2. Challenge kembali tersedia di list (tidak hard delete `Challenge`)

#### 8.5 Endpoint `GET /api/dashboard`
- Update response `today_habits`:
```json
{
  "today_habits": [
    {
      "user_habit_id": 1,
      "habit_name": "Morning meditation",
      "streak": 5,
      "is_completed_today": false,
      "is_from_challenge": false
    },
    {
      "user_habit_id": 2,
      "habit_name": "7 Days Focus",
      "streak": 3,
      "is_completed_today": false,
      "is_from_challenge": true,
      "user_challenge_id": 5,
      "challenge_progress_days": 3,
      "challenge_required_days": 7,
      "diamond_reward": 50
    }
  ]
}
```

#### 8.6 Endpoint `POST /api/habits/from-challenge` (BARU)
- Input: `{ "name": string, "user_challenge_id": int }`
- Logic:
  1. Ambil `UserChallenge` berdasarkan ID
  2. Buat habit baru di `user_habits` dengan:
     - `habit_name = name`
     - `is_from_challenge = true`
     - `user_challenge_id = user_challenge_id`
  3. Return habit baru

---

## 📊 Ringkasan Perubahan File

### Frontend (Flutter)

| No | File | Perubahan |
|----|------|-----------|
| 1 | `lib/core/data/model/response/dashboard_response.dart` | Tambah field di `TodayHabit` |
| 2 | `lib/core/data/model/response/user_challenge_response_model.dart` | Tambah field `diamondReward` |
| 3 | `lib/core/data/datasource/dashboard_local_datasource.dart` | Tambah kolom, fungsi baru |
| 4 | `lib/core/data/datasource/user_challenge_remote_datasource.dart` | Tambah fungsi `abandonChallenge` |
| 5 | `lib/core/data/repositories/dashboard_repository.dart` | Update toggle, tambah fungsi baru |
| 6 | `lib/core/data/repositories/user_challenge_repository.dart` | Tambah fungsi `abandonChallenge` |
| 7 | `lib/core/presentation/home/bloc/dashboard/dashboard_event.dart` | Tambah event baru |
| 8 | `lib/core/presentation/home/bloc/dashboard/dashboard_bloc.dart` | Tambah handler baru |
| 9 | `lib/core/presentation/home/bloc/user_challenge/user_challenge_event.dart` | Tambah event baru |
| 10 | `lib/core/presentation/home/bloc/user_challenge/user_challenge_bloc.dart` | Tambah handler baru |
| 11 | `lib/pages/challenge/challenge_detail_page.dart` | Hubungkan ke BLoC |
| 12 | `lib/pages/home/home_page.dart` | Tampilkan challenge habits |
| 13 | `lib/pages/challenge/widgets/active_challenge_list_page.dart` | Baca dari BLoC, dialog revive |
| 14 | `lib/pages/challenge/find_page.dart` | Update section Routine |

### Backend (Laravel) - untuk developer backend

| No | Endpoint | Perubahan |
|----|----------|-----------|
| 1 | `POST /api/user-challenges/join` | Logic join challenge |
| 2 | `POST /api/user-challenges/check/{id}` | Logic check-in + streak validation |
| 3 | `POST /api/user-challenges/revive/{id}` | Logic revive (-3 diamond) |
| 4 | `DELETE /api/user-challenges/{id}` | Logic abandon challenge |
| 5 | `GET /api/dashboard` | Tambah field `is_from_challenge` dll |
| 6 | `POST /api/habits/from-challenge` | Buat habit dari completed challenge |

---

## ⚠️ Catatan Penting

1. **Diamond untuk Revive = 3** (sesuai request user, bukan 5 yang ada di kode sekarang)
2. **Diamond reward challenge** = sesuai `diamondReward` di `ChallengeData` (default 50)
3. **TIDAK ada diamond per-check-in** untuk challenge habit (beda dengan regular habit)
4. **Revive melanjutkan hari**, BUKAN restart dari awal
5. **Completed challenge** otomatis membuat habit permanen baru

---

## ❓ Pertanyaan untuk User

Sebelum implementasi, saya perlu klarifikasi:

1. **Durasi revive**: Apakah biaya revive 3 diamond sudah pasti, atau mau dibuat configurable?
2. **Diamond reward**: Apakah diamond reward challenge (`diamondReward` di `ChallengeData`) sudah final, atau mau ada variasi per challenge?
3. **Habit name saat completed**: Dari mana nama habit permanen diambil? Dari `title` challenge atau ada input dari user?
