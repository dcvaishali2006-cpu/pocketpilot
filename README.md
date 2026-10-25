# PocketPilot

A free expense tracker for students. Know where your pocket money goes.

- Set monthly pocket money
- Add fixed expenses (subscriptions, recharge)
- Track daily spending in 5 seconds
- Share a UPI payment screenshot to the app. Free OCR reads it for you
- Get a notification after every expense: spent, remaining, daily safe limit
- Split trip and friend expenses in groups

**Cost: Rs 0.** Everything runs on free tiers.

## Docs
| File | Purpose |
|---|---|
| [docs/PRD.md](docs/PRD.md) | What we build and why |
| [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) | How the system works |
| [docs/DATABASE.md](docs/DATABASE.md) | Tables and rules |
| [docs/API.md](docs/API.md) | Routes and server actions |
| [docs/SCREENSHOT-OCR.md](docs/SCREENSHOT-OCR.md) | Free screenshot reader |
| [docs/UI-UX.md](docs/UI-UX.md) | Screens and design rules |
| [docs/ROADMAP.md](docs/ROADMAP.md) | Task list, phase by phase |
| [docs/SETUP-CODESPACES.md](docs/SETUP-CODESPACES.md) | Step by step setup |
| [docs/DEPLOYMENT.md](docs/DEPLOYMENT.md) | Go live for free |
| [docs/TESTING.md](docs/TESTING.md) | How to test |
| [docs/PROMPTS.md](docs/PROMPTS.md) | Copy-paste prompts for your AI coder |
| [AGENTS.md](AGENTS.md) | Rules for AI coding agents |

## Stack (all free)
Next.js 14 (App Router) + TypeScript + Tailwind, Supabase (Auth + Postgres), Web Push (VAPID), Tesseract.js (OCR), Vercel Hobby, GitHub Actions (cron), GitHub Codespaces (dev).
