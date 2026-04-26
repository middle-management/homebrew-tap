# middle-management/homebrew-tap

A Homebrew tap for [middle-management](https://github.com/middle-management) CLI tools.

Works on both macOS and Linuxbrew (Intel and Apple Silicon / arm64).

## Install

```sh
brew tap middle-management/tap
brew install middle-management/tap/<tool>
brew install --cask middle-management/tap/<app>
```

## Tools

| Formula | Description |
| --- | --- |
| [`pgfmt`](https://github.com/middle-management/pgfmt) | PostgreSQL SQL formatter — also installs `pgfmt-lsp` (LSP server) |
| [`ace`](https://github.com/middle-management/ace) | Append-only enCrypted Environment variables |
| [`otel-logger`](https://github.com/middle-management/otel-logger) | OpenTelemetry log forwarder |
| [`migratex`](https://github.com/middle-management/migratex) | Simple SQLite migration tool |
| [`kubepose`](https://github.com/middle-management/kubepose) | Convert Compose files to Kubernetes manifests |
| [`mmmigrate`](https://github.com/middle-management/mmmigrate) | Forward-only SQL migration tool — installs `mmmigrate-postgres`, `mmmigrate-mysql`, `mmmigrate-sqlite` side-by-side |
| [`httproxy`](https://github.com/middle-management/httproxy) | Simple path-based HTTP reverse proxy |

## Casks (macOS apps)

| Cask | Description |
| --- | --- |
| [`tailscreen`](https://github.com/middle-management/tailscreen) | Stream a Mac's display to another Mac over Tailscale (menubar app, requires macOS 15+) |

`mmmigrate` is a single formula that installs three driver-specific binaries.
Invoke the one that matches your database (`mmmigrate-postgres`,
`mmmigrate-mysql`, or `mmmigrate-sqlite`).

## Maintaining the tap

### Adding or bumping a formula

1. Edit the `version` line in the relevant file under `Formula/`.
2. Run the updater to recompute the sha256 for every architecture:

   ```sh
   ./update-shas.sh              # all formulas
   ./update-shas.sh Formula/ace.rb  # one formula
   ```

3. Commit and push — the CI workflow in `.github/workflows/tests.yml` runs
   `brew test-bot --only-tap-syntax` on every push and PR.

## Publishing

Push this repository to GitHub as `middle-management/homebrew-tap`. The tap
name prefix `homebrew-` is mandatory and is stripped by `brew tap` when
users run `brew tap middle-management/tap`.
