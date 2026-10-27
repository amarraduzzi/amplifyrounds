-- Run once in Supabase: SQL Editor > New query > paste > Run. Safe to run twice.
-- Run BEFORE uploading index.html (update 12).
alter table restaurants
  add column if not exists sector text,
  add column if not exists sector_locked boolean not null default false,
  add column if not exists closed boolean not null default false;
create index if not exists restaurants_sector_idx on restaurants(sector);

-- Needed to merge duplicate restaurants (moves their visits to the one that is kept).
drop policy if exists "team update visits" on visits;
create policy "team update visits" on visits for update to authenticated using (true) with check (true);
