/// Presentation Widget: AgentExecutionPanel (Phase 3.3 Right Panel)
library;

import 'package:ai_hustle_copilot/features/projects/application/providers/project_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Right panel widget displaying live agent execution log stream and context inspector.
class AgentExecutionPanel extends ConsumerWidget {
  /// Creates an [AgentExecutionPanel].
  const AgentExecutionPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workspaceStateAsync = ref.watch(projectWorkspaceControllerProvider);

    return workspaceStateAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (error, stackTrace) => const SizedBox.shrink(),
      data: (state) {
        final logs = state.executionLogs;
        final isExecuting = state.isExecutingAgent;
        final activeAgent = state.activeAgent;

        return Container(
          width: 340.0,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16.0),
                color: const Color(0xFF0D1B2A),
                child: Row(
                  children: [
                    const Icon(
                      Icons.smart_toy_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        activeAgent != null
                            ? activeAgent.name
                            : 'AI Agent Monitor',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isExecuting)
                      const SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xFFFF6B6B),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Active Agent Specs Card
              if (activeAgent != null)
                Container(
                  padding: const EdgeInsets.all(16.0),
                  color: const Color(0xFFF8FAFC),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ROLE: ${activeAgent.role.name.toUpperCase()}',
                        style: const TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        activeAgent.systemInstructions,
                        style: const TextStyle(
                          color: Color(0xFF374151),
                          fontSize: 12.0,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Text(
                  '11-Step Execution Log Stream',
                  style: TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 13.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              // Console Terminal Log Output
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(12.0),
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D1B2A),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: logs.isEmpty
                      ? const Center(
                          child: Text(
                            'Ready for agent task execution.\nSelect a task and click "Run Task".',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF9CA3AF),
                              fontSize: 12.0,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: logs.length,
                          itemBuilder: (context, index) {
                            final log = logs[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 6.0),
                              child: Text(
                                log,
                                style: TextStyle(
                                  color: log.contains('[ERROR]')
                                      ? const Color(0xFFEF4444)
                                      : (log.startsWith('[')
                                            ? const Color(0xFF10B981)
                                            : Colors.white),
                                  fontSize: 11.5,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
