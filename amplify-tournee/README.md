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

## Language / Taal / Langue

The app is available in French and Dutch. Use the FR/NL button in the header; the choice is remembered in the browser. The first time, Dutch browsers get Dutch, everything else French. WhatsApp follow-up messages to restaurants are always sent in French.

## Search

- The search box in the list filters on name, address, district, phone number and status (accents do not matter).
- "Chercher en ligne" / "Online zoeken" searches OpenStreetMap for restaurants in Rabat, Salé and Témara and adds the chosen ones to the list with one click. Results already in the list are marked.
