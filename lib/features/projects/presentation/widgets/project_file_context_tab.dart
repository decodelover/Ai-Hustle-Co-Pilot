/// Presentation Widget: ProjectFileContextTab (Amendment 3.3E RAG Knowledge Index)
library;

import 'package:ai_hustle_copilot/features/projects/domain/entities/project.dart';
import 'package:flutter/material.dart';

/// Workspace tab for attaching files, reviewing RAG indexing status, and vector context.
class ProjectFileContextTab extends StatelessWidget {
  /// Creates a [ProjectFileContextTab].
  const ProjectFileContextTab({required this.project, super.key});

  /// Active project.
  final Project project;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'RAG Knowledge Base & Context',
              style: TextStyle(
                color: Color(0xFF111827),
                fontSize: 20.0,
                fontWeight: FontWeight.w800,
              ),
            ),
            OutlinedButton.icon(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF0D1B2A),
                side: const BorderSide(color: Color(0xFFE5E7EB)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              icon: const Icon(Icons.upload_file_rounded, size: 18),
              label: const Text('Attach File'),
            ),
          ],
        ),
        const SizedBox(height: 16.0),

        if (project.knowledgeFiles.isEmpty)
          Container(
            padding: const EdgeInsets.all(32.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: const Column(
              children: [
                Icon(
                  Icons.folder_open_rounded,
                  size: 48,
                  color: Color(0xFF9CA3AF),
                ),
                SizedBox(height: 12.0),
                Text(
                  'No Knowledge Files Uploaded',
                  style: TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  'Attach PDFs, Dart files, or docs to enrich AI Agent context.',
                  style: TextStyle(color: Color(0xFF6B7280), fontSize: 13.0),
                ),
              ],
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: project.knowledgeFiles.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12.0),
            itemBuilder: (context, index) {
              final file = project.knowledgeFiles[index];

              return Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D1B2A).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: const Icon(
                        Icons.insert_drive_file_rounded,
                        color: Color(0xFF0D1B2A),
                      ),
                    ),
                    const SizedBox(width: 14.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            file.name,
                            style: const TextStyle(
                              color: Color(0xFF111827),
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          Text(
                            '${(file.sizeBytes / 1024).toStringAsFixed(1)} KB • ${file.folderPath}',
                            style: const TextStyle(
                              color: Color(0xFF6B7280),
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Text(
                        file.indexingStatus.name.toUpperCase(),
                        style: const TextStyle(
                          color: Color(0xFF10B981),
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }
}
