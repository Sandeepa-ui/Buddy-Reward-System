-- Buddy Reward System: hosted state for the static GitHub Pages app.
-- Run this script in Supabase SQL Editor before adding credentials to supabase-config.js.

create table if not exists public.app_state (
  id text primary key check (id = 'primary'),
  data jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.app_state enable row level security;

-- The current single-file app has its own legacy login screen, so it does not
-- have a Supabase Auth session. These policies allow the browser app to sync
-- its one JSON state document using the publishable/anon key.
drop policy if exists "BRS public state read" on public.app_state;
drop policy if exists "BRS public state write" on public.app_state;
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
