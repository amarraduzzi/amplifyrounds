# Amplify Tournée

Route planner for visiting restaurants in Rabat. Static web app (Leaflet + OpenStreetMap + OSRM) with a Supabase database and login.

## Deploy (Cloudflare Pages)
1. Push this folder's contents to a GitHub repo.
2. Cloudflare → Workers & Pages → Create → Pages → Connect to Git → choose the repo.
3. Framework preset: None. Build command: empty. Build output directory: `/`.

## Files
- `index.html` — the whole app (Supabase URL and public key already filled in at the top of the script)
- `schema.sql` — database tables (already run in Supabase)

## Daily use
1. Add restaurants (Google Maps link, address search, tap on the map) or import a CSV.
2. Tick today's stops, open the "Ma tournée" tab.
3. Drag the blue pin to your starting point (or "Ma position"), then "Calculer la meilleure route".
4. Open in Google Maps or Waze, log each visit, send the WhatsApp follow-up.

CSV columns: `name, address, district, phone, lat, lng, status` (status: new, appt, demo, client, lost).

The Supabase key in `index.html` is a publishable key. Never put the secret/service_role key in this repo.

## Taal / Langue

The app has an FR | NL switch in the header (default: Dutch). The choice is remembered per device.

## Online zoeken / Recherche en ligne

"Online zoeken" (top of the list) searches OpenStreetMap by name in Rabat, Salé and Témara, or lists all restaurants in the area (Overpass) and adds them with one tap. Restaurants already in the list are marked and skipped.

## Update 1: huisstijl, mobiele tabs, lead score

Run `schema-update-1.sql` in Supabase (SQL Editor) BEFORE uploading index.html.
New fields per restaurant: type, website yes/no, Google rating and review count, environment. The list is sorted by a provisional lead score (no website, Google reviews, not a difficult area).
CSV import also reads rating / reviews / website / type columns when present.

## Update 2: bezoeken en pijplijn

Run `schema-update-2.sql` in Supabase BEFORE uploading index.html. Visit log with outcome, contact person, interest, objection and who visited; pipeline statuses (to visit, visited, interested, appointment, demo, trial, client, not interested); filters "to follow up" and "not yet visited"; last visit date in the list.

## Update 3: lead score uitleg

No SQL needed. Tap the score number next to a restaurant to see why; "Réglages du score" lets you change the weights (stored per device).
