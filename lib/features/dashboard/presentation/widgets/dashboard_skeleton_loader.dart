/// Complete shimmer skeleton loader for Dashboard 4-state lifecycle.
library;

import 'package:ai_hustle_copilot/core/design_system/components/feedback/app_skeleton_loader.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Skeleton loader widget displaying shimmer UI placeholders during loading.
class DashboardSkeletonLoader extends StatelessWidget {
  /// Creates a [DashboardSkeletonLoader].
  const DashboardSkeletonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final columns = width < 600
        ? 2
        : width < 960
        ? 3
        : 4;
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        width < 600 ? AppSpacing.space16 : AppSpacing.space32,
        AppSpacing.space24,
        width < 600 ? AppSpacing.space16 : AppSpacing.space32,
        AppSpacing.space96,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header skeleton
          AppSkeletonLoader.card(height: width < 600 ? 380 : 300),
          const SizedBox(height: AppSpacing.xl),

          const AppSkeletonLoader(width: 180, height: 24),
          const SizedBox(height: AppSpacing.md),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              mainAxisSpacing: AppSpacing.space12,
              crossAxisSpacing: AppSpacing.space12,
              childAspectRatio: 1.1,
            ),
            itemCount: 7,
            itemBuilder: (_, _) => AppSkeletonLoader.card(),
          ),
          const SizedBox(height: AppSpacing.xl),

          // KPI Grid skeleton
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              childAspectRatio: 1.6,
            ),
            itemCount: 4,
            itemBuilder: (context, index) => AppSkeletonLoader.card(),
          ),
          const SizedBox(height: AppSpacing.xxl),

          // Chart skeleton
          AppSkeletonLoader.card(height: 240),
        ],
      ),
    );
  }
}
