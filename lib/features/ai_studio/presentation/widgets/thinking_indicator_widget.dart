/// ThinkingIndicatorWidget — Animated AI Thinking State (Amendment 3.2E & UI)
library;

import 'dart:async';
import 'package:flutter/material.dart';

/// Animated AI thinking state widget displaying pulse icon and elapsed duration.
class ThinkingIndicatorWidget extends StatefulWidget {
  /// Creates a [ThinkingIndicatorWidget].
  const ThinkingIndicatorWidget({super.key});

  @override
  State<ThinkingIndicatorWidget> createState() => _ThinkingIndicatorWidgetState();
}

class _ThinkingIndicatorWidgetState extends State<ThinkingIndicatorWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Timer _timer;
  int _elapsedMs = 0;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      setState(() => _elapsedMs += 100);
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final seconds = (_elapsedMs / 1000.0).toStringAsFixed(1);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeTransition(
            opacity: Tween<double>(begin: 0.3, end: 1.0).animate(_pulseController),
            child: Container(
              width: 24.0,
              height: 24.0,
              decoration: const BoxDecoration(
                color: Color(0xFF0D1B2A),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.auto_awesome_rounded,
                color: Colors.white,
                size: 14.0,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Text(
            'Thinking for ${seconds}s...',
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 13.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
