/// Command Center Hero Header Widget — Master Design System V2.0.
///
/// Features signature Topographic Wave Header (#0D1B2A -> #152A4D) with organic curve divider,
/// personalized dynamic greeting, PRO plan badge, AI score ring, and action CTAs.
library;

import 'package:ai_hustle_copilot/shared/widgets/topographic_wave_header.dart';
import 'package:flutter/material.dart';

/// Command center hero header widget displaying dynamic greetings, AI score, and quick actions.
class DashboardHeaderWidget extends StatelessWidget {
  /// Creates a [DashboardHeaderWidget].
  const DashboardHeaderWidget({
    required this.userName,
    required this.workspaceName,
    required this.productivityScore,
    required this.creditsRemaining,
    required this.onNewProjectPressed,
    required this.onRefreshPressed,
    super.key,
  });

  /// Active user display name.
  final String userName;

  /// Active workspace name.
  final String workspaceName;

  /// Current productivity score (0 to 100).
  final int productivityScore;

  /// Remaining AI credits.
  final int creditsRemaining;

  /// New project callback.
  final VoidCallback onNewProjectPressed;

  /// Refresh callback.
  final VoidCallback onRefreshPressed;

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isCompact = screenWidth < 600;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFF0D1B2A),
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.0),
        child: WaveHeaderWidget(
          height: isCompact ? 280.0 : 220.0,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top Meta Bar: Workspace Name + Plan Badge + Refresh
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 5.0,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.business_center_rounded,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      workspaceName,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 5.0,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF10B981).withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: const Text(
                              'PRO PLAN',
                              style: TextStyle(
                                color: Color(0xFF10B981),
                                fontSize: 10.0,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: onRefreshPressed,
                      icon: const Icon(
                        Icons.refresh_rounded,
                        color: Colors.white,
                        size: 20.0,
                      ),
                      tooltip: 'Refresh Dashboard',
                    ),
                  ],
                ),

                // Center Content: Dynamic Greeting & AI Score Ring
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '$_greeting, $userName 👋',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isCompact ? 22.0 : 26.0,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6.0),
                          const Text(
                            'Your AI Workspace is operating at peak intelligence.',
                            style: TextStyle(
                              color: Color(0xFF9CA3AF),
                              fontSize: 13.0,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),

                    if (!isCompact)
                      Row(
                        children: [
                          // AI Productivity Score Badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 10.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.15),
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.auto_awesome_rounded,
                                  color: Color(0xFFFF6B6B),
                                  size: 20.0,
                                ),
                                const SizedBox(width: 8.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'AI SCORE',
                                      style: TextStyle(
                                        color: Color(0xFF9CA3AF),
                                        fontSize: 9.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      '$productivityScore/100',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12.0),

                          // New Project Action Button
                          SizedBox(
                            height: 44.0,
                            child: ElevatedButton.icon(
                              onPressed: onNewProjectPressed,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFF0D1B2A),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18.0,
                                ),
                              ),
                              icon: const Icon(Icons.add_rounded, size: 18.0),
                              label: const Text(
                                'New Project',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),

                // Mobile Compact Secondary Row for Score & New Project CTA
                if (isCompact)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 6.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(14.0),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.15),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.auto_awesome_rounded,
                              color: Color(0xFFFF6B6B),
                              size: 16.0,
                            ),
                            const SizedBox(width: 6.0),
                            Text(
                              'AI Score: $productivityScore/100',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 36.0,
                        child: ElevatedButton.icon(
                          onPressed: onNewProjectPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF0D1B2A),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14.0,
                            ),
                          ),
                          icon: const Icon(Icons.add_rounded, size: 16.0),
                          label: const Text(
                            'New Project',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
