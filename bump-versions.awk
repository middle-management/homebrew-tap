# bump-versions.awk — rewrite each sha256 "<hex>" line to
# sha256 "REPLACE_ME_<basename-of-paired-url>" so update-shas.sh can re-fill
# it. Pairs the i-th sha256 with the i-th url in document order, which works
# for both formula style (url before sha256) and cask style (sha256 before
# url). Pass the input file twice so FNR == NR detects the first pass.
# Expected vars: ver (target version).

NR == FNR {
  if ($0 ~ /url "/) {
    u = $0
    sub(/.*url "/, "", u); sub(/".*/, "", u)
    gsub(/#\{version\}/, ver, u)
    n = split(u, parts, "/")
    basenames[++url_count] = parts[n]
  }
  next
}
{
  if ($0 ~ /sha256 "/) {
    sha_idx++
    sub(/sha256 "[^"]*"/, "sha256 \"REPLACE_ME_" basenames[sha_idx] "\"")
  }
  print
}
