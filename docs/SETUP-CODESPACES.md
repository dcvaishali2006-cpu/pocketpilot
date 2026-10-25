# Setup: GitHub + Codespaces (Step by Step)

## Step 1. Create the repo
1. Go to github.com > New repository.
2. Name: `pocketpilot`. Choose Private (or Public). Tick "Add a README"? **No.**
3. Click Create.

## Step 2. Open a Codespace
1. On the repo page click green **Code** > **Codespaces** > **Create codespace on main**.
2. Wait 1-2 minutes. VS Code opens in the browser.

## Step 3. Put these doc files in the repo
1. Download the `pocketpilot.zip` from Claude.
2. In Codespace, drag the zip into the left Explorer panel.
3. Open Terminal (Ctrl + `) and run:
```bash
unzip pocketpilot.zip
cp -r pocketpilot/. .
rm -rf pocketpilot pocketpilot.zip
ls -a
```
You should see `AGENTS.md`, `docs/`, `supabase/`, `.devcontainer/`.

## Step 4. First commit
```bash
git add .
git commit -m "docs: add project docs and schema"
git push origin main
```

## Step 5. Create the Next.js app in the same folder
```bash
npx create-next-app@14 . --typescript --tailwind --eslint --app --no-src-dir --import-alias "@/*"
```
If it says folder is not empty, choose "Yes" to continue. Your docs stay.

Install libraries:
```bash
npm i @supabase/supabase-js @supabase/ssr zod recharts web-push tesseract.js
npm i -D vitest @types/web-push
```
Add to `package.json` scripts: `"test": "vitest run"`.

## Step 6. Supabase (free)
1. Go to supabase.com > New project (free plan). Save the DB password.
2. SQL Editor > New query > paste `supabase/schema.sql` > Run.
3. Project Settings > API: copy Project URL, anon key, service_role key.
4. Authentication > Providers > Google: enable.
   - Create OAuth client in Google Cloud Console (free). Type: Web.
   - Redirect URI: the one Supabase shows (`https://<ref>.supabase.co/auth/v1/callback`).
   - Paste Client ID and Secret into Supabase.
5. Authentication > URL Configuration: add Site URL and Redirect URLs
   - `http://localhost:3000/**`
   - your Codespaces URL (`https://<name>-3000.app.github.dev/**`)
   - your Vercel URL later.

## Step 7. Environment variables
```bash
cp .env.example .env.local
npx web-push generate-vapid-keys
```
Fill `.env.local`. Never commit it. (`.gitignore` already blocks it.)
Optional: add secrets in GitHub repo > Settings > Secrets and variables > **Codespaces**.

## Step 8. Run
```bash
npm run dev
```
Codespaces shows a popup for port 3000. Click **Open in Browser**.
To test on your phone: Ports tab > right click port 3000 > Port Visibility > **Public**. Open the URL on the phone. Set it back to Private after testing.

## Step 9. Build with AI, step by step
Open `docs/PROMPTS.md`. Copy Prompt 1 into Copilot Chat (or Claude Code). Finish each roadmap task, then commit.

## Step 10. Daily Git habit
```bash
git add .
git commit -m "feat: add fixed expenses page"
git push
```
Use branches for big work: `git checkout -b feat/groups`. Merge with a Pull Request.

## Save your free Codespace hours
- Free accounts get a monthly allowance of core hours and storage. Check GitHub > Settings > Billing.
- When done: Command Palette > "Codespaces: Stop Current Codespace". Idle ones also auto stop.
- Students: apply for GitHub Student Developer Pack for a bigger allowance.

## Troubleshooting
| Problem | Fix |
|---|---|
| Google login redirects wrong | Add the exact URL in Supabase Redirect URLs |
| Port not opening | Ports tab > check 3000 is listed > open again |
| Push not working | Needs HTTPS. Use Codespaces URL or Vercel, not http IP |
| Supabase project paused | Open Supabase dashboard > Restore |
| OCR slow first time | It downloads language data once |
