/// Domain Entity: CreditWallet (Amendment 3.2G)
library;

/// Subscription plan tier.
enum SubscriptionPlanTier {
  /// Free Tier (20 daily credits).
  free,

  /// Premium Tier (500 daily credits).
  premium,

  /// Enterprise Tier (Unlimited credits).
  enterprise,
}

/// Immutable domain entity representing user AI credit wallet.
final class CreditWallet {
  /// Creates a [CreditWallet].
  const CreditWallet({
    required this.userId,
    required this.tier,
    required this.availableCredits,
    required this.dailyLimit,
    required this.lastResetAt,
  });

  /// Owner user ID.
  final String userId;

  /// Subscription tier.
  final SubscriptionPlanTier tier;

  /// Current remaining credits.
  final double availableCredits;

  /// Maximum daily credit allocation.
  final double dailyLimit;

  /// Last daily quota reset timestamp.
  final DateTime lastResetAt;

  /// Whether user has sufficient credits to execute prompt request.
  bool canExecute(double requiredCredits) {
    if (tier == SubscriptionPlanTier.enterprise) return true;
    return availableCredits >= requiredCredits;
  }
}
