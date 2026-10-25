# AGENTS.md - Rules for AI coding agents

Read this file first. Then read docs/PRD.md and docs/ARCHITECTURE.md.

## Project
PocketPilot: PWA expense tracker. Next.js 14 App Router, TypeScript, Tailwind, Supabase, Web Push, Tesseract.js.

## Hard rules
1. Everything must stay FREE. Do not add paid services or paid APIs.
2. Money is stored as `numeric(10,2)` in DB. In code use integer paise (amount * 100) for math. Never use float math for money.
3. All DB tables have Row Level Security. Never bypass RLS in client code. Service role key is only used in server code (`lib/supabase/admin.ts`) and cron routes.
4. Never commit secrets. Use `.env.local`. Keep `.env.example` updated.
5. OCR runs in the browser (Tesseract.js). Do not upload screenshots to any server.
6. Keep UI simple. Mobile first. Max width 480px layout is fine.
7. Simple English in all UI text and comments.
8. Pure logic (budget math, split math, OCR parser) lives in `lib/` with unit tests. No logic inside components.

## Folder map
```
app/                 pages and routes
  (auth)/login
  (app)/dashboard, add, expenses, fixed, groups, settings
  api/               route handlers (push, cron, share)
components/          UI components
lib/
  budget.ts          budget math
  split.ts           split + settle-up math
  ocr/               tesseract wrapper + parser
  push.ts            web push sender
  supabase/          client.ts, server.ts, admin.ts
public/
  manifest.webmanifest, sw.js, icons/
supabase/schema.sql  database schema
docs/                documentation
```

## Workflow for every task
1. Pick ONE task from docs/ROADMAP.md.
2. Write or update the pure logic in `lib/` first, with tests.
3. Build the UI.
4. Run `npm run lint && npm run test && npm run build`.
5. Tick the task in ROADMAP.md.
6. Commit with message: `feat: <task>` / `fix: <bug>` / `docs: <change>`.

## Do not
- Do not rewrite working files without being asked.
- Do not install big libraries for small things.
- Do not store screenshots anywhere.
- Do not read UPI app data. It is not possible from a web app.
