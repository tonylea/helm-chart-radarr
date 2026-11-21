# Changelog

All notable changes to this project will be documented in this file. See [commit-and-tag-version](https://github.com/absolute-version/commit-and-tag-version) for commit guidelines.

## [3.0.1](https://github.com/tonylea/helm-chart-radarr/compare/v3.0.0...v3.0.1) (2026-11-21)

### Bug Fixes

* let Radarr's first-run screen set the login ([6ae582e](https://github.com/tonylea/helm-chart-radarr/commit/6ae582e2197afab45da876d1bcae50f5ef862ed4))

### Documentation

* say the kind test is a fresh install ([c348375](https://github.com/tonylea/helm-chart-radarr/commit/c348375cbf0133acf05139a4dc47a144e708e58c))

## [3.0.0](https://github.com/tonylea/helm-chart-radarr/compare/v2.0.0...v3.0.0) (2026-11-21)

### ⚠ BREAKING CHANGES

* persistence.data is now a list of named mounts, each at
  /data/<name>, with at least one required.

### Features

* mount each data volume at /data/<name> ([0c51172](https://github.com/tonylea/helm-chart-radarr/commit/0c51172db1859eb3de51f09df0c6226b7ceb0907))

### Documentation

* show the chart's download count ([b25bbdb](https://github.com/tonylea/helm-chart-radarr/commit/b25bbdb8aa32d4559fb396624ce705282c8a23bc))

## [2.0.0](https://github.com/tonylea/helm-chart-radarr/compare/v1.0.0...v2.0.0) (2026-11-21)

### ⚠ BREAKING CHANGES

* postgres.database is now postgres.databases.main,
  and Radarr needs a log database, postgres.databases.log.

### Features

* keep Radarr's log in its own Postgres database ([ee36dad](https://github.com/tonylea/helm-chart-radarr/commit/ee36dad5b6bb28613af68a2484b83b479de4ffc7))

### Bug Fixes

* leave resource requests to whoever deploys the chart ([964ba0b](https://github.com/tonylea/helm-chart-radarr/commit/964ba0b7ff7951baccb8d680e28ed3ade1e88a79))

### Documentation

* keep only the comments that record a decision ([7ed5d6d](https://github.com/tonylea/helm-chart-radarr/commit/7ed5d6d6e8ce1af9a16deef6058ecacbd7b46e65))
* keep the README to the fixed settings and what the chart needs ([2002af1](https://github.com/tonylea/helm-chart-radarr/commit/2002af1d622c9a627d7567f77f6b670d2d5e71d7))

## 1.0.0 (2026-11-21)

### Features

* deploy Radarr on Postgres, with a fixed API key, a required login and claims for /config and /data ([0773a04](https://github.com/tonylea/helm-chart-radarr/commit/0773a04903b65bdd59d6ba8b0122aab8dd32882f))

### Documentation

* describe the chart, its values and how to contribute ([d882c0a](https://github.com/tonylea/helm-chart-radarr/commit/d882c0a1afaf1bbe3358591b86620e9aae1dc654))
