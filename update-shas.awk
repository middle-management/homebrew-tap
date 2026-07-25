# update-shas.awk — emit "<url>\t<placeholder>" for each REPLACE_ME_ sha256.
# Pairs the i-th url with the i-th *sha256* in document order, so the logic
# works for both formula style (url before sha256) and cask style (sha256
# before url). Pass the input file twice so FNR == NR detects the first pass.
# Expected vars: ver (target version).
#
# Counting every sha256 — not just the REPLACE_ME_ ones — is what makes a
# partially-filled file work: a recipe where one platform's hash is already
# known and another's is still a placeholder (e.g. a cask whose macOS asset
# shipped before its Linux one) would otherwise pair the lone placeholder with
# the FIRST url and write the wrong file's hash into it.

NR == FNR {
  if ($0 ~ /url "/) {
    u = $0
    sub(/.*url "/, "", u); sub(/".*/, "", u)
    gsub(/#\{version\}/, ver, u)
    urls[++url_count] = u
  }
  next
}
/sha256 "/ {
  sha_idx++
  if ($0 !~ /REPLACE_ME_/) next
  p = $0
  sub(/.*sha256 "/, "", p); sub(/".*/, "", p)
  print urls[sha_idx] "\t" p
}
