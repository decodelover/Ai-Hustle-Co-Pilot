/// Domain Repository Contract: CreditRepository (Amendment 3.2G)
library;

import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/credit_wallet.dart';

/// Repository managing user subscription tier and AI credit balances.
abstract interface class CreditRepository {
  /// Fetches credit wallet status for active user.
  Future<CreditWallet> getWallet();

  /// Deducts credit cost after prompt completion.
  Future<CreditWallet> deductCredits(double amount);
}
