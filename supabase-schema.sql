-- Buddy Reward System: hosted state for the static GitHub Pages app.
-- Run this script once in the Supabase SQL Editor.

create table if not exists public.app_state (
  id text primary key check (id = 'primary'),
  data jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.app_state enable row level security;

-- The app currently has a legacy client-side login rather than Supabase Auth.
-- These policies allow the browser app to synchronize its single JSON state
-- document with the publishable/anon key.
drop policy if exists "BRS public state read" on public.app_state;
drop policy if exists "BRS public state write" on public.app_state;
drop policy if exists "BRS public state update" on public.app_state;

create policy "BRS public state read"
  on public.app_state for select
  to anon, authenticated
  using (true);

create policy "BRS public state write"
  on public.app_state for insert
  to anon, authenticated
  with check (id = 'primary');

create policy "BRS public state update"
  on public.app_state for update
  to anon, authenticated
  using (id = 'primary')
  with check (id = 'primary');

grant select, insert, update on public.app_state to anon, authenticated;
