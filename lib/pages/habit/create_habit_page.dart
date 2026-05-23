import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

import '../../widgets/textfields/custom_textfield.dart';

class CreateHabitPage extends StatelessWidget {
  const CreateHabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController =
        TextEditingController();

    final subtitleController =
        TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.coklat900,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        title: Text(
          'Create Habit',
          style: AppTextStyles.pageTitleBold,
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(
          AppSizes.lg,
        ),

        child: Column(
          children: [
            CustomTextField(
              controller: titleController,
              hintText: 'Habit title',
            ),

            const SizedBox(height: AppSizes.lg),

            CustomTextField(
              controller: subtitleController,
              hintText: 'Description',
              maxLines: 4,
            ),

            const Spacer(),

            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },

              child: Container(
                width: double.infinity,
                height: 58,

                decoration: BoxDecoration(
                  color: AppColors.orange500,

                  borderRadius: BorderRadius.circular(
                    AppSizes.radiusLg,
                  ),
                ),

                alignment: Alignment.center,

                child: Text(
                  'Save Habit',

                  style: AppTextStyles.bodyMedium
                      .copyWith(
                    color: AppColors.coklat900,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}