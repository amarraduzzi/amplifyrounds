-- Run once in Supabase: SQL Editor > New query > paste > Run. Safe to run twice.
create table if not exists app_texts (
  key text primary key,
  body text not null,
  updated_at timestamptz not null default now()
);
alter table app_texts enable row level security;
drop policy if exists "team read app_texts" on app_texts;
drop policy if exists "team insert app_texts" on app_texts;
drop policy if exists "team update app_texts" on app_texts;
drop policy if exists "team delete app_texts" on app_texts;
create policy "team read app_texts"   on app_texts for select to authenticated using (true);
create policy "team insert app_texts" on app_texts for insert to authenticated with check (true);
create policy "team update app_texts" on app_texts for update to authenticated using (true) with check (true);
create policy "team delete app_texts" on app_texts for delete to authenticated using (true);
