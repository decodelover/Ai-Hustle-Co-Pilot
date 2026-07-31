/// Interactive AI Recommendation Cards Panel — Master Design System V2.0.
library;

import 'package:ai_hustle_copilot/features/dashboard/domain/models/insight_card_model.dart';
import 'package:flutter/material.dart';

/// Reusable AI insights panel offering recommendations and productivity suggestions.
class AiInsightsPanel extends StatelessWidget {
  /// Creates an [AiInsightsPanel].
  const AiInsightsPanel({
    required this.insights,
    required this.onDismiss,
    required this.onToggleFavorite,
    super.key,
  });

  /// Injected insights models.
  final List<InsightCardModel> insights;

  /// Dismiss callback.
  final ValueChanged<String> onDismiss;

  /// Toggle favorite callback.
  final ValueChanged<String> onToggleFavorite;

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
          const Row(
            children: [
              Icon(
                Icons.auto_awesome_rounded,
                size: 20,
                color: Color(0xFFFF6B6B),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'AI Recommendations & Tips',
                  style: TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),

          if (insights.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'No new recommendations at this time.',
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 13.5,
                  ),
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: insights.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12.0),
              itemBuilder: (context, index) {
                final insight = insights[index];

                return Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              insight.title,
                              style: const TextStyle(
                                color: Color(0xFF111827),
                                fontSize: 14.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                iconSize: 18,
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                                onPressed: () => onToggleFavorite(insight.id),
                                icon: Icon(
                                  insight.isFavorite
                                      ? Icons.bookmark_rounded
                                      : Icons.bookmark_border_rounded,
                                  color: insight.isFavorite
                                      ? const Color(0xFF0D1B2A)
                                      : const Color(0xFF6B7280),
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              IconButton(
                                iconSize: 18,
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                                onPressed: () => onDismiss(insight.id),
                                icon: const Icon(
                                  Icons.close_rounded,
                                  color: Color(0xFF6B7280),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        insight.description,
                        style: const TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 13.0,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 14.0),
                      SizedBox(
                        height: 40.0,
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF0D1B2A),
                            side: const BorderSide(color: Color(0xFFE5E7EB)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          icon: const Icon(
                            Icons.bolt_rounded,
                            size: 16.0,
                            color: Color(0xFF0D1B2A),
                          ),
                          label: Text(
                            insight.actionLabel,
                            style: const TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
