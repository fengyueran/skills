#!/usr/bin/env bash
set -euo pipefail

missing=0
for dir in skills/*; do
  [ -d "$dir" ] || continue
  has_legacy=0
  has_core=0
  has_adapter=0

  [ -f "$dir/SKILL.md" ] && has_legacy=1
  [ -f "$dir/core/SKILL.core.md" ] && has_core=1
  if [ -f "$dir/adapters/codex/SKILL.md" ] || [ -f "$dir/adapters/claude/SKILL.md" ]; then
    has_adapter=1
  fi

  if [ "$has_legacy" -eq 0 ] && [ "$has_core" -eq 0 ]; then
    echo "Missing entry file (SKILL.md or core/SKILL.core.md): $dir"
    missing=1
    continue
  fi

  if [ "$has_core" -eq 1 ] && [ "$has_adapter" -eq 0 ]; then
    echo "Core exists but no adapter found: $dir"
    missing=1
  fi
done

if [ "$missing" -eq 0 ]; then
  echo "All skills passed compatibility checks"
fi
