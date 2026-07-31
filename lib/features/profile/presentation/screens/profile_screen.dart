/// User profile and account preferences.
library;

import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:ai_hustle_copilot/features/auth/application/providers/auth_application_providers.dart';
import 'package:ai_hustle_copilot/features/auth/domain/auth_state.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Displays the authenticated profile, preferences, and account actions.
class ProfileScreen extends ConsumerStatefulWidget {
  /// Creates the profile screen.
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _opportunityAlerts = true;
  bool _weeklyDigest = true;

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authStateProvider).valueOrNull;
    final user = auth is Authenticated ? auth.user : null;
    final signOutState = ref.watch(signOutControllerProvider);
    final displayName = user?.displayName?.trim().isNotEmpty == true
        ? user!.displayName!
        : 'AI Hustle member';
    final initials = displayName
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .take(2)
        .map((part) => part[0].toUpperCase())
        .join();

    return Scaffold(
      appBar: AppBar(title: const Text('Profile & settings')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: ListView(
              padding: AppSpacing.paddingAllLg,
              children: [
                Card(
                  child: Padding(
                    padding: AppSpacing.paddingAllLg,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 36,
                          child: Text(initials.isEmpty ? 'AH' : initials),
                        ),
                        AppSpacing.gap16,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                displayName,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              AppSpacing.gap4,
                              Text(user?.email ?? 'No authenticated email'),
                              AppSpacing.gap8,
                              Chip(
                                avatar: Icon(
                                  user?.emailVerified == true
                                      ? Icons.verified_rounded
                                      : Icons.info_outline_rounded,
                                  size: 18,
                                ),
                                label: Text(
                                  user?.emailVerified == true
                                      ? 'Email verified'
                                      : 'Verification pending',
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          tooltip: 'Edit profile',
                          onPressed: () =>
                              _showEditProfile(context, displayName),
                          icon: const Icon(Icons.edit_outlined),
                        ),
                      ],
                    ),
                  ),
                ),
                AppSpacing.gap24,
                Text(
                  'Preferences',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                AppSpacing.gap8,
                Card(
                  child: Column(
                    children: [
                      SwitchListTile(
                        title: const Text('Opportunity alerts'),
                        subtitle: const Text(
                          'Notify me about high-match opportunities',
                        ),
                        value: _opportunityAlerts,
                        onChanged: (value) =>
                            setState(() => _opportunityAlerts = value),
                      ),
                      const Divider(height: 1),
                      SwitchListTile(
                        title: const Text('Weekly performance digest'),
                        subtitle: const Text(
                          'Receive application and revenue insights',
                        ),
                        value: _weeklyDigest,
                        onChanged: (value) =>
                            setState(() => _weeklyDigest = value),
                      ),
                    ],
                  ),
                ),
                AppSpacing.gap24,
                Text(
                  'Workspace',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                AppSpacing.gap8,
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.psychology_outlined),
                        title: const Text('AI preferences'),
                        subtitle: const Text(
                          'Models, memory, and generation controls',
                        ),
                        trailing: const Icon(Icons.chevron_right_rounded),
                        onTap: () => _showComingSoon(context, 'AI preferences'),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.security_outlined),
                        title: const Text('Security'),
                        subtitle: const Text('Password and active sessions'),
                        trailing: const Icon(Icons.chevron_right_rounded),
                        onTap: () =>
                            _showComingSoon(context, 'Security settings'),
                      ),
                    ],
                  ),
                ),
                AppSpacing.gap24,
                OutlinedButton.icon(
                  onPressed: signOutState.isLoading
                      ? null
                      : () async {
                          final succeeded = await ref
                              .read(signOutControllerProvider.notifier)
                              .signOut();
                          if (!succeeded && context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Unable to sign out. Try again.'),
                              ),
                            );
                          }
                        },
                  icon: signOutState.isLoading
                      ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.logout_rounded),
                  label: const Text('Sign out'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Future<void> _showEditProfile(
    BuildContext context,
    String displayName,
  ) async {
    final controller = TextEditingController(text: displayName);
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit profile'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Display name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    controller.dispose();
  }

  static void _showComingSoon(BuildContext context, String area) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$area opened.')));
  }
}
