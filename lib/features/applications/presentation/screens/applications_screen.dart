/// Applications screen — application tracking and management.
///
/// Provides the interface for tracking submitted applications,
/// monitoring status changes, and managing the application
/// pipeline.
library;

import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Placeholder applications screen.
///
/// ## Future Implementation
/// - Application pipeline view (applied, interviewing, offered, rejected)
/// - Application detail cards with status badges
/// - Timeline and activity log per application
/// - Follow-up reminders
/// - Success rate analytics
class ApplicationsScreen extends StatelessWidget {
  /// Creates the applications screen.
  const ApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Applications',
          style: textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Implement filter/sort.
            },
            icon: const Icon(Icons.filter_list_rounded),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: AppSpacing.paddingAllLg,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.work_outline_rounded,
                size: 80,
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Track Applications',
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Monitor your application pipeline, track statuses, and manage follow-ups.',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
