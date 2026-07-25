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

## Casks (desktop apps)

| Cask | Description |
| --- | --- |
| [`tailscreen`](https://tailscreen.dev) | Screen sharing over Tailscale — the macOS menubar app (requires macOS 15+) and the Linux desktop app (x86_64 AppImage) from one cask |

`tailscreen` is one cask covering both platforms: `on_macos` installs the
notarized `.app` from the release zip, `on_linux` links the release AppImage
through the `appimage` stanza. So `brew install --cask middle-management/tap/tailscreen`
is the same command everywhere and resolves to the right artifact.

Two caveats on Linux. The AppImage needs FUSE to self-mount (install your
distro's `fuse`/`libfuse2`, or run with `APPIMAGE_EXTRACT_AND_RUN=1`), and
Homebrew registers no `.desktop` entry, so the app won't appear in the
application launcher — for that, use the AppImage directly with a desktop
integration tool, or the Flatpak once it's published.

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

`bump-versions.sh` finds each recipe's upstream repo from its `homepage` when
that points at github.com. When it doesn't — a recipe whose homepage is a
project domain, like Tailscreen's `tailscreen.dev` — add a
`# upstream: owner/repo` comment to the file and the bumper will use that
instead.

## Publishing

Push this repository to GitHub as `middle-management/homebrew-tap`. The tap
name prefix `homebrew-` is mandatory and is stripped by `brew tap` when
users run `brew tap middle-management/tap`.
