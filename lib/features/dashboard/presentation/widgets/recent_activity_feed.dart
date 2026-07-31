/// AI Activity Timeline Feed — Master Design System V2.0.
library;

import 'package:ai_hustle_copilot/features/dashboard/domain/models/activity_feed_model.dart';
import 'package:flutter/material.dart';

/// Real-time activity timeline feed.
class RecentActivityFeed extends StatelessWidget {
  /// Creates a [RecentActivityFeed].
  const RecentActivityFeed({
    required this.activities,
    super.key,
  });

  /// Injected activity items.
  final List<ActivityFeedModel> activities;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'AI Activity Timeline',
                style: TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                ),
              ),
              Text(
                '${activities.length} items',
                style: const TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: activities.length,
            separatorBuilder: (context, index) => const SizedBox(height: 14.0),
            itemBuilder: (context, index) {
              final item = activities[index];

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D1B2A).withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      item.icon,
                      size: 18,
                      color: const Color(0xFF0D1B2A),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: const TextStyle(
                            color: Color(0xFF111827),
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          item.description,
                          style: const TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
