# Buddy Reward System

## GitHub Pages

1. Create a GitHub repository and push this folder to the `main` branch.
2. In **Settings -> Pages**, select **GitHub Actions** as the source.
3. The included `.github/workflows/pages.yml` deploys the site automatically after each push.

## Supabase

1. Create a Supabase project.
2. Open **SQL Editor**, paste and run `supabase-schema.sql`.
3. Copy the Project URL and the publishable/anon key from **Project Settings -> API**.
4. Paste them into `supabase-config.js`.
5. Commit and push `supabase-config.js` (only the publishable/anon key, never `service_role`).

The app keeps a local browser cache and synchronizes the complete application state
to the `app_state` row with id `primary`. The current legacy login is not Supabase Auth;
for production use, replace it with Supabase Auth and tighten the RLS policies.
