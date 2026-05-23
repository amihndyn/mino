import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';

class ChartWidget extends StatelessWidget {
  final List<double> values;

  const ChartWidget({
    super.key,
    required this.values,
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

        children: values.map((value) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
              ),

              child: Container(
                height:
                    (value / maxValue) * 140,

                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(
                    20,
                  ),

                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,

                    colors: [
                      AppColors.orange300,
                      AppColors.orange700,
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}