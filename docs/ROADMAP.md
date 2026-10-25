# Roadmap (tick as you finish)

Rule: one task at a time. Run lint, test, build before ticking.

## Phase 0 - Setup
- [ ] 0.1 Create GitHub repo and open Codespace
- [ ] 0.2 `create-next-app` (TS, Tailwind, App Router)
- [ ] 0.3 Install deps: supabase-js, @supabase/ssr, zod, recharts, web-push, tesseract.js, vitest
- [ ] 0.4 Supabase project + run schema.sql + Google login enabled
- [ ] 0.5 `.env.local` filled

## Phase 1 - Core
- [ ] 1.1 Supabase clients (browser, server, admin)
- [ ] 1.2 Login page + auth callback + route protection
- [ ] 1.3 `lib/budget.ts` + tests
- [ ] 1.4 Settings: monthly pocket money
- [ ] 1.5 Fixed expenses CRUD
- [ ] 1.6 Add expense (quick add)
- [ ] 1.7 Expense list with edit and delete
- [ ] 1.8 Dashboard with numbers and progress bar
- [ ] 1.9 Category chart
- [ ] 1.10 Push subscribe + `sw.js` + test notification
- [ ] 1.11 Notification after every expense

## Phase 2 - Smart
- [ ] 2.1 PWA manifest + icons + install prompt
- [ ] 2.2 Share target in manifest + service worker
- [ ] 2.3 Image pre-processing helper
- [ ] 2.4 `lib/ocr/parse.ts` + fixtures + tests
- [ ] 2.5 Scan screen with prefilled form
- [ ] 2.6 Budget warnings (80 percent, 100 percent)
- [ ] 2.7 `/api/cron/daily` + GitHub Action
- [ ] 2.8 Daily summary and subscription reminder
- [ ] 2.9 Monthly report page
- [ ] 2.10 Savings goals
- [ ] 2.11 Rollover of leftover money

## Phase 3 - Friends
- [ ] 3.1 `lib/split.ts` (equal, exact, percent) + tests
- [ ] 3.2 Create group + members (guest names)
- [ ] 3.3 Add group expense
- [ ] 3.4 Auto personal entry for own share
- [ ] 3.5 Balances view
- [ ] 3.6 Simplify debts + tests
- [ ] 3.7 Settle up
- [ ] 3.8 UPI pay link button
- [ ] 3.9 Invite link to join group

## Phase 4 - Polish
- [ ] 4.1 Empty states and loading states
- [ ] 4.2 Dark mode check
- [ ] 4.3 Lighthouse PWA check
- [ ] 4.4 Deploy to Vercel
- [ ] 4.5 Test on real phone
