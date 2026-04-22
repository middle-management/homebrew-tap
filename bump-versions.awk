# bump-versions.awk — rewrite each sha256 "<hex>" line to
# sha256 "REPLACE_ME_<basename-of-preceding-url>" so update-shas.sh can
# re-fill it. Expected vars: ver (target version).
{
  line = $0
  if (line ~ /url "/) {
    u = line
    sub(/.*url "/, "", u); sub(/".*/, "", u)
    gsub(/#\{version\}/, ver, u)
    n = split(u, parts, "/")
    last_basename = parts[n]
  }
  if (line ~ /sha256 "/) {
    sub(/sha256 "[^"]*"/, "sha256 \"REPLACE_ME_" last_basename "\"", line)
  }
  print line
}
