/// SemanticSearchModal — Cross-Entity Search (Amendment 3.2J)
library;

import 'package:flutter/material.dart';

/// Modal bottom sheet for enterprise AI semantic search across conversations, memories, and documents.
class SemanticSearchModal extends StatefulWidget {
  /// Creates a [SemanticSearchModal].
  const SemanticSearchModal({super.key});

  /// Displays the modal.
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.0)),
      ),
      builder: (_) => const SemanticSearchModal(),
    );
  }

  @override
  State<SemanticSearchModal> createState() => _SemanticSearchModalState();
}

class _SemanticSearchModalState extends State<SemanticSearchModal> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 24.0,
        left: 24.0,
        right: 24.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(Icons.saved_search_rounded, color: Color(0xFF0D1B2A), size: 24.0),
              const SizedBox(width: 8.0),
              const Text(
                'Enterprise Semantic Search',
                style: TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close_rounded, size: 20.0),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: _searchController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Search chats, memories, code, or documents...',
              prefixIcon: const Icon(Icons.search_rounded),
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }
}
