-- AI Hustle Co-Pilot production schema and row-level security.
create extension if not exists pgcrypto;

create or replace function public.set_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = timezone('utc', now());
  return new;
end;
$$;

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  display_name text,
  avatar_url text,
  skills text[] not null default '{}',
  preferences jsonb not null default '{}',
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now())
);

create table if not exists public.projects (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade,
  title text not null check (length(title) between 1 and 160),
  description text not null default '',
  category text not null,
  progress numeric(4,3) not null default 0 check (progress between 0 and 1),
  health_score integer not null default 100 check (health_score between 0 and 100),
  context jsonb not null default '{}',
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now())
);

create table if not exists public.project_tasks (
  id uuid primary key default gen_random_uuid(),
  project_id uuid not null references public.projects(id) on delete cascade,
  title text not null,
  description text not null default '',
  status text not null default 'pending',
  assigned_agent_id text,
  progress numeric(4,3) not null default 0 check (progress between 0 and 1),
  execution_logs jsonb not null default '[]',
  completed_at timestamptz,
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now())
);

create table if not exists public.documents (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade,
  project_id uuid references public.projects(id) on delete cascade,
  title text not null default 'Untitled Document',
  emoji_icon text,
  cover_image_url text,
  status text not null default 'draft',
  template_id text,
  current_version_number integer not null default 1,
  metadata jsonb not null default '{}',
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now())
);

create table if not exists public.document_blocks (
  id uuid primary key default gen_random_uuid(),
  document_id uuid not null references public.documents(id) on delete cascade,
  parent_block_id uuid references public.document_blocks(id) on delete cascade,
  block_type text not null default 'paragraph',
  text_content text not null default '',
  attributes jsonb not null default '{}',
  sort_order integer not null default 0,
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now())
);

create table if not exists public.document_versions (
  id uuid primary key default gen_random_uuid(),
  document_id uuid not null references public.documents(id) on delete cascade,
  version_number integer not null,
  commit_message text not null,
  snapshot_blocks jsonb not null default '[]',
  created_by uuid references auth.users(id) on delete set null,
  is_ai_generated boolean not null default false,
  created_at timestamptz not null default timezone('utc', now()),
  unique(document_id, version_number)
);

create table if not exists public.opportunities (
  id uuid primary key default gen_random_uuid(),
  source text not null,
  external_id text,
  title text not null,
  description text not null default '',
  category text not null,
  budget_min numeric,
  budget_max numeric,
  currency text not null default 'USD',
  skills text[] not null default '{}',
  source_url text,
  published_at timestamptz not null default timezone('utc', now()),
  unique(source, external_id)
);

create table if not exists public.applications (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade,
  opportunity_id uuid references public.opportunities(id) on delete set null,
  role_title text not null,
  company_name text not null,
  status text not null default 'draft',
  proposal_document_id uuid references public.documents(id) on delete set null,
  next_action text,
  follow_up_at timestamptz,
  metadata jsonb not null default '{}',
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now())
);

create table if not exists public.conversations (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade,
  title text not null default 'New conversation',
  model_id text not null default 'gemini-3.6-flash',
  system_prompt text,
  is_pinned boolean not null default false,
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now())
);

create table if not exists public.messages (
  id uuid primary key default gen_random_uuid(),
  conversation_id uuid not null references public.conversations(id) on delete cascade,
  role text not null check (role in ('user', 'assistant', 'system', 'tool')),
  content text not null,
  model_id text,
  token_count integer not null default 0,
  attachments jsonb not null default '[]',
  created_at timestamptz not null default timezone('utc', now())
);

create index if not exists projects_owner_idx on public.projects(owner_id, updated_at desc);
create index if not exists documents_owner_idx on public.documents(owner_id, updated_at desc);
create index if not exists documents_project_idx on public.documents(project_id);
create index if not exists blocks_document_order_idx on public.document_blocks(document_id, sort_order);
create index if not exists applications_owner_idx on public.applications(owner_id, updated_at desc);
create index if not exists conversations_owner_idx on public.conversations(owner_id, updated_at desc);
create index if not exists messages_conversation_idx on public.messages(conversation_id, created_at);

drop trigger if exists profiles_updated_at on public.profiles;
create trigger profiles_updated_at before update on public.profiles
for each row execute function public.set_updated_at();
drop trigger if exists projects_updated_at on public.projects;
create trigger projects_updated_at before update on public.projects
for each row execute function public.set_updated_at();
drop trigger if exists documents_updated_at on public.documents;
create trigger documents_updated_at before update on public.documents
for each row execute function public.set_updated_at();
drop trigger if exists applications_updated_at on public.applications;
create trigger applications_updated_at before update on public.applications
for each row execute function public.set_updated_at();
drop trigger if exists conversations_updated_at on public.conversations;
create trigger conversations_updated_at before update on public.conversations
for each row execute function public.set_updated_at();

alter table public.profiles enable row level security;
alter table public.projects enable row level security;
alter table public.project_tasks enable row level security;
alter table public.documents enable row level security;
alter table public.document_blocks enable row level security;
alter table public.document_versions enable row level security;
alter table public.opportunities enable row level security;
alter table public.applications enable row level security;
alter table public.conversations enable row level security;
alter table public.messages enable row level security;

create policy "profiles_own" on public.profiles for all
using (id = auth.uid()) with check (id = auth.uid());
create policy "projects_own" on public.projects for all
using (owner_id = auth.uid()) with check (owner_id = auth.uid());
create policy "tasks_via_project" on public.project_tasks for all
using (exists (select 1 from public.projects p where p.id = project_id and p.owner_id = auth.uid()))
with check (exists (select 1 from public.projects p where p.id = project_id and p.owner_id = auth.uid()));
create policy "documents_own" on public.documents for all
using (owner_id = auth.uid()) with check (owner_id = auth.uid());
create policy "blocks_via_document" on public.document_blocks for all
using (exists (select 1 from public.documents d where d.id = document_id and d.owner_id = auth.uid()))
with check (exists (select 1 from public.documents d where d.id = document_id and d.owner_id = auth.uid()));
create policy "versions_via_document" on public.document_versions for all
using (exists (select 1 from public.documents d where d.id = document_id and d.owner_id = auth.uid()))
with check (exists (select 1 from public.documents d where d.id = document_id and d.owner_id = auth.uid()));
create policy "opportunities_authenticated_read" on public.opportunities for select
to authenticated using (true);
create policy "applications_own" on public.applications for all
using (owner_id = auth.uid()) with check (owner_id = auth.uid());
create policy "conversations_own" on public.conversations for all
using (owner_id = auth.uid()) with check (owner_id = auth.uid());
create policy "messages_via_conversation" on public.messages for all
using (exists (select 1 from public.conversations c where c.id = conversation_id and c.owner_id = auth.uid()))
with check (exists (select 1 from public.conversations c where c.id = conversation_id and c.owner_id = auth.uid()));

grant usage on schema public to authenticated;
grant select, insert, update, delete on all tables in schema public to authenticated;
