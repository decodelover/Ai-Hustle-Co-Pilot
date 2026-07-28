# Security Policy

## Supported Versions

| Version | Supported |
|---------|-----------|
| 1.0.x   | ✅ Active |

## Reporting a Vulnerability

We take the security of AI Hustle Co-Pilot seriously. If you discover a security vulnerability, please report it responsibly.

### How to Report

1. **Do NOT** open a public GitHub issue for security vulnerabilities.
2. Email the security report to the project maintainers via GitHub's private vulnerability reporting feature.
3. Include the following information:
   - Description of the vulnerability
   - Steps to reproduce the issue
   - Potential impact assessment
   - Any suggested fixes (optional)

### Response Timeline

| Stage | Timeline |
|-------|----------|
| Acknowledgment | Within 48 hours |
| Initial assessment | Within 5 business days |
| Resolution target | Within 30 days for critical issues |
| Public disclosure | After fix is deployed and users have reasonable time to update |

### What We Consider Security Issues

- Authentication bypass or session hijacking
- Unauthorized data access or data leakage
- API key or credential exposure
- Injection vulnerabilities (SQL, NoSQL, LDAP)
- Cross-site scripting (XSS) in WebView contexts
- Insecure data storage on device
- Man-in-the-middle attack vectors
- Improper certificate validation
- Token leakage in logs or error messages
- Row Level Security (RLS) bypass in Supabase

### Security Architecture

AI Hustle Co-Pilot implements the following security measures:

#### Credential Management
- API keys and secrets are loaded via environment configuration (`.env` + Envied)
- Sensitive user tokens are stored using `flutter_secure_storage` (Keychain on iOS, EncryptedSharedPreferences on Android)
- `.env` files are excluded from version control via `.gitignore`

#### Authentication
- Supabase Authentication with email/password and OAuth providers
- Session token management with automatic refresh
- Secure token storage and retrieval

#### Data Protection
- Row Level Security (RLS) policies on all Supabase tables
- Input validation using domain-level Value Objects (`Email`, `Password`)
- No sensitive data in application logs (production mode)

#### Network Security
- HTTPS-only communication
- Certificate pinning ready (via Dio interceptors)
- Authentication interceptor for automatic token injection
- Error interceptor preventing raw exception leakage

#### Code Security
- Strict Dart analysis with `strict-casts`, `strict-inference`, `strict-raw-types`
- No hardcoded credentials in source code
- Generated code excluded from version control

### Responsible Disclosure

We appreciate the security research community and will:

- Acknowledge your contribution in our security advisories (with your permission)
- Not pursue legal action against researchers acting in good faith
- Work with you to understand and resolve the issue promptly
- Keep you informed of our progress toward resolution

## Security Best Practices for Contributors

When contributing to this project:

1. **Never** hardcode API keys, database URLs, or tokens in source code
2. **Always** use `SecureStorageService` for sensitive data persistence
3. **Always** validate and sanitize user inputs at the domain layer
4. **Never** log sensitive user data, tokens, or credentials
5. **Always** use the established error mapping system (never expose raw exceptions to UI)
6. **Always** test authentication flows for edge cases (expired tokens, revoked sessions)

## Contact

For security-related inquiries, please use GitHub's private vulnerability reporting feature on this repository.
