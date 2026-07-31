/// Opportunity discovery and matching screen.
library;

import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Searchable, filterable opportunity feed with saved-item support.
class DiscoverScreen extends StatefulWidget {
  /// Creates the opportunity discovery screen.
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final _searchController = TextEditingController();
  final _savedIds = <String>{};
  String _category = 'All';

  static const _opportunities = [
    _Opportunity(
      '1',
      'Flutter SaaS dashboard',
      'Upwork',
      'Mobile',
      r'$3,500–$5,000',
      96,
      'Flutter, Riverpod, Supabase',
      '2h ago',
    ),
    _Opportunity(
      '2',
      'AI content workflow specialist',
      'Contra',
      'AI',
      r'$75–$110/hr',
      92,
      'LLMs, automation, APIs',
      '4h ago',
    ),
    _Opportunity(
      '3',
      'B2B product design system',
      'LinkedIn',
      'Design',
      r'$6,000 fixed',
      88,
      'Figma, Material 3, accessibility',
      'Today',
    ),
    _Opportunity(
      '4',
      'Technical proposal writer',
      'Direct lead',
      'Writing',
      r'$2,400 fixed',
      84,
      'SaaS, architecture, RFP',
      'Yesterday',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.toLowerCase().trim();
    final visible = _opportunities.where((item) {
      final matchesCategory =
          _category == 'All' ||
          (_category == 'Saved' && _savedIds.contains(item.id)) ||
          item.category == _category;
      final matchesQuery =
          query.isEmpty ||
          item.title.toLowerCase().contains(query) ||
          item.skills.toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
        actions: [
          IconButton(
            tooltip: 'Saved opportunities',
            onPressed: () => setState(() => _category = 'Saved'),
            icon: Badge(
              isLabelVisible: _savedIds.isNotEmpty,
              label: Text('${_savedIds.length}'),
              child: const Icon(Icons.bookmark_outline_rounded),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: AppSpacing.paddingAllLg,
                  sliver: SliverList.list(
                    children: [
                      TextField(
                        controller: _searchController,
                        onChanged: (_) => setState(() {}),
                        decoration: InputDecoration(
                          hintText: 'Search roles, skills, or clients',
                          prefixIcon: const Icon(Icons.search_rounded),
                          suffixIcon: query.isEmpty
                              ? null
                              : IconButton(
                                  tooltip: 'Clear search',
                                  onPressed: () {
                                    _searchController.clear();
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.close_rounded),
                                ),
                        ),
                      ),
                      AppSpacing.gap16,
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: ['All', 'AI', 'Mobile', 'Design', 'Writing']
                              .map(
                                (category) => Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: FilterChip(
                                    label: Text(category),
                                    selected: _category == category,
                                    onSelected: (_) =>
                                        setState(() => _category = category),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      AppSpacing.gap24,
                      Text(
                        '${visible.length} matched opportunities',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                if (visible.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: _EmptyResults(),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                    sliver: SliverList.separated(
                      itemCount: visible.length,
                      separatorBuilder: (_, _) => AppSpacing.gap12,
                      itemBuilder: (context, index) {
                        final item = visible[index];
                        return _OpportunityCard(
                          opportunity: item,
                          saved: _savedIds.contains(item.id),
                          onSaved: () => setState(() {
                            if (!_savedIds.add(item.id)) {
                              _savedIds.remove(item.id);
                            }
                          }),
                        );
                      },
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

class _OpportunityCard extends StatelessWidget {
  const _OpportunityCard({
    required this.opportunity,
    required this.saved,
    required this.onSaved,
  });

  final _Opportunity opportunity;
  final bool saved;
  final VoidCallback onSaved;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: AppSpacing.paddingAllMd,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        opportunity.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      AppSpacing.gap4,
                      Text('${opportunity.source} • ${opportunity.postedAt}'),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: saved
                      ? 'Remove saved opportunity'
                      : 'Save opportunity',
                  onPressed: onSaved,
                  icon: Icon(
                    saved
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_outline_rounded,
                  ),
                ),
              ],
            ),
            AppSpacing.gap12,
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(label: Text('${opportunity.match}% match')),
                Chip(label: Text(opportunity.budget)),
                Chip(label: Text(opportunity.category)),
              ],
            ),
            AppSpacing.gap12,
            Text(
              opportunity.skills,
              style: TextStyle(color: colors.onSurfaceVariant),
            ),
            AppSpacing.gap12,
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton.tonalIcon(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Application draft created.')),
                ),
                icon: const Icon(Icons.auto_awesome_rounded),
                label: const Text('Draft application'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyResults extends StatelessWidget {
  const _EmptyResults();

  @override
  Widget build(BuildContext context) => const Center(
    child: Padding(
      padding: AppSpacing.paddingAllLg,
      child: Text('No opportunities match these filters.'),
    ),
  );
}

class _Opportunity {
  const _Opportunity(
    this.id,
    this.title,
    this.source,
    this.category,
    this.budget,
    this.match,
    this.skills,
    this.postedAt,
  );

  final String id;
  final String title;
  final String source;
  final String category;
  final String budget;
  final int match;
  final String skills;
  final String postedAt;
}
