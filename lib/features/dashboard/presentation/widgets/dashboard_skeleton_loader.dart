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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header skeleton
          AppSkeletonLoader.card(),
          const SizedBox(height: AppSpacing.xl),

          // Quick actions skeleton
          const AppSkeletonLoader(width: 140, height: 20),
          const SizedBox(height: AppSpacing.md),
          AppSkeletonLoader.card(height: 72),
          const SizedBox(height: AppSpacing.xl),

          // KPI Grid skeleton
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
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
