/// Discover screen — opportunity browsing and search.
///
/// Provides the interface for discovering freelance opportunities
/// across various platforms. Will contain search, filtering,
/// and AI-powered opportunity matching.
library;

import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Placeholder discover screen.
///
/// ## Future Implementation
/// - Opportunity search bar with filters
/// - Category-based browsing
/// - AI-matched opportunity feed
/// - Saved opportunity bookmarks
/// - Real-time opportunity alerts
class DiscoverScreen extends StatelessWidget {
  /// Creates the discover screen.
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Discover',
          style: textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Implement search.
            },
            icon: const Icon(Icons.search_rounded),
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
                Icons.explore_outlined,
                size: 80,
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Discover Opportunities',
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Search and browse freelance opportunities matched by AI to your skills.',
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
