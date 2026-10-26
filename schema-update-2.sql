-- Run once in Supabase: SQL Editor > New query > paste > Run. Safe to run twice.
alter table visits
  add column if not exists outcome text,
  add column if not exists contact_name text,
  add column if not exists product text,
  add column if not exists objection text,
  add column if not exists visited_by text;
