-- PocketPilot schema. Run in Supabase SQL Editor.

create table public.profiles (
  id uuid primary key references auth.users on delete cascade,
  name text,
  upi_id text,
  created_at timestamptz default now()
);

create table public.categories (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles on delete cascade,
  name text not null,
  icon text,
  color text,
  unique (user_id, name)
);

create table public.monthly_budgets (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles on delete cascade,
  month date not null,
  pocket_money numeric(10,2) not null check (pocket_money >= 0),
  unique (user_id, month)
);

create table public.fixed_expenses (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles on delete cascade,
  name text not null,
  amount numeric(10,2) not null check (amount >= 0),
  due_day int not null check (due_day between 1 and 31),
  active boolean default true
);

create table public.expenses (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles on delete cascade,
  amount numeric(10,2) not null check (amount > 0),
  category_id uuid references public.categories on delete set null,
  note text,
  receiver text,
  spent_on date not null default current_date,
  source text not null default 'quick' check (source in ('quick','share','screenshot','group')),
  group_expense_id uuid,
  created_at timestamptz default now()
);
create index on public.expenses (user_id, spent_on);

create table public.savings_goals (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles on delete cascade,
  name text not null,
  target numeric(10,2) not null,
  saved numeric(10,2) not null default 0
);

create table public.groups (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  created_by uuid not null references public.profiles,
  created_at timestamptz default now()
);

create table public.group_members (
  id uuid primary key default gen_random_uuid(),
  group_id uuid not null references public.groups on delete cascade,
  user_id uuid references public.profiles,
  display_name text not null
);

create table public.group_expenses (
  id uuid primary key default gen_random_uuid(),
  group_id uuid not null references public.groups on delete cascade,
  paid_by uuid not null references public.group_members,
  title text not null,
  amount numeric(10,2) not null check (amount > 0),
  split_type text not null check (split_type in ('equal','exact','percent')),
  spent_on date not null default current_date,
  created_by uuid references public.profiles
);

create table public.group_expense_splits (
  id uuid primary key default gen_random_uuid(),
  group_expense_id uuid not null references public.group_expenses on delete cascade,
  member_id uuid not null references public.group_members,
  share_amount numeric(10,2) not null check (share_amount >= 0)
);

create table public.settlements (
  id uuid primary key default gen_random_uuid(),
  group_id uuid not null references public.groups on delete cascade,
  from_member uuid not null references public.group_members,
  to_member uuid not null references public.group_members,
  amount numeric(10,2) not null check (amount > 0),
  settled_on date not null default current_date
);

create table public.push_subscriptions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles on delete cascade,
  endpoint text unique not null,
  p256dh text not null,
  auth text not null
);

create table public.notification_log (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles on delete cascade,
  type text not null,
  ref text,
  sent_on date not null default current_date,
  unique (user_id, type, ref, sent_on)
);

-- Helper: is current user in this group?
create or replace function public.is_group_member(gid uuid)
returns boolean language sql security definer set search_path = public as $$
  select exists (select 1 from public.group_members where group_id = gid and user_id = auth.uid());
$$;

-- New user: create profile + default categories
create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  insert into public.profiles (id, name) values (new.id, new.raw_user_meta_data->>'full_name');
  insert into public.categories (user_id, name, icon) values
    (new.id,'Food','🍔'),(new.id,'Travel','🚌'),(new.id,'Recharge','📱'),
    (new.id,'Fun','🎮'),(new.id,'Study','📚'),(new.id,'Shopping','🛍️'),(new.id,'Other','📦');
  return new;
end $$;

create trigger on_auth_user_created after insert on auth.users
  for each row execute function public.handle_new_user();

-- RLS
alter table public.profiles enable row level security;
alter table public.categories enable row level security;
alter table public.monthly_budgets enable row level security;
alter table public.fixed_expenses enable row level security;
alter table public.expenses enable row level security;
alter table public.savings_goals enable row level security;
alter table public.groups enable row level security;
alter table public.group_members enable row level security;
alter table public.group_expenses enable row level security;
alter table public.group_expense_splits enable row level security;
alter table public.settlements enable row level security;
alter table public.push_subscriptions enable row level security;
alter table public.notification_log enable row level security;

create policy "own profile" on public.profiles for all using (id = auth.uid()) with check (id = auth.uid());
create policy "own categories" on public.categories for all using (user_id = auth.uid()) with check (user_id = auth.uid());
create policy "own budgets" on public.monthly_budgets for all using (user_id = auth.uid()) with check (user_id = auth.uid());
create policy "own fixed" on public.fixed_expenses for all using (user_id = auth.uid()) with check (user_id = auth.uid());
create policy "own expenses" on public.expenses for all using (user_id = auth.uid()) with check (user_id = auth.uid());
create policy "own goals" on public.savings_goals for all using (user_id = auth.uid()) with check (user_id = auth.uid());
create policy "own push" on public.push_subscriptions for all using (user_id = auth.uid()) with check (user_id = auth.uid());

create policy "groups read" on public.groups for select using (created_by = auth.uid() or public.is_group_member(id));
create policy "groups insert" on public.groups for insert with check (created_by = auth.uid());
create policy "groups update" on public.groups for update using (created_by = auth.uid());

create policy "members read" on public.group_members for select using (public.is_group_member(group_id));
create policy "members insert" on public.group_members for insert with check (
  public.is_group_member(group_id) or exists (select 1 from public.groups g where g.id = group_id and g.created_by = auth.uid()));

create policy "gexp all" on public.group_expenses for all using (public.is_group_member(group_id)) with check (public.is_group_member(group_id));
create policy "gsplit all" on public.group_expense_splits for all
  using (exists (select 1 from public.group_expenses e where e.id = group_expense_id and public.is_group_member(e.group_id)))
  with check (exists (select 1 from public.group_expenses e where e.id = group_expense_id and public.is_group_member(e.group_id)));
create policy "settle all" on public.settlements for all using (public.is_group_member(group_id)) with check (public.is_group_member(group_id));
-- notification_log: no client policy. Only the service role writes it.
