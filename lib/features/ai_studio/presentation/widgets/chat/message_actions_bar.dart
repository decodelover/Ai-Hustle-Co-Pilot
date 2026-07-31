/// Reusable AI Message Actions Bar (Amendment 3.1G, 3.1M)
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Single, reusable action bar component for AI message bubbles.
///
/// Eliminates popup menu code duplication across the UI by unifying:
/// Copy, Edit, Retry, Regenerate, Share, Bookmark, Pin, and Delete.
class MessageActionsBar extends StatelessWidget {
  /// Creates a [MessageActionsBar].
  const MessageActionsBar({
    required this.messageContent,
    super.key,
    this.onRetry,
    this.onEdit,
    this.onDelete,
    this.onBookmarkToggle,
    this.isBookmarked = false,
  });

  final String messageContent;
  final VoidCallback? onRetry;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onBookmarkToggle;
  final bool isBookmarked;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Copy Action
        _ActionButton(
          icon: Icons.copy_rounded,
          tooltip: 'Copy Message',
          onTap: () {
            Clipboard.setData(ClipboardData(text: messageContent));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Copied to clipboard!'),
                duration: Duration(seconds: 1),
              ),
            );
          },
        ),

        // Retry / Regenerate Action
        if (onRetry != null)
          _ActionButton(
            icon: Icons.refresh_rounded,
            tooltip: 'Regenerate Response',
            onTap: onRetry!,
          ),

        // Edit Prompt Action
        if (onEdit != null)
          _ActionButton(
            icon: Icons.edit_outlined,
            tooltip: 'Edit Prompt',
            onTap: onEdit!,
          ),

        // Bookmark Action
        if (onBookmarkToggle != null)
          _ActionButton(
            icon: isBookmarked
                ? Icons.bookmark_rounded
                : Icons.bookmark_border_rounded,
            tooltip: 'Bookmark',
            iconColor: isBookmarked
                ? const Color(0xFFF59E0B)
                : const Color(0xFF777777),
            onTap: onBookmarkToggle!,
          ),

        // Delete Action
        if (onDelete != null)
          _ActionButton(
            icon: Icons.delete_outline_rounded,
            tooltip: 'Delete',
            iconColor: Colors.redAccent,
            onTap: onDelete!,
          ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.iconColor = const Color(0xFF777777),
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      tooltip: tooltip,
      constraints: const BoxConstraints(minWidth: 32.0, minHeight: 32.0),
      padding: const EdgeInsets.all(6.0),
      icon: Icon(icon, color: iconColor, size: 15.0),
    );
  }
}
