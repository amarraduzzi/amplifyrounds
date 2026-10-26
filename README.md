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

## Update 4: dagadvies (tab "Aujourd'hui / Vandaag")

No SQL needed. Pick available hours (about 2 stops per hour). Advice = due follow-ups first, then best-scoring restaurants that are close together and not visited in the last 7 days, each with a short pitch tip. "In mijn ronde zetten" fills the route and calculates it.

## Update 5: eigen tabbladen en cijfers

No SQL needed. Tabs: Vandaag, Restaurants, Cijfers, Kaart (map + route). On phones each tab is a full screen; the map only shows in the Kaart tab. Cijfers: funnel, visits per week and person, districts, objections, product interest.

## Update 6: import uit Notion

No SQL needed. Upload `index.html` and `README.md`, then import `notion-import.csv` via "Importeren" (119 restaurants uit Amars Notion-lijst; Etoile du chef en Lina gluten free zijn overgeslagen omdat ze niet bestaan).
The CSV import now also reads these optional columns: `website_status` (yes / no / unknown), `next_step`, `next_contact` (YYYY-MM-DD) and `last_visit` (YYYY-MM-DD).
The import has no coordinates: the app looks them up by name and district (about 1 per second, so ~2 minutes). Check the positions afterwards; wrong ones can be fixed with "Op de kaart plaatsen".

## Update 7: bijwerken bij import en tabblad Overzicht

No SQL needed. The CSV import has a checkbox "Restaurants die al in de lijst staan bijwerken" (on by default): for restaurants already in the list (same name) it fills in empty fields only (status if still "te bezoeken", next step, follow-up date, last visit, website, district). Nothing already filled in is overwritten and clients are never changed.
New tab "Overzicht": counts per status (tap to filter the list), follow-ups due, and the best-scoring restaurants not yet visited.
