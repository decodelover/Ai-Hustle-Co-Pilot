/// Value Object: Supported Export Format options.
library;

/// Available document compilation export formats.
enum ExportFormat {
  /// Portable Document Format (PDF).
  pdf,

  /// Microsoft Word Document (DOCX).
  docx,

  /// Raw Markdown (.md).
  markdown,

  /// Clean HTML (.html).
  html,

  /// Plain Text (.txt).
  txt,
}

/// Extension helper for [ExportFormat].
extension ExportFormatX on ExportFormat {
  /// File extension suffix.
  String get extension => switch (this) {
        ExportFormat.pdf => 'pdf',
        ExportFormat.docx => 'docx',
        ExportFormat.markdown => 'md',
        ExportFormat.html => 'html',
        ExportFormat.txt => 'txt',
      };

  /// MIME type string.
  String get mimeType => switch (this) {
        ExportFormat.pdf => 'application/pdf',
        ExportFormat.docx =>
          'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
        ExportFormat.markdown => 'text/markdown',
        ExportFormat.html => 'text/html',
        ExportFormat.txt => 'text/plain',
      };

  /// UI label.
  String get label => switch (this) {
        ExportFormat.pdf => 'PDF Document (.pdf)',
        ExportFormat.docx => 'Microsoft Word (.docx)',
        ExportFormat.markdown => 'Markdown File (.md)',
        ExportFormat.html => 'HTML Page (.html)',
        ExportFormat.txt => 'Plain Text (.txt)',
      };
}
