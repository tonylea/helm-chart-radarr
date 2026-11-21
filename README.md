# Radarr Helm Chart

![Downloads](https://img.shields.io/github/downloads/tonylea/helm-chart-radarr/total)

Deploys [Radarr](https://radarr.tv/) from LinuxServer's image, [`lscr.io/linuxserver/radarr`](https://github.com/linuxserver/docker-radarr), the one Radarr's docs recommend.

The chart is opinionated: Radarr keeps its data in Postgres, uses a fixed API key, and always asks for a login.
It runs one replica, and stops the old pod before starting the new one, since two copies of Radarr can't share a database.

## Values

| Value | Default |
| --- | --- |
| `image.tag` | the chart's `appVersion` |
| `puid` | `1000` |
| `pgid` | `1000` |
| `timezone` | `UTC` |
| `apiKey.secretKeyRef.name` | none; required |
| `apiKey.secretKeyRef.key` | `api-key` |
| `postgres.host` | none; required |
| `postgres.port` | `5432` |
| `postgres.databases.main` | `radarr-main` |
| `postgres.databases.log` | `radarr-log` |
| `postgres.username.secretKeyRef.name` | none; required |
| `postgres.username.secretKeyRef.key` | `username` |
| `postgres.password.secretKeyRef.name` | none; required |
| `postgres.password.secretKeyRef.key` | `password` |
| `resources` | none |
| `persistence.config.existingClaim` | none; the chart creates a claim |
| `persistence.config.storageClassName` | the cluster's default class |
| `persistence.config.size` | `5Gi` |
| `persistence.data` | none; at least one mount required |
| `persistence.data[].name` | required; mounted at `/data/<name>` |
| `persistence.data[].existingClaim` | none; the chart creates a claim |
| `persistence.data[].storageClassName` | the cluster's default class |
| `persistence.data[].size` | none; required unless `existingClaim` is set |
| `httpRoute.enabled` | `false` |
| `httpRoute.parentRefs` | none; required when enabled |
| `httpRoute.hostnames` | none |

## Fixed settings

The chart sets these as environment variables, which override `config.xml`, so they can't be changed in the web UI:

- The API key, from `apiKey`'s Secret.
- Authentication required, `Enabled`.
  Behind a gateway or ingress every request comes from a private address, so `DisabledForLocalAddresses` would turn the login off for everyone.
- The Postgres connection, from `postgres`.

The authentication method is left to Radarr's first-run screen, which also creates the user.
Setting it here would skip that screen, and Radarr has no setting for the user.

## Requirements

- A Postgres server, with the main and log databases and the user that owns them made beforehand.
- A Secret holding the API key, and one or two holding the Postgres user and password.
- A storage class for the claims the chart creates, the cluster's default unless named.
  A claim the chart creates is `ReadWriteOnce`, so sharing a data mount with a download client needs an existing claim.
  The [Servarr wiki](https://wiki.servarr.com/docker-guide) covers when an import can be a hardlink rather than a copy.
- The Gateway API's `HTTPRoute` CRD, when `httpRoute.enabled` is set.

## Usage

```sh
helm repo add radarr https://tonylea.github.io/helm-chart-radarr
helm install radarr radarr/radarr --values my-values.yaml
```

```yaml
timezone: Europe/London
apiKey:
  secretKeyRef:
    name: radarr-api-key
postgres:
  host: radarr-postgres-rw
  username:
    secretKeyRef:
      name: radarr-postgres-app
  password:
    secretKeyRef:
      name: radarr-postgres-app
persistence:
  data:
    - name: downloads
      existingClaim: downloads
    - name: movies
      existingClaim: movies
```

## Development

Pull requests run:

- `helm lint --strict`, and the rendered chart checked by kubeconform against Kubernetes 1.37.
- helm-unittest's tests in `tests/`.
- An install with chart-testing in a kind cluster, against a throwaway Postgres from `ci/kind`.

Commits follow Conventional Commits.
Releases are versioned and tagged automatically from `main`, and published to the Helm repository on this repo's GitHub Pages.
