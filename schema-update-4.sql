-- Run once in Supabase: SQL Editor > New query > paste > Run. Safe to run twice.
create table if not exists followups (
  id uuid primary key default gen_random_uuid(),
  restaurant_id uuid not null references restaurants(id) on delete cascade,
  type text not null default 'revisit',
  due_date date not null,
  status text not null default 'open' check (status in ('open','done','cancelled')),
  note text,
  source text not null default 'manual',
  history jsonb not null default '[]'::jsonb,
  created_at timestamptz not null default now(),
  done_at timestamptz,
  created_by uuid default auth.uid()
);
create index if not exists followups_due_idx on followups(status, due_date);
alter table followups enable row level security;
drop policy if exists "team read followups" on followups;
drop policy if exists "team insert followups" on followups;
drop policy if exists "team update followups" on followups;
drop policy if exists "team delete followups" on followups;
create policy "team read followups"   on followups for select to authenticated using (true);
create policy "team insert followups" on followups for insert to authenticated with check (true);
create policy "team update followups" on followups for update to authenticated using (true) with check (true);
create policy "team delete followups" on followups for delete to authenticated using (true);
-- Existing "next contact" dates become open follow-ups (only for restaurants that have none yet).
insert into followups (restaurant_id, type, due_date, note, source)
select r.id, 'revisit', r.next_contact, r.next_step, 'visit'
from restaurants r
where r.next_contact is not null
  and not exists (select 1 from followups f where f.restaurant_id = r.id);
