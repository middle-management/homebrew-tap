#!/usr/bin/env bash
# update-shas.sh — compute SHA256 for every release asset referenced by the
# formulas in ./Formula and casks in ./Casks, replacing matching
# REPLACE_ME_<filename> placeholders in-place.
#
# Usage:
#   ./update-shas.sh                  # updates all formulas and casks
#   ./update-shas.sh Formula/ace.rb   # updates one
#   ./update-shas.sh Casks/foo.rb     # updates one
#
# Idempotent: already-filled sha256 values are left alone. Skips files whose
# URLs 404 (useful for otlppgplan until binaries are published).

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AWK_SCRIPT="${SCRIPT_DIR}/update-shas.awk"

if ! command -v curl >/dev/null
then
  echo "curl is required" >&2
  exit 1
fi

if command -v shasum >/dev/null
then
  SHA_CMD=(shasum -a 256)
elif command -v sha256sum >/dev/null
then
  SHA_CMD=(sha256sum)
else
  echo "need shasum or sha256sum" >&2
  exit 1
fi

update_one() {
  local formula="$1"
  echo "==> ${formula}"

  # Extract all URL lines and follow them to compute SHA256.
  # Homebrew interpolates #{version} at install time; we do the same here.
  local version
  version="$(grep -E '^[[:space:]]*version "' "${formula}" | head -1 | sed -E 's/.*"([^"]+)".*/\1/')"
  if [[ -z "${version}" ]]
  then
    echo "   no version found, skipping" >&2
    return
  fi

  # update-shas.awk emits <url>\t<placeholder> for each REPLACE_ME_ sha256.
  awk -v ver="${version}" -f "${AWK_SCRIPT}" "${formula}" "${formula}" | while IFS=$'\t' read -r url placeholder; do
    [[ -z "${url}" || -z "${placeholder}" ]] && continue
    echo "   ${url}"
    tmp="$(mktemp)"
    if ! curl -sSL --fail --retry 2 -o "${tmp}" "${url}"
    then
      echo "     ! download failed (asset may not be published yet); leaving placeholder"
      rm -f "${tmp}"
      continue
    fi
    hash="$("${SHA_CMD[@]}" "${tmp}" | awk '{print $1}')"
    rm -f "${tmp}"
    echo "     ${hash}"
    # In-place replace: only the exact placeholder string.
    # BSD sed (macOS) and GNU sed both accept `-i ''` vs `-i`; handle both.
    if sed --version >/dev/null 2>&1
    then
      sed -i "s|${placeholder}|${hash}|" "${formula}"
    else
      sed -i '' "s|${placeholder}|${hash}|" "${formula}"
    fi
  done
}

if [[ $# -gt 0 ]]
then
  for f in "$@"; do update_one "${f}"; done
else
  shopt -s nullglob
  for f in Formula/*.rb Casks/*.rb; do update_one "${f}"; done
fi

remaining="$(grep -l REPLACE_ME_ Formula/*.rb Casks/*.rb 2>/dev/null || true)"
if [[ -n "${remaining}" ]]
then
  echo
  echo "Still have REPLACE_ME_ placeholders in:"
  echo "${remaining}"
  exit 2
fi
echo "All sha256 values filled in."
