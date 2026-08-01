/// Responsive dashboard composition for phone through ultrawide layouts.
library;

import 'package:ai_hustle_copilot/core/theme/app_breakpoints.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Supported dashboard layout modes.
enum DashboardLayoutMode { phone, tablet, desktop, ultraWide }

/// Bento-inspired dashboard layout that preserves readable measure.
class DashboardResponsiveGrid extends StatelessWidget {
  /// Creates a [DashboardResponsiveGrid].
  const DashboardResponsiveGrid({
    required this.header,
    required this.primaryFocus,
    required this.aiCopilot,
    required this.quickActions,
    required this.metricsGrid,
    required this.chartsSection,
    required this.recentProjects,
    required this.recentActivity,
    required this.aiInsights,
    super.key,
  });

  /// Personalized header.
  final Widget header;

  /// Contextual primary action.
  final Widget primaryFocus;

  /// AI workspace entry point.
  final Widget aiCopilot;

  /// Shortcut grid.
  final Widget quickActions;

  /// KPI metric grid.
  final Widget metricsGrid;

  /// Data-backed progress signal.
  final Widget chartsSection;

  /// Active work preview.
  final Widget recentProjects;

  /// Activity feed.
  final Widget recentActivity;

  /// AI guidance panel.
  final Widget aiInsights;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final mode = _modeFor(width);
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;
    final horizontalPadding = switch (mode) {
      DashboardLayoutMode.phone => AppSpacing.space16,
      DashboardLayoutMode.tablet => AppSpacing.space24,
      DashboardLayoutMode.desktop => AppSpacing.space32,
      DashboardLayoutMode.ultraWide => AppSpacing.space48,
    };

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: mode == DashboardLayoutMode.ultraWide
              ? AppBreakpoints.desktop
              : AppBreakpoints.contentMaxWidth,
        ),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            AppSpacing.space24,
            horizontalPadding,
            bottomInset + AppSpacing.space96,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header,
              const SizedBox(height: AppSpacing.space24),
              _focusRow(mode),
              const SizedBox(height: AppSpacing.space24),
              quickActions,
              const SizedBox(height: AppSpacing.space24),
              metricsGrid,
              const SizedBox(height: AppSpacing.space24),
              _contentRow(mode),
            ],
          ),
        ),
      ),
    );
  }

  Widget _focusRow(DashboardLayoutMode mode) {
    if (mode == DashboardLayoutMode.phone ||
        mode == DashboardLayoutMode.tablet) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          primaryFocus,
          const SizedBox(height: AppSpacing.space16),
          aiCopilot,
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 6, child: primaryFocus),
        const SizedBox(width: AppSpacing.space16),
        Expanded(flex: 4, child: aiCopilot),
      ],
    );
  }

  Widget _contentRow(DashboardLayoutMode mode) {
    if (mode == DashboardLayoutMode.phone) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          chartsSection,
          const SizedBox(height: AppSpacing.space24),
          recentProjects,
          const SizedBox(height: AppSpacing.space24),
          aiInsights,
          const SizedBox(height: AppSpacing.space24),
          recentActivity,
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              chartsSection,
              const SizedBox(height: AppSpacing.space24),
              recentProjects,
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.space16),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              aiInsights,
              const SizedBox(height: AppSpacing.space24),
              recentActivity,
            ],
          ),
        ),
      ],
    );
  }

  DashboardLayoutMode _modeFor(double width) {
    if (width < AppBreakpoints.compact) return DashboardLayoutMode.phone;
    if (width < AppBreakpoints.medium) return DashboardLayoutMode.tablet;
    if (width < AppBreakpoints.expanded) return DashboardLayoutMode.desktop;
    return DashboardLayoutMode.ultraWide;
  }
}
