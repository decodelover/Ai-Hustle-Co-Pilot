/// Analytics Charts Section — Master Design System V2.0.
library;

import 'package:ai_hustle_copilot/features/dashboard/domain/models/dashboard_state.dart';
import 'package:flutter/material.dart';

/// Reusable analytics chart container supporting Weekly, Monthly, and Yearly timeframe switches.
class AnalyticsChartsSection extends StatelessWidget {
  /// Creates an [AnalyticsChartsSection].
  const AnalyticsChartsSection({
    required this.selectedTimeframe,
    required this.onTimeframeChanged,
    super.key,
  });

  /// Selected timeframe.
  final ChartTimeframe selectedTimeframe;

  /// Timeframe change callback.
  final ValueChanged<ChartTimeframe> onTimeframeChanged;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isCompact = screenWidth < 600;

    final List<String> labels;
    final List<double> heights;
    switch (selectedTimeframe) {
      case ChartTimeframe.weekly:
        labels = const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        heights = const [0.4, 0.65, 0.85, 0.5, 0.95, 0.7, 0.6];
      case ChartTimeframe.monthly:
        labels = const ['Week 1', 'Week 2', 'Week 3', 'Week 4'];
        heights = const [0.55, 0.75, 0.9, 0.8];
      case ChartTimeframe.yearly:
        labels = const ['Q1', 'Q2', 'Q3', 'Q4'];
        heights = const [0.6, 0.8, 0.75, 0.95];
    }

    const titleBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'AI Performance & Output',
          style: TextStyle(
            color: Color(0xFF111827),
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 2.0),
        Text(
          'Prompt generations vs. completed deliverables',
          style: TextStyle(
            color: Color(0xFF6B7280),
            fontSize: 12.5,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );

    final filterTabs = Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildFilterTab(
            label: 'Weekly',
            timeframe: ChartTimeframe.weekly,
          ),
          _buildFilterTab(
            label: 'Monthly',
            timeframe: ChartTimeframe.monthly,
          ),
          _buildFilterTab(
            label: 'Yearly',
            timeframe: ChartTimeframe.yearly,
          ),
        ],
      ),
    );

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isCompact) ...[
            titleBlock,
            const SizedBox(height: 14.0),
            filterTabs,
          ] else ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(child: titleBlock),
                const SizedBox(width: 12.0),
                filterTabs,
              ],
            ),
          ],
          const SizedBox(height: 24.0),

          // Animated Bar Chart Visualization
          SizedBox(
            height: 180,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(labels.length, (index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          width: isCompact ? 22 : 28,
                          height: 140 * heights[index],
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF0D1B2A),
                                Color(0xFF152A4D),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      labels[index],
                      style: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTab({
    required String label,
    required ChartTimeframe timeframe,
  }) {
    final isSelected = selectedTimeframe == timeframe;

    return InkWell(
      onTap: () => onTimeframeChanged(timeframe),
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 6.0,
        ),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0D1B2A) : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? Colors.white : const Color(0xFF6B7280),
          ),
        ),
      ),
    );
  }
}
