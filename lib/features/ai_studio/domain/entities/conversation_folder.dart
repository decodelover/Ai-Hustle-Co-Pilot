/// Domain Entity: ConversationFolder
library;

/// Immutable domain entity representing an organizational folder for conversations.
final class ConversationFolder {
  /// Creates a [ConversationFolder].
  const ConversationFolder({
    required this.id,
    required this.name,
    required this.createdAt,
    this.colorHex = '#3D82F7',
    this.iconName = 'folder',
    this.isExpanded = true,
  });

  /// Unique folder ID.
  final String id;

  /// Folder display name.
  final String name;

  /// Creation timestamp.
  final DateTime createdAt;

  /// Hex color token for folder badge.
  final String colorHex;

  /// Icon identifier.
  final String iconName;

  /// Whether folder node is expanded in sidebar.
  final bool isExpanded;

  /// Creates a copy with modified properties.
  ConversationFolder copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
    String? colorHex,
    String? iconName,
    bool? isExpanded,
  }) {
    return ConversationFolder(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      colorHex: colorHex ?? this.colorHex,
      iconName: iconName ?? this.iconName,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }
}
