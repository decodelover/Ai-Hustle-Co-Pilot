/// Enumeration of AI LLM Providers.
library;

/// Supported upstream AI model providers.
enum ModelProvider {
  /// OpenAI models (GPT-4o, GPT-4o-mini).
  openai('OpenAI', 'GPT-4o'),

  /// Google Gemini models (Gemini 1.5 Pro, Gemini Flash).
  gemini('Google Gemini', 'Gemini 1.5 Pro'),

  /// Anthropic Claude models (Claude 3.5 Sonnet).
  claude('Anthropic', 'Claude 3.5 Sonnet'),

  /// Local Llama / Custom inference endpoint.
  custom('Local / Custom', 'Llama 3.1 70B');

  /// Creates a [ModelProvider] with display label and flagship model.
  const ModelProvider(this.displayName, this.flagshipModel);

  /// Human-readable brand name of provider.
  final String displayName;

  /// Default flagship model name for provider.
  final String flagshipModel;
}
