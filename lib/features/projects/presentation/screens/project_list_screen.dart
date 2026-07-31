/// Presentation Screen: ProjectListScreen (Phase 3.3 Projects Grid)
library;

import 'package:ai_hustle_copilot/features/projects/application/providers/project_providers.dart';
import 'package:ai_hustle_copilot/features/projects/presentation/screens/create_project_modal.dart';
import 'package:ai_hustle_copilot/features/projects/presentation/screens/project_workspace_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Overview grid screen displaying all workspace AI projects.
class ProjectListScreen extends ConsumerWidget {
  /// Creates a [ProjectListScreen].
  const ProjectListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workspaceStateAsync = ref.watch(projectWorkspaceControllerProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text(
          'AI Projects Command Center',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xFF111827),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => CreateProjectModal.show(context),
            icon: const Icon(Icons.add_rounded, color: Color(0xFF0D1B2A)),
            tooltip: 'New Project',
          ),
        ],
      ),
      body: workspaceStateAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: Color(0xFF0D1B2A)),
        ),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (state) {
          final projects = state.projects;

          return GridView.builder(
            padding: const EdgeInsets.all(24.0),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 360.0,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              childAspectRatio: 1.4,
            ),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index];

              return Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                child: InkWell(
                  onTap: () {
                    ref
                        .read(projectWorkspaceControllerProvider.notifier)
                        .selectProject(project.id);
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const ProjectWorkspaceScreen(),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 4.0,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFF0D1B2A,
                                ).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Text(
                                project.category.name.toUpperCase(),
                                style: const TextStyle(
                                  color: Color(0xFF0D1B2A),
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            Text(
                              '${project.healthScore}% Health',
                              style: const TextStyle(
                                color: Color(0xFF10B981),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              project.title,
                              style: const TextStyle(
                                color: Color(0xFF111827),
                                fontSize: 16.0,
                                fontWeight: FontWeight.w800,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              project.description,
                              style: const TextStyle(
                                color: Color(0xFF6B7280),
                                fontSize: 12.5,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
