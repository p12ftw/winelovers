-- Nisses vintips: databas för markeringar och kommentarer.
-- Klistra in allt i Supabase → SQL Editor → Run.
-- Byt ut e-postadresserna längst ner mot Nisses (och din egen om du också vill kunna redigera).

-- Vem får redigera
create table if not exists public.editors (
  email text primary key
);

-- En rad per vin och släpp
create table if not exists public.wine_notes (
  release_date date not null,
  artnr        text not null,
  good_buy     boolean not null default false,
  comment      text,
  updated_at   timestamptz not null default now(),
  primary key (release_date, artnr)
);

-- Nisses inledning per släpp
create table if not exists public.release_notes (
  release_date date primary key,
  intro        text,
  updated_at   timestamptz not null default now()
);

alter table public.editors       enable row level security;
alter table public.wine_notes    enable row level security;
alter table public.release_notes enable row level security;

-- Hjälpfunktion: är den inloggade en redaktör?
create or replace function public.is_editor()
returns boolean
language sql stable security definer set search_path = public
as $$
  select exists (
    select 1 from public.editors
    where lower(email) = lower(coalesce(auth.jwt() ->> 'email', ''))
  );
$$;

-- Alla får läsa noteringarna (sidan är publik)
drop policy if exists "read notes"   on public.wine_notes;
drop policy if exists "read intros"  on public.release_notes;
create policy "read notes"  on public.wine_notes    for select to anon, authenticated using (true);
create policy "read intros" on public.release_notes for select to anon, authenticated using (true);

-- Bara redaktörer får skriva
drop policy if exists "editors write notes"  on public.wine_notes;
drop policy if exists "editors write intros" on public.release_notes;
create policy "editors write notes"  on public.wine_notes    for all to authenticated using (public.is_editor()) with check (public.is_editor());
create policy "editors write intros" on public.release_notes for all to authenticated using (public.is_editor()) with check (public.is_editor());

-- En inloggad person får se om den själv är redaktör
drop policy if exists "see own editor row" on public.editors;
create policy "see own editor row" on public.editors for select to authenticated
  using (lower(email) = lower(coalesce(auth.jwt() ->> 'email', '')));

-- Lägg till redaktörer (gemener)
insert into public.editors (email) values
  ('nisse@exempel.se')
on conflict do nothing;
