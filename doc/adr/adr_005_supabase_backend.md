# ADR-005: Supabase as Backend Infrastructure

## Status
Accepted

## Date
2026-07-28

## Context & Problem Statement

We needed a backend-as-a-service (BaaS) solution providing:
1. Authentication (email/password, OAuth providers)
2. PostgreSQL database with Row Level Security
3. Real-time data subscriptions
4. File storage
5. Edge functions for serverless logic

## Alternatives Considered

### 1. Firebase
- Mature ecosystem but NoSQL limitations for complex queries, vendor lock-in to Google, pricing unpredictability at scale

### 2. AWS Amplify
- Full AWS integration but complex configuration, steep learning curve, heavy SDK

### 3. Custom Backend (Node.js/Express)
- Maximum flexibility but significant development overhead, requires DevOps expertise, no built-in auth

### 4. Supabase (Selected)
- Open-source, PostgreSQL-based, built-in auth with OAuth, Row Level Security, real-time, file storage, edge functions

## Decision & Rationale

Supabase was selected because:
- **PostgreSQL**: Full relational database power with complex queries, joins, and migrations
- **Row Level Security**: Database-level access control reduces application-layer security burden
- **Built-in Auth**: Email/password + OAuth (Google, GitHub) with JWT management
- **Open Source**: No vendor lock-in, self-hostable for enterprise deployments
- **Flutter SDK**: First-class Dart/Flutter support via `supabase_flutter`

## Integration Architecture

```
Flutter App
    │
    ▼
supabase_flutter SDK
    │
    ├── Auth → Supabase Auth (GoTrue)
    ├── Database → PostgreSQL (PostgREST)
    ├── Storage → Supabase Storage (S3-compatible)
    ├── Realtime → Supabase Realtime (WebSocket)
    └── Functions → Supabase Edge Functions (Deno)
```

## Consequences

### Positive
- PostgreSQL enables complex relational queries
- RLS eliminates entire categories of authorization bugs
- Real-time subscriptions for live data updates
- Self-hostable for enterprise compliance requirements

### Negative
- Supabase is younger than Firebase, smaller community
- Some features (edge functions, branching) are still maturing
- Requires PostgreSQL knowledge for optimal schema design
