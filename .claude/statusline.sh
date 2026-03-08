#!/usr/bin/env bash
# Custom Claude Code status line script
# Format: 🤖 Model | 📂 dir | branch ✓ | ctx%

set -uo pipefail

# Capture stdin first (pipe provides JSON)
INPUT=$(cat)

# Initialize all variables (protect against set -u with partial reads)
model_id="" model_name="" dir="" used_pct="" remaining_pct="" used_tokens="" total_tokens="" session_id=""

# Extract all needed fields in one jq call
{
  read -r model_id
  read -r model_name
  read -r dir
  read -r used_pct
  read -r remaining_pct
  read -r used_tokens
  read -r total_tokens
  read -r session_id
} < <(
  echo "$INPUT" | jq -r '
    (.model.id // ""),
    (.model.display_name // ""),
    (.workspace.current_dir // ""),
    (.context_window.used_percentage // ""),
    (.context_window.remaining_percentage // ""),
    (.context_window.used_tokens // ""),
    (.context_window.total_tokens // ""),
    (.session_id // "")
  ' 2>/dev/null
)

# ANSI color codes
cyan='\033[36m'
blue='\033[34m'
magenta='\033[35m'
green='\033[32m'
yellow='\033[33m'
red='\033[31m'
dim='\033[2m'
reset='\033[0m'

sep="${dim}|${reset}"

# --- Model segment ---
short_model="$model_name"
short_model="${short_model#Claude }"   # strip leading "Claude "
model_seg="🤖 ${cyan}${short_model}${reset}"

# --- Directory segment: basename, truncated to 20 chars ---
dir_name="$(basename "$dir")"
if (( ${#dir_name} > 20 )); then
  dir_name="${dir_name:0:17}..."
fi
dir_seg="📂 ${blue}${dir_name}${reset}"

# --- Git segment (cached, 5s TTL) ---
git_seg=""
if [[ -n "$dir" ]] && git -C "$dir" rev-parse --is-inside-work-tree &>/dev/null 2>&1; then
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
    branch=$(git -C "$dir" symbolic-ref --short HEAD 2>/dev/null \
             || git -C "$dir" rev-parse --short HEAD 2>/dev/null \
             || echo "")
    staged=$(git -C "$dir" diff --cached --numstat 2>/dev/null | wc -l | tr -d ' ')
    modified=$(git -C "$dir" diff --numstat 2>/dev/null | wc -l | tr -d ' ')

    if [[ -n "$branch" ]]; then
      git_seg=" ${magenta}${branch}${reset}"
      if (( staged > 0 )); then
        git_seg="${git_seg} ${green}+${staged}${reset}"
      fi
      if (( modified > 0 )); then
        git_seg="${git_seg} ${yellow}~${modified}${reset}"
      fi
      if (( staged == 0 && modified == 0 )); then
        git_seg="${git_seg} ${green}✓${reset}"
      fi
    fi

    # Write to cache (with ANSI codes)
    printf '%b' "$git_seg" > "$cache_file"
  fi
fi

# --- Context segment: show remaining % with color and ⚡ ---
ctx_seg=""
if [[ -n "$used_pct" && "$used_pct" != "null" ]]; then
  used_int=${used_pct%.*}   # truncate to integer
  used_int=${used_int:-0}

  if (( used_int >= 90 )); then
    pct_color="$red"
  elif (( used_int >= 70 )); then
    pct_color="$yellow"
  else
    pct_color="$green"
  fi

  # Format token counts as compact "Xk/Yk"
  token_info=""
  if [[ -n "$used_tokens" && "$used_tokens" != "null" && -n "$total_tokens" && "$total_tokens" != "null" ]]; then
    used_k=$(( used_tokens / 1000 ))
    total_k=$(( total_tokens / 1000 ))
    token_info=" ${dim}(${used_k}k/${total_k}k)${reset}"
  fi

  ctx_seg="⚡ ${pct_color}${used_int}%${reset}${token_info}"
fi

# --- Assemble output ---
output="${model_seg} ${sep} ${dir_seg}"

if [[ -n "$git_seg" ]]; then
  output="${output} ${sep}${git_seg}"
fi

if [[ -n "$ctx_seg" ]]; then
  output="${output} ${sep} ${ctx_seg}"
fi

printf '%b' "$output"
