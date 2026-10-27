-- Run once in Supabase: SQL Editor > New query > paste > Run. Safe to run twice.
create table if not exists day_reports (
  id uuid primary key default gen_random_uuid(),
  report_date date not null,
  author text not null,
  went_well text,
  went_bad text,
  objections text,
  openers text,
  learned text,
  tomorrow text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (report_date, author)
);
alter table day_reports enable row level security;
drop policy if exists "team read day_reports" on day_reports;
drop policy if exists "team insert day_reports" on day_reports;
drop policy if exists "team update day_reports" on day_reports;
create policy "team read day_reports"   on day_reports for select to authenticated using (true);
create policy "team insert day_reports" on day_reports for insert to authenticated with check (true);
create policy "team update day_reports" on day_reports for update to authenticated using (true) with check (true);
