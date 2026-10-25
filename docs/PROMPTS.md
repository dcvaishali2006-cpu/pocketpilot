# Prompts for your AI coder (Copilot Chat / Claude Code)

How to use: do the prompts in order. After each one, run `npm run lint && npm run test && npm run build`, test in browser, then commit.

Start every new chat with:
> Read AGENTS.md, docs/PRD.md and docs/ARCHITECTURE.md first. Follow the rules in AGENTS.md.

## Prompt 1 - Supabase clients and auth
> Do roadmap tasks 1.1 and 1.2. Create lib/supabase/client.ts, server.ts, admin.ts using @supabase/ssr. Build /login with a Google sign in button, the auth callback route, and middleware that protects the (app) routes. Keep UI simple with Tailwind.

## Prompt 2 - Budget logic
> Do task 1.3. Create lib/budget.ts with pure functions using integer paise: fixedTotal, freeBudget, freeLeft, daysLeft, dailySafeLimit, todayLeft, budgetStatus (safe / careful / over). Add Vitest tests including the PRD example (5000 pocket money, 447 fixed, day 3, 80 spent).

## Prompt 3 - Settings and fixed expenses
> Do tasks 1.4 and 1.5. Settings page to set this month's pocket money. Fixed expenses page with add, edit, delete, and next due date. Use server actions with zod validation. See docs/API.md.

## Prompt 4 - Add and list expenses
> Do tasks 1.6 and 1.7. /add page: amount keypad, category chips, note, save. /expenses list grouped by date with edit and delete.

## Prompt 5 - Dashboard
> Do tasks 1.8 and 1.9. Dashboard as in docs/UI-UX.md: big "Safe today" number, progress bar with green/orange/red, four cards, category chart with Recharts, last 5 expenses.

## Prompt 6 - Push notifications
> Do tasks 1.10 and 1.11. Add public/sw.js with push and notificationclick handlers. Add a subscribe button in settings that saves the subscription. Add lib/push.ts using web-push. After addExpense, send the message from docs/PRD.md section 7.

## Prompt 7 - PWA and share target
> Do tasks 2.1 and 2.2. Add manifest.webmanifest with share_target (POST, multipart/form-data, accept image/*) and icons. In sw.js handle the /share-target POST: save the image in Cache Storage and redirect to /add?shared=1.

## Prompt 8 - OCR
> Do tasks 2.3, 2.4, 2.5. Follow docs/SCREENSHOT-OCR.md exactly. Create the image pre-processing helper, the parser with fixtures and tests, and the scan flow that pre-fills /add. The image must never leave the browser.

## Prompt 9 - Warnings, cron, reports
> Do tasks 2.6 to 2.11. Budget warnings at 80 and 100 percent, /api/cron/daily protected by CRON_SECRET with notification_log dedupe, daily summary, subscription reminders 2 days before due, monthly report page, savings goals, rollover.

## Prompt 10 - Split logic
> Do task 3.1 and 3.6. Create lib/split.ts: equalSplit (rounding leftover goes to payer), exactSplit, percentSplit, netBalances, simplifyDebts. Tests must include the Goa example from docs/TESTING.md.

## Prompt 11 - Groups UI
> Do tasks 3.2 to 3.5, 3.7. Groups list, create group with guest members, add group expense, balances, settle up. When the current user is in the split, create a personal expense with source group for their own share only.

## Prompt 12 - UPI link and invite
> Do tasks 3.8 and 3.9. Build a upi://pay link button using the friend's UPI id and amount. Add an invite link that lets a logged in user claim a guest member slot.

## Prompt 13 - Polish and deploy
> Do Phase 4. Add empty and loading states, check dark mode, fix Lighthouse PWA issues. Then walk me through the Vercel deployment from docs/DEPLOYMENT.md.

## Debug prompt
> I get this error: <paste error>. Look at the related files, explain the cause in simple words, and make the smallest fix.
