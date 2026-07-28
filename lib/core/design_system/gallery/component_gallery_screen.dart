/// Developer Component Gallery screen (Storybook for AI Hustle Co-Pilot design system).
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Interactive developer catalog showcasing all design tokens and reusable UI components.
class ComponentGalleryScreen extends StatefulWidget {
  /// Creates a [ComponentGalleryScreen].
  const ComponentGalleryScreen({super.key});

  @override
  State<ComponentGalleryScreen> createState() =>
      _ComponentGalleryScreenState();
}

class _ComponentGalleryScreenState extends State<ComponentGalleryScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  bool _isDarkPreview = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activeTheme = _isDarkPreview ? AppTheme.darkTheme : AppTheme.lightTheme;

    return Theme(
      data: activeTheme,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Component Gallery (Dev Storybook)'),
          actions: [
            Row(
              children: [
                Icon(
                  _isDarkPreview ? Icons.dark_mode : Icons.light_mode,
                  size: 20,
                ),
                Switch(
                  value: _isDarkPreview,
                  onChanged: (val) => setState(() => _isDarkPreview = val),
                ),
                const SizedBox(width: AppSpacing.space8),
              ],
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: const [
              Tab(text: 'Buttons'),
              Tab(text: 'Inputs'),
              Tab(text: 'Cards'),
              Tab(text: 'Common'),
              Tab(text: 'Feedback'),
              Tab(text: 'Loading'),
              Tab(text: 'Layout'),
            ],
          ),
        ),
        body: ResponsivePageContainer(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildButtonsTab(context),
              _buildInputsTab(context),
              _buildCardsTab(context),
              _buildCommonTab(context),
              _buildFeedbackTab(context),
              _buildLoadingTab(context),
              _buildLayoutTab(context),
            ],
          ),
        ),
      ),
    );
  }

  // ── Tab 1: Buttons ───────────────────────────────────────────────────
  Widget _buildButtonsTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.space16),
      children: [
        const AppSectionHeader(
          title: 'Button Variants',
          subtitle: 'Enterprise button primitives adhering to M3 rules',
        ),
        AppButton(
          text: 'Primary Button',
          onPressed: () {},
        ),
        const SizedBox(height: AppSpacing.space12),
        AppButton(
          text: 'Secondary Button',
          variant: AppButtonVariant.secondary,
          onPressed: () {},
        ),
        const SizedBox(height: AppSpacing.space12),
        AppButton(
          text: 'Outlined Button',
          variant: AppButtonVariant.outlined,
          onPressed: () {},
        ),
        const SizedBox(height: AppSpacing.space12),
        AppButton(
          text: 'Ghost Button',
          variant: AppButtonVariant.ghost,
          onPressed: () {},
        ),
        const SizedBox(height: AppSpacing.space12),
        AppButton(
          text: 'Destructive Action',
          variant: AppButtonVariant.destructive,
          onPressed: () {},
        ),
        const SizedBox(height: AppSpacing.space12),
        AppButton(
          text: 'Success Action',
          variant: AppButtonVariant.success,
          onPressed: () {},
        ),
        const SizedBox(height: AppSpacing.space12),
        const AppButton(
          text: 'Loading State',
          isLoading: true,
        ),
        const SizedBox(height: AppSpacing.space24),
        const AppSectionHeader(title: 'Icon Buttons'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppIconButton(
              icon: Icons.add_rounded,
              variant: AppIconButtonVariant.filled,
              onPressed: () {},
            ),
            AppIconButton(
              icon: Icons.edit_rounded,
              variant: AppIconButtonVariant.outlined,
              onPressed: () {},
            ),
            AppIconButton(
              icon: Icons.delete_outline_rounded,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  // ── Tab 2: Inputs ────────────────────────────────────────────────────
  Widget _buildInputsTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.space16),
      children: const [
        AppSectionHeader(
          title: 'Text Inputs',
          subtitle: 'Validation, prefix/suffix icons, and password toggle',
        ),
        AppTextField(
          label: 'Standard Input',
          hint: 'Enter your text',
        ),
        SizedBox(height: AppSpacing.space16),
        AppTextField(
          label: 'Email Input',
          type: AppTextFieldType.email,
          hint: 'name@example.com',
        ),
        SizedBox(height: AppSpacing.space16),
        AppTextField(
          label: 'Password Input',
          type: AppTextFieldType.password,
          hint: '••••••••',
        ),
        SizedBox(height: AppSpacing.space16),
        AppTextField(
          label: 'Search Input',
          type: AppTextFieldType.search,
          hint: 'Search opportunities...',
        ),
        SizedBox(height: AppSpacing.space16),
        AppTextField(
          label: 'Error State Input',
          errorText: 'This field is required',
        ),
        SizedBox(height: AppSpacing.space16),
        AppTextField(
          label: 'Success State Input',
          isSuccess: true,
        ),
      ],
    );
  }

  // ── Tab 3: Cards ─────────────────────────────────────────────────────
  Widget _buildCardsTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.space16),
      children: [
        const AppSectionHeader(
          title: 'Card Containers',
          subtitle: 'Standard, elevated, filled, and outlined cards',
        ),
        AppCard(
          title: 'Standard Card',
          subtitle: 'Level 1 subtle elevation with stroke border',
          leading: const AppAvatar(name: 'AI Co-Pilot'),
          trailing: const AppBadge(label: 'Active', variant: AppBadgeVariant.success),
          onTap: () {},
        ),
        const SizedBox(height: AppSpacing.space16),
        AppCard(
          title: 'Elevated Card',
          subtitle: 'Prominent elevation shadow for floating panels',
          variant: AppCardVariant.elevated,
          onTap: () {},
        ),
        const SizedBox(height: AppSpacing.space16),
        const AppCard(
          title: 'Filled Card',
          subtitle: 'Surface variant container background',
          variant: AppCardVariant.filled,
        ),
        const SizedBox(height: AppSpacing.space16),
        const AppCard(
          title: 'Outlined Card',
          subtitle: 'Clear border bounds without shadow',
          variant: AppCardVariant.outlined,
        ),
      ],
    );
  }

  // ── Tab 4: Common ────────────────────────────────────────────────────
  Widget _buildCommonTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.space16),
      children: const [
        AppSectionHeader(title: 'Avatars'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppAvatar(name: 'Alex Johnson', size: AppAvatarSize.xs),
            AppAvatar(name: 'Alex Johnson', size: AppAvatarSize.sm),
            AppAvatar(name: 'Alex Johnson', isOnline: true),
            AppAvatar(name: 'Alex Johnson', size: AppAvatarSize.lg, isOnline: false),
            AppAvatar(name: 'Alex Johnson', size: AppAvatarSize.xl),
          ],
        ),
        SizedBox(height: AppSpacing.space24),
        AppSectionHeader(title: 'Badges'),
        Wrap(
          spacing: AppSpacing.space8,
          runSpacing: AppSpacing.space8,
          children: [
            AppBadge(label: 'Primary'),
            AppBadge(label: 'Success', variant: AppBadgeVariant.success),
            AppBadge(label: 'Warning', variant: AppBadgeVariant.warning),
            AppBadge(label: 'Danger', variant: AppBadgeVariant.danger),
            AppBadge(label: 'Info', variant: AppBadgeVariant.info),
            AppBadge(label: 'Outline', variant: AppBadgeVariant.outline),
          ],
        ),
        SizedBox(height: AppSpacing.space24),
        AppSectionHeader(title: 'List Tiles'),
        AppListTile(
          title: 'General Settings',
          subtitle: 'Manage profile preferences and notifications',
          leading: Icon(Icons.tune_rounded),
          trailing: Icon(Icons.chevron_right_rounded),
        ),
        AppDivider(),
        AppListTile(
          title: 'Security & Auth',
          subtitle: 'Configure two-factor authentication',
          leading: Icon(Icons.security_rounded),
          trailing: Icon(Icons.chevron_right_rounded),
        ),
      ],
    );
  }

  // ── Tab 5: Feedback ──────────────────────────────────────────────────
  Widget _buildFeedbackTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.space16),
      children: [
        const AppSectionHeader(title: 'Dialogs & Bottom Sheets'),
        AppButton(
          text: 'Show AppDialog',
          onPressed: () {
            AppDialog.show<void>(
              context: context,
              title: 'Confirm Action',
              description: 'Are you sure you want to delete this item?',
              primaryActionText: 'Delete',
              isDestructive: true,
              secondaryActionText: 'Cancel',
            );
          },
        ),
        const SizedBox(height: AppSpacing.space12),
        AppButton(
          text: 'Show AppBottomSheet',
          variant: AppButtonVariant.secondary,
          onPressed: () {
            AppBottomSheet.show<void>(
              context: context,
              title: 'Filter Options',
              child: const Column(
                children: [
                  AppListTile(title: 'Sort by Date'),
                  AppListTile(title: 'Sort by Relevance'),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: AppSpacing.space12),
        AppButton(
          text: 'Show Success SnackBar',
          variant: AppButtonVariant.success,
          onPressed: () {
            AppSnackBar.showSuccess(
              context,
              message: 'Changes saved successfully!',
            );
          },
        ),
      ],
    );
  }

  // ── Tab 6: Loading & 4-State Lifecycle ──────────────────────────────
  Widget _buildLoadingTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.space16),
      children: const [
        AppSectionHeader(title: 'Loading Indicators'),
        Center(child: AppLoadingIndicator()),
        SizedBox(height: AppSpacing.space16),
        AppLoadingIndicator.linear(),
        SizedBox(height: AppSpacing.space24),
        AppSectionHeader(title: 'Skeleton Loaders'),
        SkeletonCard(height: 100.0),
        SizedBox(height: AppSpacing.space16),
        SkeletonText(lines: 3),
      ],
    );
  }

  // ── Tab 7: Layout ────────────────────────────────────────────────────
  Widget _buildLayoutTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.space16),
      children: const [
        AppSectionHeader(title: 'Responsive Containers & Dividers'),
        Text('Horizontal Divider Below:'),
        AppDivider(),
        Text('Section content within max content width limits.'),
      ],
    );
  }
}
