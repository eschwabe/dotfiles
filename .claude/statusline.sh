#!/usr/bin/env bash
# Custom Claude Code status line script
# Output: Model | Dir | Branch +staged ~modified | usage% (used/max)

set -uo pipefail

# Capture stdin first (pipe provides JSON)
INPUT=$(cat)

# Initialize all variables (protect against set -u with partial reads)
model="" dir="" used_pct="" ctx_size="" input_tokens="" output_tokens=""
cache_create="" cache_read="" session_id=""

# Extract all needed fields in one jq call (one per line for bash 3.2 compat)
{
  read -r model
  read -r dir
  read -r used_pct
  read -r ctx_size
  read -r input_tokens
  read -r output_tokens
  read -r cache_create
  read -r cache_read
  read -r session_id
} < <(
  echo "$INPUT" | jq -r '
    (.model.display_name // ""),
    (.workspace.current_dir // ""),
    (.context_window.used_percentage // ""),
    (.context_window.context_window_size // ""),
    (.context_window.current_usage.input_tokens // ""),
    (.context_window.current_usage.output_tokens // ""),
    (.context_window.current_usage.cache_creation_input_tokens // ""),
    (.context_window.current_usage.cache_read_input_tokens // ""),
    (.session_id // "")
  ' 2>/dev/null
)

# ANSI color codes
cyan='\033[36m'
green='\033[32m'
yellow='\033[33m'
red='\033[31m'
dim='\033[2m'
reset='\033[0m'

sep="${dim} | ${reset}"

# --- Model segment ---
model_seg="${cyan}${model}${reset}"

# --- Directory segment ---
dir_seg="$(basename "$dir")"

# --- Git segment (cached, 5s TTL) ---
git_seg=""
if [[ -n "$dir" ]] && git -C "$dir" rev-parse --is-inside-work-tree &>/dev/null; then
  cache_file="/tmp/statusline-git-cache-${session_id:-$$}"
  now=$(date +%s)
  use_cache=false

  if [[ -f "$cache_file" ]]; then
    cache_age=$(( now - $(stat -f %m "$cache_file" 2>/dev/null || echo 0) ))
    if (( cache_age < 5 )); then
      use_cache=true
    fi
  fi

  if $use_cache; then
    git_seg=$(cat "$cache_file")
  else
    branch=$(git -C "$dir" symbolic-ref --short HEAD 2>/dev/null || git -C "$dir" rev-parse --short HEAD 2>/dev/null || echo "")
    staged=$(git -C "$dir" diff --cached --numstat 2>/dev/null | wc -l | tr -d ' ')
    modified=$(git -C "$dir" diff --numstat 2>/dev/null | wc -l | tr -d ' ')

    if [[ -n "$branch" ]]; then
      git_seg="${branch}"
      if (( staged > 0 )); then
        git_seg="${git_seg} ${green}+${staged}${reset}"
      fi
      if (( modified > 0 )); then
        git_seg="${git_seg} ${yellow}~${modified}${reset}"
      fi
    fi

    # Write raw (with ANSI codes) to cache
    printf '%b' "$git_seg" > "$cache_file"
  fi
fi

# --- Context segment ---
ctx_seg=""
if [[ -n "$used_pct" ]]; then
  # Token count: input + cache_creation + cache_read (matches official formula)
  total_tokens=0
  [[ -n "$input_tokens" ]] && total_tokens=$(( total_tokens + input_tokens ))
  [[ -n "$cache_create" ]] && total_tokens=$(( total_tokens + cache_create ))
  [[ -n "$cache_read" ]] && total_tokens=$(( total_tokens + cache_read ))

  used_k=$(( (total_tokens + 500) / 1000 ))
  max_k=$(( (ctx_size + 500) / 1000 ))

  # Color by usage percentage
  if (( used_pct >= 90 )); then
    pct_color="$red"
  elif (( used_pct >= 70 )); then
    pct_color="$yellow"
  else
    pct_color="$green"
  fi

  ctx_seg="${pct_color}${used_pct}%${reset} (${used_k}k/${max_k}k)"
fi

# --- Assemble output ---
output="${model_seg}${sep}${dir_seg}"

if [[ -n "$git_seg" ]]; then
  output="${output}${sep}${git_seg}"
fi

if [[ -n "$ctx_seg" ]]; then
  output="${output}${sep}${ctx_seg}"
fi

printf '%b' "$output"
