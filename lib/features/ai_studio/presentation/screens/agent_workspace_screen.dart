/// AgentWorkspaceScreen — AI Agent Planning & Execution (Amendment 3.2C)
library;

import 'package:ai_hustle_copilot/features/ai_studio/application/providers/ai_studio_providers.dart';
import 'package:ai_hustle_copilot/shared/widgets/topographic_wave_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Screen driving AI Agent goal execution through Planning -> Execution -> Review -> Delivery.
class AgentWorkspaceScreen extends ConsumerStatefulWidget {
  /// Creates an [AgentWorkspaceScreen].
  const AgentWorkspaceScreen({super.key});

  @override
  ConsumerState<AgentWorkspaceScreen> createState() =>
      _AgentWorkspaceScreenState();
}

class _AgentWorkspaceScreenState extends ConsumerState<AgentWorkspaceScreen> {
  final _goalController = TextEditingController();

  @override
  void dispose() {
    _goalController.dispose();
    super.dispose();
  }

  void _submitGoal() {
    final goal = _goalController.text.trim();
    if (goal.isEmpty) return;
    ref.read(agentControllerProvider.notifier).runTask(goal);
  }

  @override
  Widget build(BuildContext context) {
    final agentState = ref.watch(agentControllerProvider);
    final task = agentState.value;
    final isLoading = agentState.isLoading;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          WaveHeaderWidget(
            height: 180.0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 12.0,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 8.0),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'AI Agent Workspace',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Planning • Execution • Review • Delivery',
                          style: TextStyle(
                            color: Color(0xFF3A5FA0),
                            fontSize: 13.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _goalController,
                    decoration: InputDecoration(
                      hintText:
                          'Enter autonomous goal (e.g. "Generate client proposal & pricing PDF")',
                      filled: true,
                      fillColor: const Color(0xFFF8FAFC),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    height: 52.0,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _submitGoal,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0D1B2A),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26.0),
                        ),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            )
                          : const Text(
                              'Execute Agent Task',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  if (task != null) ...[
                    Text(
                      'Task Status: ${task.phase.name.toUpperCase()}',
                      style: const TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: const Color(0xFFE5E7EB)),
                        ),
                        child: ListView.builder(
                          itemCount: task.steps.length,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4.0,
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.check_circle_rounded,
                                    color: Color(0xFF10B981),
                                    size: 18.0,
                                  ),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: Text(
                                      task.steps[index],
                                      style: const TextStyle(
                                        color: Color(0xFF111827),
                                        fontSize: 13.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
