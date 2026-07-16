#!/bin/sh
set -eu

usage() {
  printf '%s\n' 'Uso: ./scripts/init-project.sh [--dry-run] /percorso/progetto'
}

error() {
  printf 'ERROR %s\n' "$1" >&2
}

dry_run=0
case "${1:-}" in
  --dry-run)
    dry_run=1
    shift
    ;;
  -h|--help)
    usage
    exit 0
    ;;
esac

if [ "$#" -ne 1 ]; then
  usage >&2
  exit 2
fi

dest=$1
script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
root_dir=$(CDPATH= cd -- "$script_dir/.." && pwd -P)
template_dir="$root_dir/templates/project"

if [ ! -d "$template_dir" ]; then
  error "template non trovato: $template_dir"
  exit 2
fi

if [ -e "$dest" ] && [ ! -d "$dest" ]; then
  error "la destinazione non è una directory: $dest"
  exit 2
fi

create_list=$(mktemp)
unchanged_list=$(mktemp)
conflict_list=$(mktemp)
all_list=$(mktemp)
template_paths=$(mktemp)
existing_list=$(mktemp)
existing_files=$(mktemp)
trap 'rm -f "$create_list" "$unchanged_list" "$conflict_list" "$all_list" "$template_paths" "$existing_list" "$existing_files"' EXIT HUP INT TERM

find "$template_dir" -type f | sort > "$all_list"
find "$template_dir" -mindepth 1 \( -type f -o -type d \) | while IFS= read -r path; do
  printf '%s\n' "${path#"$template_dir"/}"
done | sort > "$template_paths"

dest_exists=0
create_dir=0
git_init=0
repo_root=0
existing_entries=0
invalid_populated=0

if [ ! -e "$dest" ]; then
  create_dir=1
  git_init=1
else
  dest_exists=1
  if git -C "$dest" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    dest_root=$(CDPATH= cd -- "$dest" && pwd -P)
    git_root=$(git -C "$dest" rev-parse --show-toplevel)
    git_root=$(CDPATH= cd -- "$git_root" && pwd -P)
    if [ "$dest_root" = "$git_root" ]; then
      repo_root=1
    fi
  fi

  (cd "$dest" && find . -mindepth 1 -not -path './.git' -not -path './.git/*' | sort) > "$existing_list"
  (cd "$dest" && find . -type f -not -path './.git/*' | sort) > "$existing_files"
  if [ -s "$existing_list" ]; then
    existing_entries=1
  fi
  if [ "$repo_root" -eq 0 ] && [ "$existing_entries" -eq 1 ]; then
    invalid_populated=1
  fi
  if [ "$repo_root" -eq 0 ] && [ "$existing_entries" -eq 0 ]; then
    git_init=1
  fi
fi

while IFS= read -r src; do
  rel=${src#"$template_dir"/}
  target=$dest/$rel
  if [ "$dest_exists" -eq 0 ] || [ ! -e "$target" ]; then
    printf '%s\n' "$rel" >> "$create_list"
  elif [ -f "$target" ] && cmp -s "$src" "$target"; then
    printf '%s\n' "$rel" >> "$unchanged_list"
  else
    printf '%s\n' "$rel" >> "$conflict_list"
  fi
done < "$all_list"

if [ "$dest_exists" -eq 1 ]; then
  while IFS= read -r existing; do
    rel=${existing#./}
    if ! grep -F -x -- "$rel" "$template_paths" >/dev/null; then
      printf '%s\n' "$rel" >> "$conflict_list"
    fi
  done < "$existing_list"
fi

if [ "$repo_root" -eq 1 ] && [ "$existing_entries" -eq 1 ]; then
  if ! (cd "$template_dir" && find . -type f | sort) | cmp -s - "$existing_files"; then
    invalid_populated=1
  fi
fi

if [ "$create_dir" -eq 1 ]; then
  printf 'CREATE_DIR %s\n' "$dest"
fi

if [ "$git_init" -eq 1 ]; then
  printf 'GIT_INIT %s\n' "$dest"
fi

while IFS= read -r rel; do
  [ -n "$rel" ] || continue
  printf 'UNCHANGED %s\n' "$rel"
done < "$unchanged_list"

while IFS= read -r rel; do
  [ -n "$rel" ] || continue
  printf 'CREATE %s\n' "$rel"
done < "$create_list"

while IFS= read -r rel; do
  [ -n "$rel" ] || continue
  printf 'CONFLICT %s\n' "$rel"
done < "$conflict_list"

if [ "$invalid_populated" -eq 1 ]; then
  error "destinazione non vuota: $dest"
  exit 1
fi

if [ -s "$conflict_list" ]; then
  error 'conflitti trovati: nessun file copiato'
  exit 1
fi

if [ "$dry_run" -eq 1 ]; then
  printf '%s\n' 'Dry-run completato: nessuna modifica applicata.'
  exit 0
fi

if [ "$create_dir" -eq 1 ]; then
  mkdir -p "$dest"
fi

if [ "$git_init" -eq 1 ]; then
  git -C "$dest" init -q
fi

while IFS= read -r rel; do
  [ -n "$rel" ] || continue
  src=$template_dir/$rel
  target=$dest/$rel
  target_dir=$(dirname -- "$target")
  mkdir -p "$target_dir"
  cp "$src" "$target"
done < "$create_list"

printf '%s\n' 'Inizializzazione completata.'
