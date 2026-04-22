# middle-management/homebrew-tap

A Homebrew tap for [middle-management](https://github.com/middle-management) CLI tools.

Works on both macOS and Linuxbrew (Intel and Apple Silicon / arm64).

## Install

```sh
brew tap middle-management/tap
brew install middle-management/tap/<tool>
```

## Tools

| Formula | Description |
| --- | --- |
| `pgfmt` | PostgreSQL SQL formatter |
| `pgfmt-lsp` | Language Server Protocol implementation for pgfmt |
| `ace` | Append-only enCrypted Environment variables |
| `otel-logger` | OpenTelemetry log forwarder |
| `migratex` | Simple SQLite migration tool |
| `kubepose` | Convert Compose files to Kubernetes manifests |
| `mmmigrate` | Forward-only SQL migration tool — installs `mmmigrate-postgres`, `mmmigrate-mysql`, `mmmigrate-sqlite` side-by-side |
| `otlppgplan` | OTLP PostgreSQL query plan exporter *(pending prebuilt binaries)* |

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

### Notes on specific tools

- **otlppgplan** — release `v0.0.1` exists but has no prebuilt binaries
  attached. The formula assumes the same asset naming convention used for
  your other Go tools (`otlppgplan-<os>-<arch>`). Once you publish binaries
  at those paths, `./update-shas.sh` will fill the sha256 values.
- **httproxy** — intentionally omitted from this tap until its release
  artifact naming/versioning is aligned with the other tools.
- **pgfmt-lsp** — packaged as a separate formula because it's a separate
  binary shipped alongside `pgfmt` in the same release.

## Publishing

Push this repository to GitHub as `middle-management/homebrew-tap`. The tap
name prefix `homebrew-` is mandatory and is stripped by `brew tap` when
users run `brew tap middle-management/tap`.
# homebrew-tap
