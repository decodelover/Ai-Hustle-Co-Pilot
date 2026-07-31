/// Presentation Modal: CreateProjectModal (Amendment 3.3G Template Selection)
library;

import 'package:ai_hustle_copilot/features/projects/application/providers/project_providers.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Modal bottom sheet for creating a new project from pre-configured templates.
class CreateProjectModal extends ConsumerStatefulWidget {
  /// Creates a [CreateProjectModal].
  const CreateProjectModal({super.key});

  /// Displays modal bottom sheet.
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.0)),
      ),
      builder: (_) => const CreateProjectModal(),
    );
  }

  @override
  ConsumerState<CreateProjectModal> createState() => _CreateProjectModalState();
}

class _CreateProjectModalState extends ConsumerState<CreateProjectModal> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  ProjectCategory _selectedCategory = ProjectCategory.mobileApp;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _onCreate() {
    final title = _titleController.text.trim();
    final desc = _descController.text.trim();
    if (title.isEmpty) return;

    ref
        .read(projectWorkspaceControllerProvider.notifier)
        .createProject(
          title: title,
          description: desc.isNotEmpty ? desc : 'AI Productivity Project',
          category: _selectedCategory,
        );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, bottomInset + 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Create AI Project',
                style: TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close_rounded),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'Project Title',
              hintText: 'e.g. Mobile Banking App',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          TextField(
            controller: _descController,
            maxLines: 2,
            decoration: InputDecoration(
              labelText: 'Description',
              hintText: 'Describe key goals and scope...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Select Project Template Preset',
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: 13.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8.0),
          Wrap(
            spacing: 8.0,
            children: ProjectCategory.values.map((cat) {
              final isSelected = cat == _selectedCategory;
              return ChoiceChip(
                label: Text(cat.name.toUpperCase()),
                selected: isSelected,
                selectedColor: const Color(0xFF0D1B2A),
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFF4B5563),
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                ),
                onSelected: (val) {
                  if (val) setState(() => _selectedCategory = cat);
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 24.0),
          SizedBox(
            width: double.infinity,
            height: 48.0,
            child: ElevatedButton(
              onPressed: _onCreate,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D1B2A),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
              child: const Text(
                'Generate AI Workspace',
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
