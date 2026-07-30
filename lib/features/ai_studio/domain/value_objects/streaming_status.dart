/// Enumeration of AI Message Streaming Statuses.
library;

/// Represents the current execution lifecycle state of a streaming AI response.
enum StreamingStatus {
  /// Streaming operation has not started yet.
  idle,

  /// Model is actively processing prompt context & thinking.
  thinking,

  /// Tokens are actively streaming to the client.
  streaming,

  /// Response generation completed cleanly.
  completed,

  /// Response generation was stopped by user request.
  cancelled,

  /// Response generation encountered a domain failure or network error.
  error;

  /// Whether the AI model is actively generating or thinking.
  bool get isGenerating =>
      this == StreamingStatus.thinking || this == StreamingStatus.streaming;
}
