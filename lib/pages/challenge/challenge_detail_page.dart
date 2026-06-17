import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:mino/models/challenge_data.dart';
import 'package:mino/providers/challenge_provider.dart';
import 'package:mino/core/presentation/home/bloc/user_challenge/user_challenge_bloc.dart';
import 'package:mino/widgets/appbars/custom_appbar.dart';
import 'package:mino/widgets/button/custom_button.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/widgets/popUP/pop_up_berhasil.dart'; 
import 'package:mino/widgets/popUp/pop_up_gagal.dart';

class ChallengeDetailPage extends StatefulWidget {
  final int challengeId;

  const ChallengeDetailPage({super.key, required this.challengeId});

  @override
  State<ChallengeDetailPage> createState() => _ChallengeDetailPageState();
}

class _ChallengeDetailPageState extends State<ChallengeDetailPage> {
  ChallengeData? lockedChallenge;

  @override
  void initState() {
    super.initState();
    final provider = context.read<ChallengeProvider>();
    lockedChallenge = provider.getChallengeById(widget.challengeId);
  }

  // ── FUNGSI ANIMASI TOP SLIDE POPUP & AUTO CLOSE ──
  void _showTopNotification({required BuildContext context, required Widget child}) {
    bool isClosed = false; 

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black.withOpacity(0.2), 
      transitionDuration: const Duration(milliseconds: 400), 
      pageBuilder: (dialogContext, anim1, anim2) {
        return const SizedBox.shrink();
      },
      transitionBuilder: (dialogContext, anim1, anim2, widgetChild) {
        final tween = Tween<Offset>(begin: const Offset(0, -1), end: const Offset(0, 0));
        
        return SlideTransition(
          position: tween.animate(CurvedAnimation(parent: anim1, curve: Curves.easeOutBack)),
          child: SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Material(
                  color: Colors.transparent,
                  child: child,
                ),
              ),
            ),
          ),
        );
      },
    ).then((_) {
      isClosed = true;
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!isClosed && context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final challengeProvider = context.watch<ChallengeProvider>();
    final currentChallenge = lockedChallenge ?? challengeProvider.getChallengeById(widget.challengeId);

    if (currentChallenge == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text('Challenge not found', style: TextStyle(color: Colors.white)),
        ),
      );
    }

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.coklat900,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_login.png',
              fit: BoxFit.cover,
              gaplessPlayback: true,
            ),
          ),
          
          SafeArea(
            child: Column(
              children: [
                CustomAppBar(
                  title: currentChallenge.title,
                  showBackButton: true,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: _buildChallengeImage(currentChallenge.detailImageAsset),
                        ),
                        const SizedBox(height: 24),
                        
                        Row(
                          children: [
                            _buildChip(
                              assetPath: 'assets/images/diamond.png',
                              label: '${currentChallenge.diamondReward} Diamonds',
                              textColor: const Color(0xFFE6A84A),
                              bgColor: const Color(0xFFE6A84A).withAlpha((0.12 * 255).toInt()),
                            ),
                            const SizedBox(width: 12),
                            _buildChip(
                              assetPath: 'assets/images/calendar.png',
                              label: '${currentChallenge.durationDays} Days',
                              textColor: Colors.white,
                              bgColor: Colors.white.withAlpha((0.1 * 255).toInt()),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        
                        const Text(
                          'Description',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          currentChallenge.description,
                          style: TextStyle(
                            color: Colors.white.withAlpha((0.75 * 255).toInt()),
                            fontSize: 14,
                            height: 1.6,
                          ),
                        ),
                        // Dikurangi dikit jarak scroll bawahnya karena tombolnya sudah turun
                        const SizedBox(height: 80), 
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── BLOCK BUTTON UTAMA DENGAN POPUP KUSTOM ──
          Positioned(
            bottom: 30, // 🛠️ DIUBAH DI SINI (Dari 100 ke 30 agar lebih ke bawah)
            left: 24,
            right: 24,
            child: BlocConsumer<UserChallengeBloc, UserChallengeState>(
              listener: (context, state) {
                state.maybeWhen(
                  success: (_) {
                    _showTopNotification(
                      context: context,
                      child: PopUpBerhasil(
                        message: '"${currentChallenge.title}" has been added to your routine!',
                        onClose: () => Navigator.of(context, rootNavigator: true).pop(),
                      ),
                    );
                  },
                  error: (message) {
                    _showTopNotification(
                      context: context,
                      child: PopUpGagal(
                        message: message, 
                        onClose: () => Navigator.of(context, rootNavigator: true).pop(),
                      ),
                    );
                  },
                  orElse: () {},
                );
              },
              builder: (context, state) {
                bool alreadyAdded = false;

                state.maybeWhen(
                  success: (userChallengesList) {
                    alreadyAdded = userChallengesList.any((uc) => uc.challengeId == currentChallenge.id);
                  },
                  orElse: () {},
                );

                return SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CustomButton(
                    text: alreadyAdded ? 'Already in My Routine ' : 'Add to my routine',
                    onTap: () {
                      if (alreadyAdded) {
                        _showTopNotification(
                          context: context,
                          child: PopUpGagal(
                            message: 'This challenge is already in your routine!',
                            onClose: () => Navigator.of(context, rootNavigator: true).pop(),
                          ),
                        );
                        return;
                      }

                      context.read<UserChallengeBloc>().add(
                            UserChallengeEvent.joinChallenge(currentChallenge.id),
                          );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip({
    required String assetPath,
    required String label,
    required Color textColor,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            assetPath,
            width: 16,
            height: 16,
            errorBuilder: (context, error, stackTrace) =>
                Icon(Icons.star, size: 16, color: textColor),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChallengeImage(String assetPath) {
    final imagePath = assetPath.isNotEmpty ? assetPath : 'assets/images/clean.png';
    return Image.asset(
      imagePath,
      fit: BoxFit.cover,
      width: double.infinity,
      height: 200,
      alignment: Alignment.topCenter,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: 200,
          color: Colors.white12,
          child: const Center(
            child: Icon(Icons.image, size: 50, color: Colors.white30),
          ),
        );
      },
    );
  }
}