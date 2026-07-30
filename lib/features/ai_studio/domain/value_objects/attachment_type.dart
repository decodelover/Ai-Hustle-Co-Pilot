/// Enumeration of Attachment Types for AI prompts.
library;

/// Supported attachment media types in the AI composer.
enum AttachmentType {
  /// Image attachment (PNG, JPG, WEBP).
  image,

  /// Document or text file (PDF, TXT, MD, CSV, JSON).
  document,

  /// Code source file (Dart, Python, JS, TS).
  code,

  /// Audio or voice recording file.
  audio;

  /// Whether this attachment is an image.
  bool get isImage => this == AttachmentType.image;
}
