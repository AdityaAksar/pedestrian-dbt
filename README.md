# Melbourne Pedestrian dbt Transformations

This repository contains the dbt project responsible for transforming raw pedestrian and weather data into analytics-ready tables used by the forecasting pipeline and Power BI dashboard.

---

## Architecture

```
Raw Sources (BigQuery)
        |
Staging (views) ────────────────> Intermediate (views)
  stg_pedestrian_counts                    |
  stg_sensor_locations          int_pedestrian_enriched
  stg_weather_hourly                       |
  stg_public_holidays                      |
                                      Mart (tables)
                                  mart_pedestrian_hourly
                                  mart_pedestrian_daily
```

---

## Data Sources

All raw data is ingested by the [pedestrian-pipeline](https://github.com/AdityaAksar/pedestrian-pipeline) repository.

| Source | Description |
|---|---|
| Melbourne Open Data API | Hourly pedestrian counts from 100+ sensors across Melbourne |
| Melbourne Sensor Locations API | Sensor metadata including name, location ID, and coordinates |
| Open-Meteo Archive API | Historical hourly weather data for Melbourne (temperature, precipitation, windspeed, humidity) |
| Nager.Date API | Public holiday dates for Victoria, Australia |

---

## Models

### Staging Layer
Lightweight views that clean and standardize raw source data. No business logic applied.

| Model | Type | Description |
|---|---|---|
| `stg_pedestrian_counts` | View | Cleaned hourly pedestrian counts per sensor |
| `stg_sensor_locations` | View | Sensor name, location ID, and coordinates |
| `stg_weather_hourly` | View | Hourly weather conditions for Melbourne |
| `stg_public_holidays` | View | Public holiday dates for Victoria |

### Intermediate Layer
Joins and enriches data across staging models.

| Model | Type | Description |
|---|---|---|
| `int_pedestrian_enriched` | View | Joins pedestrian counts with sensor locations, weather, and public holiday flag |

### Mart Layer
Final analytics-ready tables consumed by downstream tools.

| Model | Type | Rows | Description |
|---|---|---|---|
| `mart_pedestrian_hourly` | Table | ~1.6M | Hourly pedestrian count per sensor, enriched with weather and holiday features |
| `mart_pedestrian_daily` | Table | ~70K | Daily aggregated pedestrian count per sensor |

---

## Repository Structure

```
pedestrian-dbt/
├── models/
│   ├── staging/
│   │   ├── stg_pedestrian_counts.sql
│   │   ├── stg_sensor_locations.sql
│   │   ├── stg_weather_hourly.sql
│   │   └── stg_public_holidays.sql
│   ├── intermediate/
│   │   └── int_pedestrian_enriched.sql
│   └── mart/
│       ├── mart_pedestrian_hourly.sql
│       └── mart_pedestrian_daily.sql
├── dbt_project.yml
└── profiles.yml
```

---

## Setup

### Prerequisites
- Python 3.11+
- dbt-bigquery adapter
- Google Cloud project with BigQuery enabled
- Service account with BigQuery Editor role

### Installation

```bash
pip install dbt-bigquery

dbt deps
```

### Configuration

Configure your BigQuery connection in `profiles.yml`:

```yaml
pedestrian_dbt:
  target: dev
  outputs:
    dev:
      type: bigquery
      method: service-account
      project: melbourne-pedestrian-pipeline
      dataset: staging
      keyfile: /path/to/service-account.json
```

### Running Models

```bash
# Run all models
dbt run

# Run specific layer
dbt run --select staging
dbt run --select intermediate
dbt run --select mart

# Test models
dbt test
```

---

## Tech Stack

| Tool | Description |
|---|---|
| dbt | Data transformation and modeling |
| Google BigQuery | Cloud data warehouse |
| Python | dbt runtime environment |