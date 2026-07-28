/// Enterprise Opportunity Card component for displaying freelancing opportunities.
library;

import 'package:ai_hustle_copilot/core/design_system/components/cards/app_card.dart';
import 'package:ai_hustle_copilot/core/design_system/components/common/app_avatar.dart';
import 'package:ai_hustle_copilot/core/design_system/components/common/app_badge.dart';
import 'package:ai_hustle_copilot/core/design_system/components/common/app_chip.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:ai_hustle_copilot/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// Reusable opportunity card.
class AppOpportunityCard extends StatelessWidget {
  /// Creates an [AppOpportunityCard].
  const AppOpportunityCard({
    required this.title,
    required this.clientName,
    required this.budget,
    required this.postedTime,
    required this.matchScore,
    super.key,
    this.clientAvatarUrl,
    this.skills = const [],
    this.isBookmarked = false,
    this.onTap,
    this.onBookmark,
  });

  /// Job title.
  final String title;

  /// Client name.
  final String clientName;

  /// Client avatar URL.
  final String? clientAvatarUrl;

  /// Budget string.
  final String budget;

  /// Posted time text.
  final String postedTime;

  /// AI match score percentage (0-100).
  final int matchScore;

  /// Required skill tags.
  final List<String> skills;

  /// Bookmark status.
  final bool isBookmarked;

  /// Card tap callback.
  final VoidCallback? onTap;

  /// Bookmark callback.
  final VoidCallback? onBookmark;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppAvatar(
                name: clientName,
                imageUrl: clientAvatarUrl,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.space4),
                    Text(
                      '$clientName • $postedTime',
                      style: AppTypography.bodySmall.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              AppBadge(
                label: '$matchScore% Match',
                variant: matchScore >= 85
                    ? AppBadgeVariant.success
                    : matchScore >= 70
                        ? AppBadgeVariant.primary
                        : AppBadgeVariant.warning,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                budget,
                style: AppTypography.titleLarge.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (onBookmark != null)
                IconButton(
                  icon: Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    color: isBookmarked
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurfaceVariant,
                  ),
                  onPressed: onBookmark,
                  constraints: const BoxConstraints(
                    minWidth: 48,
                    minHeight: 48,
                  ),
                ),
            ],
          ),
          if (skills.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: skills
                  .take(4)
                  .map((skill) => AppChip(label: skill))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}
