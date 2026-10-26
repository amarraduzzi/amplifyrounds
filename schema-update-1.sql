-- Run once in Supabase: SQL Editor > New query > paste > Run. Safe to run twice.
alter table restaurants
  add column if not exists kind text,
  add column if not exists website_status text default 'unknown',
  add column if not exists g_rating numeric,
  add column if not exists g_reviews integer,
  add column if not exists area text;
