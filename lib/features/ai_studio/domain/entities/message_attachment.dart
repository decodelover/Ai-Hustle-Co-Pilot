/// Domain Entity: MessageAttachment
library;

import 'package:ai_hustle_copilot/features/ai_studio/domain/value_objects/attachment_type.dart';

/// Immutable domain entity representing a file attachment in a prompt or message.
final class MessageAttachment {
  /// Creates a [MessageAttachment].
  const MessageAttachment({
    required this.id,
    required this.fileName,
    required this.fileSizeBytes,
    required this.type,
    this.localPath,
    this.remoteUrl,
    this.mimeType,
  });

  /// Unique attachment identifier.
  final String id;

  /// Original name of the attached file.
  final String fileName;

  /// File size in bytes.
  final int fileSizeBytes;

  /// Category of attachment.
  final AttachmentType type;

  /// Local filesystem path (if cached or uploading).
  final String? localPath;

  /// Remote URL (if uploaded to cloud storage).
  final String? remoteUrl;

  /// MIME type string (e.g., 'image/png').
  final String? mimeType;

  /// Formatted file size string (e.g. '2.4 MB').
  String get formattedSize {
    if (fileSizeBytes < 1024) return '$fileSizeBytes B';
    if (fileSizeBytes < 1024 * 1024) {
      return '${(fileSizeBytes / 1024).toStringAsFixed(1)} KB';
    }
    return '${(fileSizeBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  /// Creates a copy with updated properties.
  MessageAttachment copyWith({
    String? id,
    String? fileName,
    int? fileSizeBytes,
    AttachmentType? type,
    String? localPath,
    String? remoteUrl,
    String? mimeType,
  }) {
    return MessageAttachment(
      id: id ?? this.id,
      fileName: fileName ?? this.fileName,
      fileSizeBytes: fileSizeBytes ?? this.fileSizeBytes,
      type: type ?? this.type,
      localPath: localPath ?? this.localPath,
      remoteUrl: remoteUrl ?? this.remoteUrl,
      mimeType: mimeType ?? this.mimeType,
    );
  }
}
