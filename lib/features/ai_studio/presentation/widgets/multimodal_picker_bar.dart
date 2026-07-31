/// MultimodalPickerBar — Attachment Selector (Amendment 3.2H)
library;

import 'package:flutter/material.dart';

/// Multimodal attachment picker bar for images, PDFs, DOCX, CSV, and code.
class MultimodalPickerBar extends StatelessWidget {
  /// Creates a [MultimodalPickerBar].
  const MultimodalPickerBar({super.key, this.onAttachmentSelected});

  /// Attachment select callback.
  final ValueChanged<String>? onAttachmentSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: const BoxDecoration(
        color: Color(0xFFF8FAFC),
        border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
      ),
      child: Row(
        children: [
          _buildChip(
            icon: Icons.image_outlined,
            label: 'Image / OCR',
            onTap: () => onAttachmentSelected?.call('image'),
          ),
          const SizedBox(width: 8.0),
          _buildChip(
            icon: Icons.picture_as_pdf_outlined,
            label: 'PDF / Doc',
            onTap: () => onAttachmentSelected?.call('pdf'),
          ),
          const SizedBox(width: 8.0),
          _buildChip(
            icon: Icons.code_rounded,
            label: 'Code File',
            onTap: () => onAttachmentSelected?.call('code'),
          ),
        ],
      ),
    );
  }

  Widget _buildChip({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16.0, color: const Color(0xFF0D1B2A)),
            const SizedBox(width: 6.0),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF111827),
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
