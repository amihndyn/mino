import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

class ActivityChart extends StatelessWidget {
  final List<double> values;
  final List<String> labels;

  const ActivityChart({
    super.key,
    required this.values,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    final maxValue = values.reduce(
      (a, b) => a > b ? a : b,
    );

    return Container(
      padding: const EdgeInsets.all(
        AppSizes.lg,
      ),

      decoration: BoxDecoration(
        color: AppColors.coklat800,

        borderRadius: BorderRadius.circular(
          AppSizes.cardRadius,
        ),

        border: Border.all(
          color: AppColors.coklat600,
        ),
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.end,

        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

        children: List.generate(
          values.length,
          (index) {
            final value = values[index];

            return Expanded(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.end,

                children: [
                  Container(
                    height:
                        (value / maxValue) * 120,

                    width: 20,

                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(
                        20,
                      ),

                      gradient: LinearGradient(
                        begin:
                            Alignment.topCenter,
                        end:
                            Alignment.bottomCenter,

                        colors: [
                          AppColors.orange300,
                          AppColors.orange700,
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: AppSizes.sm,
                  ),

                  Text(
                    labels[index],

                    style: AppTextStyles.caption
                        .copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}