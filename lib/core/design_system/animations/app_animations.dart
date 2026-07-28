/// Production-ready animation primitives for AI Hustle Co-Pilot.
///
/// Contains AnimatedPage, FadeIn, SlideIn, ScaleIn, and StaggerAnimation.
library;

import 'package:ai_hustle_copilot/core/theme/app_motion.dart';
import 'package:flutter/material.dart';

/// Shared page route transition wrapper for smooth screen entries.
class AnimatedPage extends StatelessWidget {
  /// Creates an [AnimatedPage].
  const AnimatedPage({
    required this.child,
    super.key,
    this.duration = AppMotion.pageTransitionDuration,
    this.curve = AppMotion.decelerateCurve,
  });

  /// Page content.
  final Widget child;

  /// Transition duration.
  final Duration duration;

  /// Transition curve.
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: duration,
      curve: curve,
      child: SlideIn(
        beginOffset: const Offset(0.0, 0.05),
        duration: duration,
        curve: curve,
        child: child,
      ),
    );
  }
}

/// Fade in opacity animation component.
class FadeIn extends StatefulWidget {
  /// Creates a [FadeIn].
  const FadeIn({
    required this.child,
    super.key,
    this.duration = AppMotion.medium,
    this.delay = Duration.zero,
    this.curve = AppMotion.decelerateCurve,
  });

  /// Animated child target.
  final Widget child;

  /// Animation duration.
  final Duration duration;

  /// Animation start delay.
  final Duration delay;

  /// Animation curve.
  final Curve curve;

  @override
  State<FadeIn> createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);

    if (widget.delay == Duration.zero) {
      _controller.forward();
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}

/// Slide in offset animation component.
class SlideIn extends StatefulWidget {
  /// Creates a [SlideIn].
  const SlideIn({
    required this.child,
    super.key,
    this.beginOffset = const Offset(0.0, 0.1),
    this.duration = AppMotion.medium,
    this.delay = Duration.zero,
    this.curve = AppMotion.decelerateCurve,
  });

  /// Animated child target.
  final Widget child;

  /// Initial slide offset vector.
  final Offset beginOffset;

  /// Animation duration.
  final Duration duration;

  /// Animation delay.
  final Duration delay;

  /// Animation curve.
  final Curve curve;

  @override
  State<SlideIn> createState() => _SlideInState();
}

class _SlideInState extends State<SlideIn> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween<Offset>(
      begin: widget.beginOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    if (widget.delay == Duration.zero) {
      _controller.forward();
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }
}

/// Scale in pop animation component.
class ScaleIn extends StatefulWidget {
  /// Creates a [ScaleIn].
  const ScaleIn({
    required this.child,
    super.key,
    this.beginScale = 0.9,
    this.duration = AppMotion.medium,
    this.delay = Duration.zero,
    this.curve = AppMotion.springCurve,
  });

  /// Animated child target.
  final Widget child;

  /// Initial scale factor.
  final double beginScale;

  /// Animation duration.
  final Duration duration;

  /// Animation delay.
  final Duration delay;

  /// Animation curve.
  final Curve curve;

  @override
  State<ScaleIn> createState() => _ScaleInState();
}

class _ScaleInState extends State<ScaleIn> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween<double>(
      begin: widget.beginScale,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    if (widget.delay == Duration.zero) {
      _controller.forward();
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }
}

/// Staggered child list entry animation component.
class StaggerAnimation extends StatelessWidget {
  /// Creates a [StaggerAnimation].
  const StaggerAnimation({
    required this.children,
    super.key,
    this.staggerDelay = const Duration(milliseconds: 50),
    this.duration = AppMotion.medium,
  });

  /// List of children widgets to stagger.
  final List<Widget> children;

  /// Inter-child delay interval.
  final Duration staggerDelay;

  /// Individual item transition duration.
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(
        children.length,
        (index) => FadeIn(
          delay: Duration(milliseconds: staggerDelay.inMilliseconds * index),
          duration: duration,
          child: SlideIn(
            delay: Duration(milliseconds: staggerDelay.inMilliseconds * index),
            duration: duration,
            child: children[index],
          ),
        ),
      ),
    );
  }
}
