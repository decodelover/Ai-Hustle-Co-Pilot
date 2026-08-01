/// Accessible analytics trend card derived from dashboard workspace signals.
library;

import 'dart:math' as math;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_radius.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/dashboard_state.dart';
import 'package:ai_hustle_copilot/features/dashboard/presentation/widgets/dashboard_surface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Shows productivity momentum with a timeframe selector and readable summary.
class AnalyticsChartsSection extends StatelessWidget {
  /// Creates an [AnalyticsChartsSection].
  const AnalyticsChartsSection({
    required this.selectedTimeframe,
    required this.onTimeframeChanged,
    this.productivityScore,
    this.activeProjects,
    super.key,
  });

  final ChartTimeframe selectedTimeframe;
  final ValueChanged<ChartTimeframe> onTimeframeChanged;
  final int? productivityScore;
  final int? activeProjects;

  @override
  Widget build(BuildContext context) {
    final score = (productivityScore ?? 0).clamp(0, 100);
    final compact = MediaQuery.sizeOf(context).width < 600;
    return DashboardSurface(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DashboardSectionHeader(
            eyebrow: 'Analytics',
            title: 'Productivity momentum',
            subtitle: 'A clear signal from your active workspace.',
          ),
          const SizedBox(height: AppSpacing.space20),
          _TimeframeSelector(
            selected: selectedTimeframe,
            onChanged: onTimeframeChanged,
          ),
          const SizedBox(height: AppSpacing.space24),
          if (score == 0)
            const _AnalyticsEmptyState()
          else ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$score',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: -1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.space8),
                  child: Text(
                    ' / 100',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.space8,
                    vertical: AppSpacing.space4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.10),
                    borderRadius: AppRadius.borderPill,
                  ),
                  child: Text(
                    'Strong signal',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.space16),
            Semantics(
              image: true,
              label:
                  'Productivity trend ending at $score out of 100 for the selected timeframe.',
              child: SizedBox(
                height: compact ? 150 : 190,
                width: double.infinity,
                child: CustomPaint(
                  painter: _TrendChartPainter(
                    score: score,
                    timeframe: selectedTimeframe,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.space12),
            Row(
              children: [
                const Icon(
                  CupertinoIcons.briefcase,
                  size: 16,
                  color: AppColors.secondary,
                ),
                const SizedBox(width: AppSpacing.space8),
                Expanded(
                  child: Text(
                    '${activeProjects ?? 0} active project${activeProjects == 1 ? '' : 's'} contributing to your momentum',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _TimeframeSelector extends StatelessWidget {
  const _TimeframeSelector({required this.selected, required this.onChanged});
  final ChartTimeframe selected;
  final ValueChanged<ChartTimeframe> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<ChartTimeframe>(
      segments: const [
        ButtonSegment(value: ChartTimeframe.weekly, label: Text('Week')),
        ButtonSegment(value: ChartTimeframe.monthly, label: Text('Month')),
        ButtonSegment(value: ChartTimeframe.yearly, label: Text('Year')),
      ],
      selected: {selected},
      showSelectedIcon: false,
      onSelectionChanged: (values) => onChanged(values.first),
      style: const ButtonStyle(
        visualDensity: VisualDensity.comfortable,
        minimumSize: WidgetStatePropertyAll(
          Size(72, AppSpacing.minTouchTarget),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: AppRadius.borderPill),
        ),
      ),
    );
  }
}

class _AnalyticsEmptyState extends StatelessWidget {
  const _AnalyticsEmptyState();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.space24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: AppRadius.borderLarge,
      ),
      child: Column(
        children: [
          const Icon(
            CupertinoIcons.chart_bar_alt_fill,
            color: AppColors.secondary,
            size: 32,
          ),
          const SizedBox(height: AppSpacing.space12),
          Text(
            'Your trend starts here',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.space4),
          Text(
            'Complete focused work to unlock a useful productivity signal.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _TrendChartPainter extends CustomPainter {
  const _TrendChartPainter({required this.score, required this.timeframe});
  final int score;
  final ChartTimeframe timeframe;

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = AppColors.outline.withValues(alpha: 0.60)
      ..strokeWidth = 1;
    for (var index = 0; index < 4; index++) {
      final y = size.height * index / 3;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final count = timeframe == ChartTimeframe.weekly
        ? 7
        : timeframe == ChartTimeframe.monthly
        ? 10
        : 12;
    final path = Path();
    for (var index = 0; index < count; index++) {
      final progress = index / (count - 1);
      final baseline = math.max(18, score - 24 + progress * 24);
      final variation = math.sin(index * 1.7) * 6;
      final value = (baseline + variation).clamp(8, 98);
      final point = Offset(
        progress * size.width,
        size.height * (1 - value / 100),
      );
      index == 0
          ? path.moveTo(point.dx, point.dy)
          : path.lineTo(point.dx, point.dy);
    }
    final fill = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas
      ..drawPath(
        fill,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.secondary.withValues(alpha: 0.24),
              Colors.transparent,
            ],
          ).createShader(Offset.zero & size),
      )
      ..drawPath(
        path,
        Paint()
          ..shader = const LinearGradient(
            colors: [AppColors.secondary, AppColors.primaryDarkBlue],
          ).createShader(Offset.zero & size)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round,
      );
  }

  @override
  bool shouldRepaint(covariant _TrendChartPainter oldDelegate) =>
      oldDelegate.score != score || oldDelegate.timeframe != timeframe;
}
