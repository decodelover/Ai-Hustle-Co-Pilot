/// Dialog Widget: DocumentExportModal.
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/features/documents/application/providers/document_providers.dart';
import 'package:ai_hustle_copilot/features/documents/domain/entities/document.dart';
import 'package:ai_hustle_copilot/features/documents/domain/value_objects/export_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Modal dialog for choosing document export format (PDF, DOCX, Markdown, HTML, TXT).
class DocumentExportModal extends ConsumerStatefulWidget {
  /// Creates a [DocumentExportModal].
  const DocumentExportModal({required this.document, super.key});

  final Document document;

  @override
  ConsumerState<DocumentExportModal> createState() =>
      _DocumentExportModalState();
}

class _DocumentExportModalState extends ConsumerState<DocumentExportModal> {
  ExportFormat _selectedFormat = ExportFormat.pdf;
  bool _isExporting = false;
  String? _successMessage;

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(documentEditorControllerProvider.notifier);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Row(
        children: [
          Icon(Icons.download_outlined, color: AppColors.secondary),
          SizedBox(width: 10),
          Text(
            'Export Document',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select export format for "${widget.document.title}"',
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),

            ...ExportFormat.values.map((format) {
              final isSelected = _selectedFormat == format;
              return Container(
                margin: const EdgeInsets.only(bottom: 6),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.secondary.withValues(alpha: 0.08)
                      : AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected ? AppColors.secondary : AppColors.outline,
                  ),
                ),
                child: ListTile(
                  dense: true,
                  leading: Icon(
                    isSelected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,
                    color: isSelected
                        ? AppColors.secondary
                        : AppColors.onSurfaceVariant,
                    size: 18,
                  ),
                  title: Text(
                    format.label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w500,
                      color: AppColors.onSurface,
                    ),
                  ),
                  onTap: () => setState(() => _selectedFormat = format),
                ),
              );
            }),

            if (_successMessage != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      size: 16,
                      color: AppColors.success,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _successMessage!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.success,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton.icon(
          onPressed: _isExporting
              ? null
              : () async {
                  setState(() => _isExporting = true);
                  final bytes = await controller.exportDocument(
                    _selectedFormat,
                  );
                  setState(() {
                    _isExporting = false;
                    _successMessage =
                        'Document successfully compiled (${bytes?.lengthInBytes ?? 0} bytes)!';
                  });
                },
          icon: _isExporting
              ? const SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Icon(Icons.download, size: 16),
          label: Text(_isExporting ? 'Compiling...' : 'Export File'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryDarkBlue,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
