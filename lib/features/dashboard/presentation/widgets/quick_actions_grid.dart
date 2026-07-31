/// Interactive AI Tools Launcher Grid — Master Design System V2.0.
library;

import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/quick_action_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Interactive AI Tools Launcher grid section.
class QuickActionsGrid extends StatelessWidget {
  /// Creates a [QuickActionsGrid].
  const QuickActionsGrid({
    required this.actions,
    super.key,
  });

  /// Injected action items.
  final List<QuickActionModel> actions;

  void _onToolPressed(BuildContext context, String route) {
    if (route.isNotEmpty) {
      context.goNamed(RouteNames.aiStudio);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'AI Workspace Launcher',
          style: TextStyle(
            color: Color(0xFF111827),
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 14.0),
        LayoutBuilder(
          builder: (context, constraints) {
            final isPhone = constraints.maxWidth < 600;
            final isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 1024;
            final crossAxisCount = isPhone ? 2 : (isTablet ? 3 : 6);

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 12.0,
                crossAxisSpacing: 12.0,
                childAspectRatio: isPhone ? 1.15 : 1.3,
              ),
              itemCount: actions.length,
              itemBuilder: (context, index) {
                final item = actions[index];
                return Material(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16.0),
                  child: InkWell(
                    onTap: () => _onToolPressed(context, item.route),
                    borderRadius: BorderRadius.circular(16.0),
                    child: Container(
                      padding: EdgeInsets.all(isPhone ? 12.0 : 16.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0D1B2A).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Icon(
                                  item.icon,
                                  size: 18,
                                  color: const Color(0xFF0D1B2A),
                                ),
                              ),
                              if (item.badgeCount != null && item.badgeCount! > 0)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6.0,
                                    vertical: 2.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFF6B6B),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Text(
                                    '${item.badgeCount}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.label,
                                style: const TextStyle(
                                  color: Color(0xFF111827),
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w700,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2.0),
                              Text(
                                item.isFeatured ? 'Featured AI Tool' : 'Tap to open',
                                style: const TextStyle(
                                  color: Color(0xFF6B7280),
                                  fontSize: 11.0,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
