# Deployment (Free)

## Vercel
1. vercel.com > sign in with GitHub > Add New Project > pick `pocketpilot`.
2. Add all env vars from `.env.local` (Production).
3. Set `NEXT_PUBLIC_APP_URL` to the Vercel URL.
4. Deploy.
5. Add the Vercel URL to Supabase Redirect URLs and Google OAuth if needed.

## GitHub Action cron
Repo > Settings > Secrets and variables > Actions:
- `APP_URL` = your Vercel URL
- `CRON_SECRET` = same as in Vercel env
Test: Actions tab > "Daily jobs" > Run workflow.

## Install on phone
Open the Vercel URL in Android Chrome > menu > **Install app**. Allow notifications. Now PocketPilot appears in the Share list.

## Keep Supabase awake
Free projects can pause after inactivity. The daily GitHub Action call also touches the database, which helps.
