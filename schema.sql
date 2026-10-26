-- Amplify Tournée — Supabase schema
-- Run in Supabase: SQL Editor > New query > paste > Run

create table if not exists restaurants (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  district text,
  address text,
  phone text,
  lat double precision,
  lng double precision,
  status text not null default 'new' check (status in ('new','appt','demo','client','lost')),
  next_step text,
  next_contact date,
  last_visit_at timestamptz,
  created_at timestamptz not null default now(),
  created_by uuid default auth.uid()
);

create table if not exists visits (
  id uuid primary key default gen_random_uuid(),
  restaurant_id uuid not null references restaurants(id) on delete cascade,
  note text,
  status_after text,
  created_at timestamptz not null default now(),
  created_by uuid default auth.uid()
);

create index if not exists visits_restaurant_idx on visits(restaurant_id, created_at desc);

alter table restaurants enable row level security;
alter table visits enable row level security;

-- The whole team (any logged-in user) shares the same list.
create policy "team read restaurants"   on restaurants for select to authenticated using (true);
create policy "team insert restaurants" on restaurants for insert to authenticated with check (true);
create policy "team update restaurants" on restaurants for update to authenticated using (true) with check (true);
create policy "team delete restaurants" on restaurants for delete to authenticated using (true);

create policy "team read visits"   on visits for select to authenticated using (true);
create policy "team insert visits" on visits for insert to authenticated with check (true);
create policy "team delete visits" on visits for delete to authenticated using (true);
