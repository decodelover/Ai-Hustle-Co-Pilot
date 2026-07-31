/// Application pipeline screen.
library;

import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Tracks active applications, follow-ups, and outcome metrics.
class ApplicationsScreen extends StatefulWidget {
  /// Creates the applications screen.
  const ApplicationsScreen({super.key});

  @override
  State<ApplicationsScreen> createState() => _ApplicationsScreenState();
}

class _ApplicationsScreenState extends State<ApplicationsScreen> {
  String _filter = 'All';

  static const _items = [
    _Application(
      'Flutter SaaS dashboard',
      'Northstar Labs',
      'Interview',
      'Interview tomorrow, 10:00',
      Icons.video_call_outlined,
    ),
    _Application(
      'AI automation consultant',
      'Mira Commerce',
      'Applied',
      'Follow up in 2 days',
      Icons.schedule_send_outlined,
    ),
    _Application(
      'Mobile platform architect',
      'Arc Systems',
      'Offer',
      'Review offer by Friday',
      Icons.celebration_outlined,
    ),
    _Application(
      'Technical content lead',
      'Orbit Cloud',
      'Archived',
      'Closed 3 days ago',
      Icons.archive_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final visible = _filter == 'All'
        ? _items
        : _items.where((item) => item.status == _filter).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Applications'),
        actions: [
          PopupMenuButton<String>(
            tooltip: 'Filter applications',
            initialValue: _filter,
            onSelected: (value) => setState(() => _filter = value),
            itemBuilder: (_) =>
                ['All', 'Applied', 'Interview', 'Offer', 'Archived']
                    .map(
                      (value) =>
                          PopupMenuItem(value: value, child: Text(value)),
                    )
                    .toList(),
            icon: const Icon(Icons.filter_list_rounded),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('New application workflow opened.')),
        ),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add application'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: ListView(
              padding: AppSpacing.paddingAllLg,
              children: [
                const Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _Metric(
                      label: 'Active',
                      value: '3',
                      icon: Icons.work_outline,
                    ),
                    _Metric(
                      label: 'Interviews',
                      value: '1',
                      icon: Icons.groups_outlined,
                    ),
                    _Metric(
                      label: 'Offers',
                      value: '1',
                      icon: Icons.stars_outlined,
                    ),
                    _Metric(
                      label: 'Response rate',
                      value: '42%',
                      icon: Icons.trending_up,
                    ),
                  ],
                ),
                AppSpacing.gap24,
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _filter == 'All'
                            ? 'Application pipeline'
                            : '$_filter applications',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Text('${visible.length} results'),
                  ],
                ),
                AppSpacing.gap12,
                if (visible.isEmpty)
                  const Padding(
                    padding: AppSpacing.paddingAllXl,
                    child: Center(
                      child: Text('No applications in this stage.'),
                    ),
                  )
                else
                  ...visible.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _ApplicationCard(item: item),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value, required this.icon});

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 200,
    child: Card(
      child: Padding(
        padding: AppSpacing.paddingAllMd,
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            AppSpacing.gap12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(value, style: Theme.of(context).textTheme.titleLarge),
                  Text(label, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _ApplicationCard extends StatelessWidget {
  const _ApplicationCard({required this.item});

  final _Application item;

  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      contentPadding: AppSpacing.paddingAllMd,
      leading: CircleAvatar(child: Icon(item.icon)),
      title: Text(item.role),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Text('${item.company} • ${item.nextAction}'),
      ),
      trailing: Chip(label: Text(item.status)),
      onTap: () => showModalBottomSheet<void>(
        context: context,
        showDragHandle: true,
        builder: (context) => Padding(
          padding: AppSpacing.paddingAllLg,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.role, style: Theme.of(context).textTheme.titleLarge),
              AppSpacing.gap8,
              Text(item.company),
              AppSpacing.gap16,
              Text(item.nextAction),
              AppSpacing.gap24,
              FilledButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.check_rounded),
                label: const Text('Mark action complete'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _Application {
  const _Application(
    this.role,
    this.company,
    this.status,
    this.nextAction,
    this.icon,
  );

  final String role;
  final String company;
  final String status;
  final String nextAction;
  final IconData icon;
}
