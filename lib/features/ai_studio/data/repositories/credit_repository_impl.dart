/// Data Repository Implementation: CreditRepositoryImpl (Amendment 3.2G)
library;

import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/credit_wallet.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/repositories/credit_repository.dart';

/// Concrete credit repository managing subscription limits and wallet balances.
final class CreditRepositoryImpl implements CreditRepository {
  CreditWallet _wallet = CreditWallet(
    userId: 'user_active_1',
    tier: SubscriptionPlanTier.premium,
    availableCredits: 485.0,
    dailyLimit: 500.0,
    lastResetAt: DateTime.now(),
  );

  @override
  Future<CreditWallet> getWallet() async {
    return _wallet;
  }

  @override
  Future<CreditWallet> deductCredits(double amount) async {
    final updatedCredits = (_wallet.availableCredits - amount).clamp(
      0.0,
      _wallet.dailyLimit,
    );
    _wallet = CreditWallet(
      userId: _wallet.userId,
      tier: _wallet.tier,
      availableCredits: updatedCredits,
      dailyLimit: _wallet.dailyLimit,
      lastResetAt: _wallet.lastResetAt,
    );
    return _wallet;
  }
}
