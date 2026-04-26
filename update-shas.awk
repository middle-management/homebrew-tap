# update-shas.awk — emit "<url>\t<placeholder>" for each REPLACE_ME_ sha256.
# Pairs the i-th url with the i-th REPLACE_ME_ sha256 in document order, so
# the logic works for both formula style (url before sha256) and cask style
# (sha256 before url). Pass the input file twice so FNR == NR detects the
# first pass. Expected vars: ver (target version).

NR == FNR {
  if ($0 ~ /url "/) {
    u = $0
    sub(/.*url "/, "", u); sub(/".*/, "", u)
    gsub(/#\{version\}/, ver, u)
    urls[++url_count] = u
  }
  next
}
/sha256 "REPLACE_ME_/ {
  sha_idx++
  p = $0
  sub(/.*sha256 "/, "", p); sub(/".*/, "", p)
  print urls[sha_idx] "\t" p
}
