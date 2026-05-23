import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

import '../../widgets/textfields/custom_textfield.dart';

class EditHabitPage extends StatefulWidget {
  const EditHabitPage({super.key});

  @override
  State<EditHabitPage> createState() =>
      _EditHabitPageState();
}

class _EditHabitPageState
    extends State<EditHabitPage> {
  late TextEditingController
      titleController;

  late TextEditingController
      subtitleController;

  @override
  void initState() {
    super.initState();

    titleController =
        TextEditingController(
      text: 'Morning Run',
    );

    subtitleController =
        TextEditingController(
      text:
          'Run 5km every morning',
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    subtitleController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.coklat900,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        title: Text(
          'Edit Habit',
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
              controller:
                  subtitleController,

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
                  color:
                      AppColors.orange500,

                  borderRadius:
                      BorderRadius.circular(
                    AppSizes.radiusLg,
                  ),
                ),

                alignment: Alignment.center,

                child: Text(
                  'Update Habit',

                  style: AppTextStyles
                      .bodyMedium
                      .copyWith(
                    color:
                        AppColors.coklat900,
                    fontWeight:
                        FontWeight.bold,
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