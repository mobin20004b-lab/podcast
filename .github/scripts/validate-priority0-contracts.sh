#!/usr/bin/env bash
set -euo pipefail

contracts_file=".github/scripts/priority0-contracts.txt"

test -f "$contracts_file"

while IFS= read -r contract; do
  [ -z "$contract" ] && continue
  test -f "$contract"
  grep -q '^openapi:' "$contract"
  grep -q '^info:' "$contract"
  grep -q '^paths:' "$contract"
done < "$contracts_file"
