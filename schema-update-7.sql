-- Run once in Supabase: SQL Editor > New query > paste > Run. Safe to run twice.
-- Lets the team correct earlier visits (edit button in "Eerdere bezoeken"). Deleting was already allowed.
drop policy if exists "team update visits" on visits;
create policy "team update visits" on visits for update to authenticated using (true) with check (true);
