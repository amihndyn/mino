import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_text_styles.dart';
import 'package:mino/pages/habit/widgets/create_habit_card.dart';
import 'package:mino/widgets/button/custom_button.dart';

class CreateUniqueHabitPage extends StatefulWidget {
  const CreateUniqueHabitPage({super.key});

  @override
  State<CreateUniqueHabitPage> createState() =>
      _CreateUniqueHabitPageState();
}

class _CreateUniqueHabitPageState
    extends State<CreateUniqueHabitPage> {
  final TextEditingController habitController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5B3420),

      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg_login.png'),
                fit: BoxFit.cover,
              ),
            ),

              child: Column(
                children: [
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,

                    children: [
                      Text(
                        "Create a unique habit",
                        style:
                            AppTextStyles.habitSectionTitle,
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },

                        child: Text(
                          "Cancel",

                          style: AppTextStyles
                              .secondaryMedium,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  CreateHabitCard(
                    controller: habitController,
                  ),

                  const SizedBox(height: 300),

                  CustomButton(
                    text: "Save",

                    onTap : () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}