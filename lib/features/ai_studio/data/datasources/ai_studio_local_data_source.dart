/// Local Data Source for AI Workspace (Hive Local Storage & Session Recovery - Amendment 3.1K)
library;

import 'dart:async';

import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/agent.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/ai_model.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/chat_message.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/conversation.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/conversation_folder.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/message_attachment.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/prompt_template.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/value_objects/attachment_type.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/value_objects/message_role.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/value_objects/model_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// In-memory & local key-value data source providing fast startup caching and session recovery.
final class AiStudioLocalDataSource {
  /// Initializes seed data for instant cold start.
  AiStudioLocalDataSource() {
    _seedData();
    _restore();
  }

  static const _boxName = 'ai_studio_v1';

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
  String selectedModelId = 'gemini-3.6-flash';
  double lastScrollOffset = 0.0;
  bool isSidebarExpanded = true;

  void _seedData() {
    // Available Models Seed
    _models.addAll(const [
      AiModel(
        id: 'gemini-3.6-flash',
        name: 'Gemini 3.6 Flash',
        provider: ModelProvider.gemini,
        description:
            'Stable production model balancing speed and intelligence.',
        contextWindowTokens: 1000000,
        maxOutputTokens: 8192,
        isDefault: true,
        supportsVision: true,
      ),
      AiModel(
        id: 'gemini-3.5-flash-lite',
        name: 'Gemini 3.5 Flash-Lite',
        provider: ModelProvider.gemini,
        description: 'Cost-efficient model for high-throughput tasks.',
        contextWindowTokens: 1000000,
        maxOutputTokens: 8192,
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
        promptText:
            'Review the following architecture for enterprise scalability and suggest optimizations:',
        isFavorite: true,
      ),
      PromptTemplate(
        id: 'prompt-2',
        title: 'Code Refactoring & Clean Architecture',
        category: 'Coding',
        description:
            'Refactor code to strict SOLID principles and DartDoc standard.',
        promptText:
            'Refactor this Dart code according to Clean Architecture and SOLID principles:',
        isFavorite: true,
      ),
      PromptTemplate(
        id: 'prompt-3',
        title: 'Marketing Copy Generator',
        category: 'Marketing',
        description:
            'Generate high-converting landing page headlines and value propositions.',
        promptText:
            'Create 5 compelling marketing headlines for the following product:',
      ),
    ]);

    // Seed Agents (Amendment 3.1N)
    _agents.addAll(const [
      Agent(
        id: 'agent-coding',
        name: 'Coding & Architecture Agent',
        roleDescription:
            'Expert Flutter, Dart, and Clean Architecture specialist.',
        defaultModelId: 'gemini-3.6-flash',
      ),
      Agent(
        id: 'agent-research',
        name: 'Market Research Agent',
        roleDescription:
            'Analyzes competitive landscapes and industry benchmarks.',
        defaultModelId: 'gemini-3.6-flash',
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
    _persist();
    return conv;
  }

  void deleteConversation(String id) {
    _conversations.removeWhere((c) => c.id == id);
    _messages.remove(id);
    _persist();
  }

  void bulkDeleteConversations(List<String> ids) {
    _conversations.removeWhere((c) => ids.contains(c.id));
    for (final id in ids) {
      _messages.remove(id);
    }
    _persist();
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
    _persist();
    return msg;
  }

  void deleteMessage(String messageId) {
    for (final list in _messages.values) {
      list.removeWhere((m) => m.id == messageId);
    }
    _persist();
  }

  // Folder Methods
  List<ConversationFolder> getFolders() => List.unmodifiable(_folders);
  ConversationFolder saveFolder(ConversationFolder folder) {
    _folders.add(folder);
    _persist();
    return folder;
  }

  void deleteFolder(String id) {
    _folders.removeWhere((folder) => folder.id == id);
    _persist();
  }

  /// Persists session recovery fields after they are updated by the app.
  void persistSession() => _persist();

  // Model & Prompt Methods
  List<AiModel> getModels() => List.unmodifiable(_models);
  List<PromptTemplate> getPromptTemplates() =>
      List.unmodifiable(_promptTemplates);
  List<Agent> getAgents() => List.unmodifiable(_agents);

  void _restore() {
    if (!Hive.isBoxOpen(_boxName)) return;
    final raw = Hive.box<dynamic>(_boxName).get('workspace');
    if (raw is! Map) return;
    try {
      final json = Map<String, dynamic>.from(raw);
      final conversations = _maps(
        json['conversations'],
      ).map(_conversationFromJson);
      final folders = _maps(json['folders']).map(_folderFromJson);
      final messages = Map<String, dynamic>.from(
        json['messages'] as Map? ?? {},
      );
      _conversations
        ..clear()
        ..addAll(conversations);
      _folders
        ..clear()
        ..addAll(folders);
      _messages
        ..clear()
        ..addAll(
          messages.map(
            (id, items) =>
                MapEntry(id, _maps(items).map(_messageFromJson).toList()),
          ),
        );
      lastActiveConversationId = json['lastActiveConversationId'] as String?;
      draftPromptText = json['draftPromptText'] as String?;
      selectedModelId =
          json['selectedModelId'] as String? ?? 'gemini-3.6-flash';
      lastScrollOffset = (json['lastScrollOffset'] as num?)?.toDouble() ?? 0;
      isSidebarExpanded = json['isSidebarExpanded'] as bool? ?? true;
    } catch (_) {
      // Ignore malformed cache data and retain the safe seeded workspace.
    }
  }

  void _persist() {
    if (!Hive.isBoxOpen(_boxName)) return;
    final payload = <String, dynamic>{
      'conversations': _conversations.map(_conversationToJson).toList(),
      'folders': _folders.map(_folderToJson).toList(),
      'messages': _messages.map(
        (id, items) => MapEntry(id, items.map(_messageToJson).toList()),
      ),
      'lastActiveConversationId': lastActiveConversationId,
      'draftPromptText': draftPromptText,
      'selectedModelId': selectedModelId,
      'lastScrollOffset': lastScrollOffset,
      'isSidebarExpanded': isSidebarExpanded,
    };
    unawaited(Hive.box<dynamic>(_boxName).put('workspace', payload));
  }

  static Map<String, dynamic> _conversationToJson(Conversation item) => {
    'id': item.id,
    'title': item.title,
    'folderId': item.folderId,
    'modelId': item.modelId,
    'isPinned': item.isPinned,
    'isArchived': item.isArchived,
    'systemPrompt': item.systemPrompt,
    'createdAt': item.createdAt.toIso8601String(),
    'updatedAt': item.updatedAt.toIso8601String(),
    'messageCount': item.messageCount,
    'totalTokens': item.totalTokens,
    'tags': item.tags,
  };

  static Conversation _conversationFromJson(Map<String, dynamic> json) =>
      Conversation(
        id: json['id'] as String,
        title: json['title'] as String,
        folderId: json['folderId'] as String?,
        modelId: json['modelId'] as String? ?? 'gemini-3.6-flash',
        isPinned: json['isPinned'] as bool? ?? false,
        isArchived: json['isArchived'] as bool? ?? false,
        systemPrompt: json['systemPrompt'] as String?,
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: DateTime.parse(json['updatedAt'] as String),
        messageCount: (json['messageCount'] as num?)?.toInt() ?? 0,
        totalTokens: (json['totalTokens'] as num?)?.toInt() ?? 0,
        tags: _strings(json['tags']),
      );

  static Map<String, dynamic> _folderToJson(ConversationFolder item) => {
    'id': item.id,
    'name': item.name,
    'createdAt': item.createdAt.toIso8601String(),
    'colorHex': item.colorHex,
    'iconName': item.iconName,
    'isExpanded': item.isExpanded,
  };

  static ConversationFolder _folderFromJson(Map<String, dynamic> json) =>
      ConversationFolder(
        id: json['id'] as String,
        name: json['name'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String),
        colorHex: json['colorHex'] as String? ?? '#3D82F7',
        iconName: json['iconName'] as String? ?? 'folder',
        isExpanded: json['isExpanded'] as bool? ?? true,
      );

  static Map<String, dynamic> _messageToJson(ChatMessage item) => {
    'id': item.id,
    'conversationId': item.conversationId,
    'role': item.role.name,
    'content': item.content,
    'createdAt': item.createdAt.toIso8601String(),
    'attachments': item.attachments
        .map(
          (attachment) => {
            'id': attachment.id,
            'fileName': attachment.fileName,
            'fileSizeBytes': attachment.fileSizeBytes,
            'type': attachment.type.name,
            'localPath': attachment.localPath,
            'remoteUrl': attachment.remoteUrl,
            'mimeType': attachment.mimeType,
          },
        )
        .toList(),
    'tokenCount': item.tokenCount,
    'modelId': item.modelId,
    'isError': item.isError,
    'isBookmarked': item.isBookmarked,
    'isPinned': item.isPinned,
    'thinkingDurationMs': item.thinkingDurationMs,
  };

  static ChatMessage _messageFromJson(Map<String, dynamic> json) => ChatMessage(
    id: json['id'] as String,
    conversationId: json['conversationId'] as String,
    role: MessageRole.values.byName(json['role'] as String),
    content: json['content'] as String? ?? '',
    createdAt: DateTime.parse(json['createdAt'] as String),
    attachments: _maps(json['attachments'])
        .map(
          (item) => MessageAttachment(
            id: item['id'] as String,
            fileName: item['fileName'] as String,
            fileSizeBytes: (item['fileSizeBytes'] as num).toInt(),
            type: AttachmentType.values.byName(item['type'] as String),
            localPath: item['localPath'] as String?,
            remoteUrl: item['remoteUrl'] as String?,
            mimeType: item['mimeType'] as String?,
          ),
        )
        .toList(),
    tokenCount: (json['tokenCount'] as num?)?.toInt() ?? 0,
    modelId: json['modelId'] as String?,
    isError: json['isError'] as bool? ?? false,
    isBookmarked: json['isBookmarked'] as bool? ?? false,
    isPinned: json['isPinned'] as bool? ?? false,
    thinkingDurationMs: (json['thinkingDurationMs'] as num?)?.toInt(),
  );

  static List<Map<String, dynamic>> _maps(Object? value) =>
      (value as List<dynamic>? ?? const [])
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList();

  static List<String> _strings(Object? value) =>
      (value as List<dynamic>? ?? const [])
          .map((item) => item.toString())
          .toList();
}
