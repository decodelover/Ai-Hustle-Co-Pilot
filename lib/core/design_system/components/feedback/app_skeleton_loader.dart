/// Reusable Skeleton Shimmer Loader for AI Hustle Co-Pilot design system.
library;

import 'package:ai_hustle_copilot/core/design_system/tokens/app_colors.dart';
import 'package:ai_hustle_copilot/core/design_system/tokens/app_radius.dart';
import 'package:flutter/material.dart';

/// Shimmer loading placeholder for text, cards, avatars, and containers.
class AppSkeletonLoader extends StatefulWidget {
  const AppSkeletonLoader({
    super.key,
    this.width,
    this.height = 16.0,
    this.borderRadius = AppRadius.borderRadiusSm,
  });

  /// Factory for circular avatar skeleton.
  factory AppSkeletonLoader.avatar({double size = 48.0, Key? key}) {
    return AppSkeletonLoader(
      key: key,
      width: size,
      height: size,
      borderRadius: AppRadius.borderRadiusFull,
    );
  }

  /// Factory for rectangular card skeleton.
  factory AppSkeletonLoader.card({
    double height = 120.0,
    double? width,
    Key? key,
  }) {
    return AppSkeletonLoader(
      key: key,
      width: width ?? double.infinity,
      height: height,
      borderRadius: AppRadius.borderRadiusMd,
    );
  }

  final double? width;
  final double height;
  final BorderRadius borderRadius;

  @override
  State<AppSkeletonLoader> createState() => _AppSkeletonLoaderState();
}

class _AppSkeletonLoaderState extends State<AppSkeletonLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();

    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor =
        isDark ? AppColors.shimmerBaseDark : AppColors.shimmerBaseLight;
    final highlightColor = isDark
        ? AppColors.shimmerHighlightDark
        : AppColors.shimmerHighlightLight;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            gradient: LinearGradient(
              stops: const [0.0, 0.5, 1.0],
              colors: [
                baseColor,
                highlightColor,
                baseColor,
              ],
              transform: _SlidingGradientTransform(slidePercent: _animation.value),
            ),
          ),
        );
      },
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({required this.slidePercent});

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}
