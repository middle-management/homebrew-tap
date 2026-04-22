#!/usr/bin/env bash
# bump-versions.sh — check each formula's upstream GitHub repo for a newer
# release and rewrite the formula's version + sha256 placeholders.
#
# After this script runs, update-shas.sh fills in the real hashes.
#
# Usage:
#   ./bump-versions.sh                # scan all formulas
#   ./bump-versions.sh Formula/ace.rb # scan one
#
# Requires: curl, awk, sed. Optional: GITHUB_TOKEN env var to avoid rate limits.

set -euo pipefail

if ! command -v curl >/dev/null
then
  echo "curl is required" >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AWK_SCRIPT="${SCRIPT_DIR}/bump-versions.awk"

api_latest_tag() {
  local repo="$1"
  local auth=()
  if [[ -n "${GITHUB_TOKEN:-}" ]]
  then
    auth=(-H "Authorization: Bearer ${GITHUB_TOKEN}")
  fi
  local body
  body="$(curl -sSL --fail "${auth[@]}" \
    -H "Accept: application/vnd.github+json" \
    "https://api.github.com/repos/${repo}/releases/latest" 2>/dev/null)" || body=""
  printf '%s\n' "${body}" | awk -F'"' '/"tag_name":/ {print $4; exit}'
}

bump_one() {
  local formula="$1"
  echo "==> ${formula}"

  local homepage
  homepage="$(awk -F'"' '/^[[:space:]]*homepage "/ {print $2; exit}' "${formula}")"
  if [[ -z "${homepage}" ]]
  then
    echo "   no homepage, skipping" >&2
    return
  fi
  if [[ "${homepage}" != https://github.com/* ]]
  then
    echo "   homepage not github, skipping" >&2
    return
  fi

  local repo
  repo="${homepage#https://github.com/}"
  repo="${repo%/}"

  local current latest
  current="$(awk -F'"' '/^[[:space:]]*version "/ {print $2; exit}' "${formula}")"
  latest="$(api_latest_tag "${repo}")"
  latest="${latest#v}"

  if [[ -z "${latest}" ]]
  then
    echo "   could not resolve latest tag, skipping" >&2
    return
  fi

  echo "   current=${current} latest=${latest}"
  if [[ "${current}" == "${latest}" ]]
  then
    echo "   up to date"
    return
  fi

  local sed_i=(-i)
  if ! sed --version >/dev/null 2>&1
  then
    sed_i=(-i '')
  fi
  sed "${sed_i[@]}" -E 's|^([[:space:]]*version )"[^"]+"|\1"'"${latest}"'"|' "${formula}"

  local tmp
  tmp="$(mktemp)"
  awk -v ver="${latest}" -f "${AWK_SCRIPT}" "${formula}" >"${tmp}"
  mv "${tmp}" "${formula}"

  echo "   bumped to ${latest}"
}

if [[ $# -gt 0 ]]
then
  for f in "$@"; do bump_one "${f}"; done
else
  shopt -s nullglob
  for f in Formula/*.rb; do bump_one "${f}"; done
fi
