# Database

Full SQL is in `supabase/schema.sql`. Run it in Supabase SQL Editor.

## Tables
| Table | Purpose |
|---|---|
| profiles | One row per user (name, upi_id) |
| categories | Food, Travel, Recharge, Fun, etc. per user |
| monthly_budgets | Pocket money per month |
| fixed_expenses | Subscriptions and fixed bills |
| expenses | Personal expenses |
| savings_goals | Goal name, target, saved |
| groups | Trip or friend groups |
| group_members | Members. `user_id` is null for guests |
| group_expenses | One shared payment |
| group_expense_splits | Each member's share |
| settlements | Payments between members |
| push_subscriptions | Browser push endpoints |
| notification_log | Prevents duplicate notifications |

## Rules
- Money: `numeric(10,2)`.
- `monthly_budgets.month` = first day of month.
- `expenses.source`: `quick`, `share`, `screenshot`, `group`.
- Group expenses create a personal `expenses` row only for the current user's own share.
- RLS: personal tables use `user_id = auth.uid()`. Group tables use `is_group_member(group_id)`.
