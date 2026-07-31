# Supabase backend

The migration in `migrations/` defines the production data model, indexes, ownership constraints, and row-level security policies.

Apply it to a linked project with:

```sh
supabase db push
```

The client uses only the publishable key. Administrative ingestion of opportunities must run through a trusted server or Supabase Edge Function using a service-role credential; that credential must never be bundled in Flutter.
