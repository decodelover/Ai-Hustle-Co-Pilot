import 'package:ai_hustle_copilot/features/documents/presentation/screens/document_editor_screen.dart';
import 'package:ai_hustle_copilot/features/documents/presentation/widgets/canvas/document_block_canvas.dart';
import 'package:ai_hustle_copilot/features/documents/presentation/widgets/toolbars/editor_header_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DocumentEditorScreen Widget Tests', () {
    testWidgets('renders EditorHeaderBar and DocumentBlockCanvas', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: DocumentEditorScreen(documentId: 'doc_101'),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(EditorHeaderBar), findsOneWidget);
      expect(find.byType(DocumentBlockCanvas), findsOneWidget);
    });
  });
}
