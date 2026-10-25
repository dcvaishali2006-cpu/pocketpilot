# PRD - PocketPilot

## 1. Problem
A student gets monthly pocket money. Subscriptions and daily spending come out of it. By mid month the student does not know where the money went.

## 2. Goal
Show clearly: how much is spent, how much is left, what is fixed, and how much is safe to spend today. Make adding an expense take under 5 seconds.

## 3. Users
College students (16-25) in India who use UPI apps (GPay, PhonePe, Paytm) on Android.

## 4. Honest limits
- A web app cannot read UPI app data or SMS.
- So expenses enter in 3 ways: Share screenshot to app (OCR), Quick Add, Manual add.
- "Share to app" works on Android Chrome with the installed PWA. iOS does not support it. iOS users use Quick Add.

## 5. Features

### Phase 1 - Core (MVP)
| ID | Feature | Done when |
|---|---|---|
| F1 | Google login | User can sign in and out |
| F2 | Monthly pocket money | User sets amount for current month |
| F3 | Fixed expenses | Add, edit, delete. Name, amount, due day |
| F4 | Add expense | Amount, category, note, date saved |
| F5 | Quick Add | 3 taps: amount, category, save |
| F6 | Dashboard | Shows budget, fixed, spent, free to spend, daily safe limit |
| F7 | Expense list | Filter by date and category. Edit and delete |
| F8 | Push notification | After each expense. Shows spent, left, daily limit |
| F9 | Category chart | Pie or bar for the month |

### Phase 2 - Smart
| ID | Feature | Done when |
|---|---|---|
| F10 | PWA install | Installable on Android home screen |
| F11 | Share target | Shared screenshot opens the app with the image |
| F12 | Free OCR | Amount, receiver, date filled from screenshot |
| F13 | Budget warning | Push at 80% and 100% of free money |
| F14 | Daily summary | Push every night: today's spend |
| F15 | Subscription reminder | Push 2 days before due day |
| F16 | Monthly report | Page with totals and top category |
| F17 | Savings goal | Goal name, target, progress |
| F18 | Rollover | Leftover money shown at next month start |

### Phase 3 - Friends and Trips
| ID | Feature | Done when |
|---|---|---|
| F19 | Create group | Name, members |
| F20 | Add members | By name (guest) or invite link |
| F21 | Add group expense | Who paid, who shares, amount |
| F22 | Split types | Equal, exact amounts, percentage |
| F23 | Balances | Who owes whom |
| F24 | Simplify debts | Fewest payments to settle |
| F25 | Settle up | Mark a payment as done |
| F26 | Auto personal entry | User's own share goes to personal expenses. Friends' share does not |
| F27 | UPI pay link | `upi://pay` link to pay a friend |

## 6. Core formulas
```
fixed_total      = sum(active fixed expenses)
free_budget      = pocket_money - fixed_total
spent            = sum(personal expenses this month)
free_left        = free_budget - spent
days_left        = days in month - today + 1
daily_safe_limit = max(free_left, 0) / days_left
today_left       = daily_safe_limit - spent_today
```
Note: fixed expenses are NOT counted again in `spent`. If the user pays a subscription, it is not added as a normal expense.

## 7. Notification texts
- After expense: "Rs 80 Food. Spent Rs 2,400. Left Rs 2,153. Safe today: Rs 151."
- Warning: "80% of your free money is used. 12 days left."
- Daily: "Today you spent Rs 320. Safe limit was Rs 151."
- Subscription: "Spotify Rs 59 due in 2 days."

## 8. Non-goals (v1)
Bank sync, SMS reading, iOS share target, multi currency, paid plans.

## 9. Success checks
- Add expense in under 5 seconds.
- Notification arrives within 5 seconds of saving.
- OCR fills the correct amount for 8 of 10 GPay/PhonePe screenshots.
- Monthly cost is Rs 0.

## 10. Real example
Pocket money Rs 5,000. Fixed: Spotify 59 + Recharge 299 + YouTube 89 = 447.
Free budget = 4,553. Day 1 daily limit = 4,553 / 30 = about 151.
Day 3: Rs 80 canteen. Spent 80. Left 4,473. Day 3 limit = 4,473 / 28 = about 159.
