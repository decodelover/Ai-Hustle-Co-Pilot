/// Model Selector Controller (Amendment 3.1D)
library;

import 'package:ai_hustle_copilot/features/ai_studio/application/ai_workspace_providers.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/ai_model.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/repositories/ai_studio_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// State representation for AI model selector and context window metrics.
final class ModelSelectorState {
  const ModelSelectorState({
    this.models = const [],
    this.selectedModelId = 'gemini-3.6-flash',
    this.usedTokens = 0,
    this.isLoading = false,
  });

  final List<AiModel> models;
  final String selectedModelId;
  final int usedTokens;
  final bool isLoading;

  /// Returns selected model entity.
  AiModel? get selectedModel {
    try {
      return models.firstWhere((m) => m.id == selectedModelId);
    } catch (_) {
      return models.isNotEmpty ? models.first : null;
    }
  }

  /// Calculates percentage of context window used.
  double get contextWindowUsageRatio {
    final model = selectedModel;
    if (model == null || model.contextWindowTokens == 0) return 0.0;
    final ratio = usedTokens / model.contextWindowTokens;
    return ratio.clamp(0.0, 1.0);
  }

  ModelSelectorState copyWith({
    List<AiModel>? models,
    String? selectedModelId,
    int? usedTokens,
    bool? isLoading,
  }) {
    return ModelSelectorState(
      models: models ?? this.models,
      selectedModelId: selectedModelId ?? this.selectedModelId,
      usedTokens: usedTokens ?? this.usedTokens,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// Controller managing model selection, available models, and context token budgeting.
final class ModelSelectorController extends StateNotifier<ModelSelectorState> {
  ModelSelectorController({required this.repository})
    : super(const ModelSelectorState()) {
    loadModels();
  }

  final AiStudioRepository repository;

  /// Loads available AI models.
  Future<void> loadModels() async {
    state = state.copyWith(isLoading: true);
    try {
      final models = await repository.getAvailableModels();
      state = state.copyWith(models: models, isLoading: false);
    } catch (_) {
      state = state.copyWith(isLoading: false);
    }
  }

  /// Selects active AI model.
  void selectModel(String modelId) {
    state = state.copyWith(selectedModelId: modelId);
  }

  /// Updates token usage metrics.
  void updateTokenUsage(int tokens) {
    state = state.copyWith(usedTokens: tokens);
  }
}

/// Provider for [ModelSelectorController].
final modelSelectorControllerProvider =
    StateNotifierProvider<ModelSelectorController, ModelSelectorState>((ref) {
      final repo = ref.watch(aiStudioRepositoryProvider);
      return ModelSelectorController(repository: repo);
    });
