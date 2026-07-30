/// Mock AI Provider Service for offline development and testing.
library;

import 'dart:async';
import 'package:ai_hustle_copilot/features/ai_studio/data/providers/ai_provider_service.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/chat_message.dart';

/// Implementation of [AiProviderService] simulating streaming token responses.
final class MockAiProviderService implements AiProviderService {
  @override
  String get providerId => 'mock';

  @override
  Stream<String> streamResponse({
    required String modelId,
    required List<ChatMessage> history,
    String? systemPrompt,
  }) async* {
    final lastUserMsg = history.isEmpty ? 'Hello' : history.last.content;

    final mockResponseText = '''
Here is a comprehensive breakdown for **${lastUserMsg.length > 30 ? '${lastUserMsg.substring(0, 30)}...' : lastUserMsg}**:

### 🎯 Key Strategic Insights

1. **Market Intelligence**: Leverages automated data ingestion and real-time LLM reasoning to optimize business workflows.
2. **Scalable Architecture**: Built with Clean Architecture, SOLID principles, and Riverpod state management.
3. **Execution Plan**: Rapid iteration with 60/120 FPS UI performance.

```dart
// Example Production Dart Execution Snippet
void executeStrategy() {
  final copilot = AiHustleCopilot(
    model: '$modelId',
    status: 'ACTIVE',
  );
  copilot.streamInsights();
}
```

> **Pro Tip**: Use `Cmd/Ctrl + K` anytime to trigger instant global search across all active conversations.
''';

    // Break into token chunks and stream with realistic typing delays
    final words = mockResponseText.split(' ');
    for (var i = 0; i < words.length; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 35));
      final word = words[i];
      final suffix = i == words.length - 1 ? '' : ' ';
      yield '$word$suffix';
    }
  }
}
