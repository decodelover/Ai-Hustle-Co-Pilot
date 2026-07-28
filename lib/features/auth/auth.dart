/// Central Authentication Feature barrel export for AI Hustle Co-Pilot.
///
/// Exposes domain entities, value objects, repository contracts, application
/// controllers, providers, custom widgets, and presentation screens.
library;

// ── Application Layer ───────────────────────────────────────────────────
export 'application/controllers/base_auth_controller.dart';
export 'application/controllers/refresh_session_controller.dart';
export 'application/controllers/resend_verification_controller.dart';
export 'application/controllers/reset_password_controller.dart';
export 'application/controllers/sign_in_controller.dart';
export 'application/controllers/sign_out_controller.dart';
export 'application/controllers/sign_up_controller.dart';
export 'application/providers/auth_application_providers.dart';
export 'application/state/auth_action_state.dart';
export 'application/state/auth_form_state.dart';

// ── Domain Layer ────────────────────────────────────────────────────────
export 'domain/auth_state.dart';
export 'domain/entities/auth_user.dart';
export 'domain/failures/auth_failure.dart';
export 'domain/repositories/auth_repository.dart';
export 'domain/use_cases/get_current_user_use_case.dart';
export 'domain/use_cases/observe_auth_state_use_case.dart';
export 'domain/use_cases/refresh_session_use_case.dart';
export 'domain/use_cases/resend_verification_email_use_case.dart';
export 'domain/use_cases/reset_password_use_case.dart';
export 'domain/use_cases/sign_in_use_case.dart';
export 'domain/use_cases/sign_out_use_case.dart';
export 'domain/use_cases/sign_up_use_case.dart';
export 'domain/value_objects/email.dart';
export 'domain/value_objects/password.dart';

// ── Presentation Layer ──────────────────────────────────────────────────
export 'presentation/providers/auth_state_provider.dart';
export 'presentation/screens/email_verification_screen.dart';
export 'presentation/screens/forgot_password_screen.dart';
export 'presentation/screens/login_screen.dart';
export 'presentation/screens/register_screen.dart';
export 'presentation/screens/verification_success_screen.dart';
export 'presentation/screens/welcome_screen.dart';
export 'presentation/widgets/auth_footer_widget.dart';
export 'presentation/widgets/auth_header_widget.dart';
export 'presentation/widgets/or_divider_widget.dart';
export 'presentation/widgets/password_strength_widget.dart';
export 'presentation/widgets/remember_me_widget.dart';
export 'presentation/widgets/social_login_buttons.dart';
export 'presentation/widgets/terms_checkbox_widget.dart';
export 'presentation/widgets/verification_banner_widget.dart';
