# SE TechGuide

Password-protected internal tool that gives Commure SEs a single-pane view of EHR integration details, competitive intel, and demo coaching — all driven by CSV data from the [se-field-intel](https://github.com/christopherlogue-boop/se-field-intel) repo.

## What it does

- **EHR lookup:** Select an EHR (Epic, MEDITECH, eCW, etc.) and instantly see RCM/Ambient integration status, field mappings, timelines, blockers, and pivot paths.
- **Competitive intel:** Side-by-side comparison against Abridge, Microsoft Dragon Copilot, and Ambience.
- **Demo coaching:** Audience-specific (CIO vs. CMIO vs. Rev Cycle) demo paths and talk tracks.
- **EHR detail page:** Deep-dive view at `ehr-integration.html?vendor=<slug>` with full field mapping, demo patient anchors, and SE guidance.

## How to update

Content is pulled live from `ehr-master.csv` and `competitive-intel.csv` in the [se-field-intel](https://github.com/christopherlogue-boop/se-field-intel) repo. Edit those CSVs to change what shows up here — no changes to this repo needed for content updates.

To change the UI or add features, edit `index.html` or `ehr-integration.html`, rebuild the Docker image, and redeploy.

## Deployment

Hosted on **Google Cloud Run** in project `ent-se-cloudrun` (us-west1).

```bash
# Build
gcloud builds submit --tag us-west1-docker.pkg.dev/ent-se-cloudrun/se-tools/se-techguide:latest --project=ent-se-cloudrun --region=us-west1

# Deploy
gcloud run deploy se-techguide --image=us-west1-docker.pkg.dev/ent-se-cloudrun/se-tools/se-techguide:latest --region=us-west1 --project=ent-se-cloudrun --allow-unauthenticated --port=8080 --set-env-vars=PASSWORD=<password>
```

Live at: `se-techguide-976166755029.us-west1.run.app`

## Key files

| File | What it is |
|---|---|
| `index.html` | Main app — tabs for EHR lookup, competitive intel, demo coaching |
| `ehr-integration.html` | Detail page for a single EHR (loaded via `?vendor=` param) |
| `Dockerfile` | nginx:alpine container, serves static HTML on port 8080 |
| `entrypoint.sh` | Injects password hash at container startup |
