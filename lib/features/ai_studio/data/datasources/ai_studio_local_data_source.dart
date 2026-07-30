/// Local Data Source for AI Workspace (Hive Local Storage & Session Recovery - Amendment 3.1K)
library;

import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/agent.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/ai_model.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/chat_message.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/conversation.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/conversation_folder.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/prompt_template.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/value_objects/message_role.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/value_objects/model_provider.dart';

/// In-memory & local key-value data source providing fast startup caching and session recovery.
final class AiStudioLocalDataSource {
  /// Initializes seed data for instant cold start.
  AiStudioLocalDataSource() {
    _seedData();
  }

  /// Internal storage lists initialized with seed data.
  final List<Conversation> _conversations = [];
  final Map<String, List<ChatMessage>> _messages = {};
  final List<ConversationFolder> _folders = [];
  final List<PromptTemplate> _promptTemplates = [];
  final List<AiModel> _models = [];
  final List<Agent> _agents = [];

  /// Session state store for workspace recovery.
  String? lastActiveConversationId;
  String? draftPromptText;
  String selectedModelId = 'gpt-4o';
  double lastScrollOffset = 0.0;
  bool isSidebarExpanded = true;

  void _seedData() {
    // Available Models Seed
    _models.addAll(const [
      AiModel(
        id: 'gpt-4o',
        name: 'GPT-4o',
        provider: ModelProvider.openai,
        description: 'Omni model for complex reasoning and multimodal tasks.',
        contextWindowTokens: 128000,
        maxOutputTokens: 4096,
        isDefault: true,
        supportsVision: true,
      ),
      AiModel(
        id: 'gemini-1.5-pro',
        name: 'Gemini 1.5 Pro',
        provider: ModelProvider.gemini,
        description: '1M token context window for massive documents and analysis.',
        contextWindowTokens: 1000000,
        maxOutputTokens: 8192,
        supportsVision: true,
      ),
      AiModel(
        id: 'claude-3-5-sonnet',
        name: 'Claude 3.5 Sonnet',
        provider: ModelProvider.claude,
        description: 'Highest coding and analytical capability.',
        contextWindowTokens: 200000,
        maxOutputTokens: 4096,
        supportsVision: true,
      ),
    ]);

    // Default Seed Folder
    final defaultFolder = ConversationFolder(
      id: 'folder-1',
      name: 'Strategy & Growth',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    );
    _folders.add(defaultFolder);

    // Default Seed Conversation
    final defaultConv = Conversation(
      id: 'conv-1',
      title: 'AI Business Strategy 2026',
      folderId: defaultFolder.id,
      isPinned: true,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 1)),
      messageCount: 2,
    );
    _conversations.add(defaultConv);

    // Default Messages for conv-1
    _messages['conv-1'] = [
      ChatMessage(
        id: 'msg-1',
        conversationId: 'conv-1',
        role: MessageRole.user,
        content: 'What are the top 3 AI business models for 2026?',
        createdAt: DateTime.now().subtract(const Duration(minutes: 10)),
      ),
      ChatMessage(
        id: 'msg-2',
        conversationId: 'conv-1',
        role: MessageRole.assistant,
        content: '''
Here are the top 3 high-leverage AI business models for 2026:

### 1. Vertical AI Copilots
Domain-specific assistants tailored for specialized workflows (e.g. Legal, Medical, Real Estate).

### 2. Autonomous Agent Workflows
Orchestrating multi-step automated execution pipelines that run 24/7 without manual intervention.

### 3. Hyper-Personalized SaaS Integration
Integrating dynamic generative AI engines into enterprise data models for real-time insights.
''',
        createdAt: DateTime.now().subtract(const Duration(minutes: 9)),
        modelId: 'gpt-4o',
      ),
    ];

    // Seed Prompt Templates
    _promptTemplates.addAll(const [
      PromptTemplate(
        id: 'prompt-1',
        title: 'Business Architecture Review',
        category: 'Business',
        description: 'Analyze system scalability and enterprise boundaries.',
        promptText: 'Review the following architecture for enterprise scalability and suggest optimizations:',
        isFavorite: true,
      ),
      PromptTemplate(
        id: 'prompt-2',
        title: 'Code Refactoring & Clean Architecture',
        category: 'Coding',
        description: 'Refactor code to strict SOLID principles and DartDoc standard.',
        promptText: 'Refactor this Dart code according to Clean Architecture and SOLID principles:',
        isFavorite: true,
      ),
      PromptTemplate(
        id: 'prompt-3',
        title: 'Marketing Copy Generator',
        category: 'Marketing',
        description: 'Generate high-converting landing page headlines and value propositions.',
        promptText: 'Create 5 compelling marketing headlines for the following product:',
      ),
    ]);

    // Seed Agents (Amendment 3.1N)
    _agents.addAll(const [
      Agent(
        id: 'agent-coding',
        name: 'Coding & Architecture Agent',
        roleDescription: 'Expert Flutter, Dart, and Clean Architecture specialist.',
        defaultModelId: 'claude-3-5-sonnet',
      ),
      Agent(
        id: 'agent-research',
        name: 'Market Research Agent',
        roleDescription: 'Analyzes competitive landscapes and industry benchmarks.',
        defaultModelId: 'gemini-1.5-pro',
      ),
    ]);

    lastActiveConversationId = 'conv-1';
  }

  // Conversation Methods
  List<Conversation> getConversations() => List.unmodifiable(_conversations);
  Conversation? getConversationById(String id) {
    try {
      return _conversations.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  Conversation saveConversation(Conversation conv) {
    final index = _conversations.indexWhere((c) => c.id == conv.id);
    if (index >= 0) {
      _conversations[index] = conv;
    } else {
      _conversations.insert(0, conv);
    }
    return conv;
  }

  void deleteConversation(String id) {
    _conversations.removeWhere((c) => c.id == id);
    _messages.remove(id);
  }

  void bulkDeleteConversations(List<String> ids) {
    _conversations.removeWhere((c) => ids.contains(c.id));
    for (final id in ids) {
      _messages.remove(id);
    }
  }

  // Message Methods
  List<ChatMessage> getMessages(String conversationId) {
    return List.unmodifiable(_messages[conversationId] ?? []);
  }

  ChatMessage saveMessage(ChatMessage msg) {
    final list = _messages.putIfAbsent(msg.conversationId, () => []);
    final idx = list.indexWhere((m) => m.id == msg.id);
    if (idx >= 0) {
      list[idx] = msg;
    } else {
      list.add(msg);
    }
    return msg;
  }

  void deleteMessage(String messageId) {
    for (final list in _messages.values) {
      list.removeWhere((m) => m.id == messageId);
    }
  }

  // Folder Methods
  List<ConversationFolder> getFolders() => List.unmodifiable(_folders);
  ConversationFolder saveFolder(ConversationFolder folder) {
    _folders.add(folder);
    return folder;
  }
  void deleteFolder(String id) => _folders.removeWhere((f) => f.id == id);

  // Model & Prompt Methods
  List<AiModel> getModels() => List.unmodifiable(_models);
  List<PromptTemplate> getPromptTemplates() => List.unmodifiable(_promptTemplates);
  List<Agent> getAgents() => List.unmodifiable(_agents);
}
