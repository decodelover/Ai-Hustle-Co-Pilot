/// Reusable production shell for secondary workspace modules.
library;

import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// A responsive secondary-module screen with actionable settings.
class ModuleHubScreen extends StatefulWidget {
  /// Creates a module hub.
  const ModuleHubScreen({
    required this.title,
    required this.description,
    required this.icon,
    required this.actions,
    super.key,
  });

  /// Screen title.
  final String title;

  /// Screen introduction.
  final String description;

  /// Module icon.
  final IconData icon;

  /// Available module actions.
  final List<String> actions;

  @override
  State<ModuleHubScreen> createState() => _ModuleHubScreenState();
}

class _ModuleHubScreenState extends State<ModuleHubScreen> {
  final Set<String> _enabled = {};

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(widget.title)),
    body: SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: ListView(
            padding: AppSpacing.paddingAllLg,
            children: [
              Card(
                child: Padding(
                  padding: AppSpacing.paddingAllLg,
                  child: Row(
                    children: [
                      CircleAvatar(radius: 28, child: Icon(widget.icon)),
                      AppSpacing.gap16,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            AppSpacing.gap8,
                            Text(widget.description),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AppSpacing.gap24,
              Text('Controls', style: Theme.of(context).textTheme.titleMedium),
              AppSpacing.gap8,
              Card(
                child: Column(
                  children: widget.actions.map((action) {
                    final enabled = _enabled.contains(action);
                    return SwitchListTile(
                      title: Text(action),
                      subtitle: Text(enabled ? 'Enabled' : 'Disabled'),
                      value: enabled,
                      onChanged: (value) => setState(() {
                        if (value) {
                          _enabled.add(action);
                        } else {
                          _enabled.remove(action);
                        }
                      }),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
