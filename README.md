# Buddy Reward System

This is a static single-page app. The free hosting setup is:

- **GitHub Pages** for the website
- **Supabase Free Plan** for the shared online data

The app stores its state as one JSON document in the `app_state` table. It
also keeps a browser cache in `localStorage` so the app can open quickly.

## 1. Create the free database

1. Create a project at [supabase.com](https://supabase.com).
2. Open **SQL Editor** in the Supabase dashboard.
3. Open `supabase-schema.sql` from this repository, paste it into a query,
   and click **Run**.
4. Open **Project Settings -> API**.
5. Copy the **Project URL** and the **Publishable key** (also called the
   legacy `anon` key).
6. Put those values into `supabase-config.js`:

   ```js
   window.BRS_SUPABASE_CONFIG = {
     url: 'https://YOUR_PROJECT_REF.supabase.co',
     anonKey: 'YOUR_PUBLISHABLE_OR_ANON_KEY'
   };
   ```

   Never use or publish the `service_role` key.

## 2. Publish the website for free

1. Create a GitHub repository and push this project to its `main` branch.
2. In the repository, open **Settings -> Pages**.
3. Under **Build and deployment**, select **GitHub Actions**.
4. Open the **Actions** tab and wait for **Deploy Buddy Reward System** to
   finish successfully.
5. Open the Pages URL shown in **Settings -> Pages**.

The workflow in `.github/workflows/pages.yml` deploys the repository root
after every push to `main`. Keep `index.html`, `supabase-config.js`, and the
workflow at the repository root.

## 3. Verify shared data

1. Open the deployed URL in browser A and make a small change.
2. In Supabase, open **Table Editor -> app_state** and confirm that the
   `primary` row has a recent `updated_at` value.
3. Open the deployed URL in browser B (or a private window). The same data
   should load.

If an old browser cache appears, clear the site's storage in DevTools
(**Application -> Storage -> Clear site data**) and reload.

## Troubleshooting

- A missing `app_state` table means `supabase-schema.sql` was not run.
- A 404 for `supabase-config.js` means the file is not at the repository root
  or was not pushed to GitHub.
- In the browser DevTools console, look for `[BRS] Supabase save failed` or
  `[BRS] Supabase load failed`.
- Confirm the URL and key are from the same Supabase project.
- Changes made before the database is configured remain only in that browser's
  `localStorage`; configure Supabase before using the app with multiple users.

## Security note

The current login is client-side and is not an authentication system. The
public RLS policies are appropriate only for a demo or trusted internal
prototype: anyone who can access the site can potentially read or overwrite
the shared JSON state. For production, replace the legacy login with
Supabase Auth and use per-user RLS policies.
