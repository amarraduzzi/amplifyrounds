-- Run once in Supabase: SQL Editor > New query > paste > Run. Safe to run twice.
alter table restaurants
  add column if not exists next_time text;
