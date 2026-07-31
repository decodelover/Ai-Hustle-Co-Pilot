/// Application Controller: CreditWalletController (Amendment 3.2G)
library;

import 'package:ai_hustle_copilot/features/ai_studio/data/repositories/credit_repository_impl.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/credit_wallet.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/repositories/credit_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Riverpod controller managing user CreditWallet state.
class CreditWalletController extends StateNotifier<AsyncValue<CreditWallet>> {
  /// Creates a [CreditWalletController].
  CreditWalletController({CreditRepository? creditRepository})
    : _creditRepository = creditRepository ?? CreditRepositoryImpl(),
      super(const AsyncLoading()) {
    loadWallet();
  }

  final CreditRepository _creditRepository;

  /// Loads current wallet.
  Future<void> loadWallet() async {
    try {
      final wallet = await _creditRepository.getWallet();
      state = AsyncData(wallet);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// Deducts credit cost.
  Future<void> deduct(double cost) async {
    try {
      final updated = await _creditRepository.deductCredits(cost);
      state = AsyncData(updated);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
