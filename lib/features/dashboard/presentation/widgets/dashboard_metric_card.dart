/// Premium KPI card with animated value, trend, and compact sparkline.
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_motion.dart';
import 'package:ai_hustle_copilot/core/theme/app_radius.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/dashboard_metric_card_model.dart';
import 'package:ai_hustle_copilot/features/dashboard/presentation/widgets/dashboard_surface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Reusable KPI card displaying a metric and visual trend signal.
class DashboardMetricCard extends StatelessWidget {
  /// Creates a [DashboardMetricCard].
  const DashboardMetricCard({required this.model, this.onTap, super.key});

  final DashboardMetricCardModel model;
  final VoidCallback? onTap;

  IconData get _icon => switch (model.id) {
    'active_projects' => CupertinoIcons.folder,
    'documents' => CupertinoIcons.doc_text,
    'applications' => CupertinoIcons.scope,
    _ => CupertinoIcons.chart_bar,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final trendColor = model.isPositiveTrend
        ? AppColors.success
        : AppColors.danger;
    final accent = model.accentColor ?? AppColors.secondary;
    return DashboardSurface(
      onTap: onTap,
      semanticLabel: '${model.title}: ${model.value}',
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          Positioned(
            right: -10,
            bottom: -8,
            width: 132,
            height: 70,
            child: ExcludeSemantics(
              child: CustomPaint(
                painter: _SparklinePainter(
                  color: accent,
                  positive: model.isPositiveTrend,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.space16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            accent.withValues(alpha: 0.16),
                            accent.withValues(alpha: 0.05),
                          ],
                        ),
                        borderRadius: AppRadius.borderMedium,
                        border: Border.all(
                          color: accent.withValues(alpha: 0.12),
                        ),
                      ),
                      child: Icon(_icon, color: accent, size: 19),
                    ),
                    const Spacer(),
                    if (model.trendPercentage != 0)
                      _TrendPill(
                        value: model.trendPercentage,
                        color: trendColor,
                        positive: model.isPositiveTrend,
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.space16),
                Text(
                  model.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.space4),
                _AnimatedMetricValue(value: model.value),
                if (model.subtitle != null) ...[
                  const SizedBox(height: AppSpacing.space4),
                  Text(
                    model.subtitle!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedMetricValue extends StatelessWidget {
  const _AnimatedMetricValue({required this.value});
  final String value;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.headlineMedium?.copyWith(
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
    );
    if (MediaQuery.of(context).disableAnimations) {
      return Text(value, style: style);
    }
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.92, end: 1),
      duration: AppMotion.slow,
      curve: AppMotion.decelerateCurve,
      child: Text(value, style: style),
      builder: (context, animatedValue, child) => Transform.scale(
        scale: animatedValue,
        alignment: Alignment.centerLeft,
        child: child,
      ),
    );
  }
}

class _TrendPill extends StatelessWidget {
  const _TrendPill({
    required this.value,
    required this.color,
    required this.positive,
  });
  final double value;
  final Color color;
  final bool positive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space8,
        vertical: AppSpacing.space4,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: AppRadius.borderPill,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            positive
                ? CupertinoIcons.arrow_up_right
                : CupertinoIcons.arrow_down_right,
            size: 11,
            color: color,
          ),
          const SizedBox(width: AppSpacing.space4),
          Text(
            '${value.abs().toStringAsFixed(1)}%',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  const _SparklinePainter({required this.color, required this.positive});
  final Color color;
  final bool positive;

  @override
  void paint(Canvas canvas, Size size) {
    final values = positive
        ? const [0.78, 0.66, 0.72, 0.44, 0.51, 0.26, 0.34, 0.12]
        : const [0.22, 0.30, 0.26, 0.48, 0.42, 0.64, 0.58, 0.82];
    final path = Path();
    for (var index = 0; index < values.length; index++) {
      final point = Offset(
        index * size.width / (values.length - 1),
        values[index] * size.height,
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
            colors: [color.withValues(alpha: 0.15), Colors.transparent],
          ).createShader(Offset.zero & size),
      )
      ..drawPath(
        path,
        Paint()
          ..color = color.withValues(alpha: 0.65)
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round,
      );
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.positive != positive;
}
