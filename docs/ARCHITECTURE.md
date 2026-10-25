# Architecture

## 1. Overview
```
Phone (Android Chrome, installed PWA)
  |-- UI: Next.js pages (React, Tailwind)
  |-- Service Worker: push events + share target
  |-- Tesseract.js (OCR in browser, screenshot never leaves phone)
        |
        v
Next.js on Vercel (server actions + route handlers)
  |-- Supabase Auth (Google login)
  |-- Supabase Postgres (RLS)
  |-- web-push library (sends notifications)
        ^
GitHub Actions cron (daily) -> POST /api/cron/daily
```

## 2. Tech choices (all free)
| Need | Tool | Free limit note |
|---|---|---|
| Web app | Next.js 14 + TypeScript | Open source |
| Style | Tailwind CSS | Open source |
| Auth + DB | Supabase Free | Free projects may pause after a week of no use. Open the app weekly or restore from dashboard |
| Push | Web Push (VAPID) + `web-push` | No third party needed |
| OCR | Tesseract.js | Runs on device |
| Hosting | Vercel Hobby | Personal use |
| Cron | GitHub Actions | Free for public repos, free minutes for private |
| Dev | GitHub Codespaces | Monthly free hours. Stop codespace when idle |
| Charts | Recharts | Open source |
| Tests | Vitest | Open source |

Check each service's current free limits before relying on them.

## 3. Key flows

### 3.1 Quick add expense
1. User opens `/add`, types amount, picks category, saves.
2. Server action `addExpense` validates and inserts (RLS ensures own rows).
3. Server computes budget summary using `lib/budget.ts`.
4. Server calls `sendPush(userId, payload)`.
5. Service worker shows notification.

### 3.2 Share screenshot (Android)
1. In GPay, user taps Share on the payment screen and picks PocketPilot.
2. Manifest `share_target` sends a POST with the image to `/share-target`.
3. Service worker catches this request, stores the file in Cache Storage, and redirects to `/add?shared=1`.
4. `/add` reads the file from cache and runs OCR (`lib/ocr`).
5. Parser returns amount, receiver, date. Form is pre-filled.
6. User picks category and confirms. Flow continues like 3.1.
7. The image is deleted from cache after save.

### 3.3 Group expense
1. User adds group expense: payer, amount, split type, members.
2. `lib/split.ts` computes each share in paise. Rounding leftover goes to the payer.
3. Rows saved: `group_expenses` + `group_expense_splits`.
4. If the current user is in the split, an `expenses` row is created with `source='group'` and the user's share only.
5. Balances = sum(paid) - sum(share) + settlements. Settle-up uses greedy matching.

### 3.4 Daily cron
1. GitHub Action calls `/api/cron/daily` with `Authorization: Bearer CRON_SECRET`.
2. Route uses the service role to loop users.
3. Sends daily summary, budget warnings, and subscription reminders (due in 2 days).
4. Dedupe using `notification_log` (user, type, ref, date).

## 4. Security
- RLS on every table. Policies use `auth.uid()`.
- Service role key only on the server. Never in `NEXT_PUBLIC_*`.
- Cron route checks `CRON_SECRET`.
- Validate all input with zod.
- No screenshots stored on server.

## 5. Settle-up algorithm
```
net[member] = paid - share + received - sent
creditors = members with net > 0 (sorted desc)
debtors   = members with net < 0 (sorted asc)
while both lists not empty:
  pay = min(credit, -debt)
  record debtor -> creditor, pay
  reduce both; drop zeros
```

## 6. Limits and trade-offs
- Android only for share target.
- Push on iOS needs iOS 16.4+ and the PWA added to Home Screen.
- OCR accuracy depends on the screenshot. User always confirms before save.
