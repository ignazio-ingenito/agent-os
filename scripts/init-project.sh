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

if [ ! -e "$dest" ]; then
  error "destinazione inesistente: $dest"
  exit 2
fi

if [ ! -d "$dest" ]; then
  error "la destinazione non è una directory: $dest"
  exit 2
fi

if ! git -C "$dest" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  error "la destinazione non è un repository Git: $dest"
  exit 2
fi

dest_root=$(CDPATH= cd -- "$dest" && pwd -P)
git_root=$(git -C "$dest" rev-parse --show-toplevel)
git_root=$(CDPATH= cd -- "$git_root" && pwd -P)

if [ "$dest_root" != "$git_root" ]; then
  error "la destinazione non è la root del repository Git: $dest"
  error "root corretta: $git_root"
  exit 2
fi

create_list=$(mktemp)
unchanged_list=$(mktemp)
conflict_list=$(mktemp)
all_list=$(mktemp)
trap 'rm -f "$create_list" "$unchanged_list" "$conflict_list" "$all_list"' EXIT HUP INT TERM

find "$template_dir" -type f | sort > "$all_list"

while IFS= read -r src; do
  rel=${src#"$template_dir"/}
  target=$dest/$rel
  if [ ! -e "$target" ]; then
    printf '%s\n' "$rel" >> "$create_list"
  elif [ -f "$target" ] && cmp -s "$src" "$target"; then
    printf '%s\n' "$rel" >> "$unchanged_list"
  else
    printf '%s\n' "$rel" >> "$conflict_list"
  fi
done < "$all_list"

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

if [ -s "$conflict_list" ]; then
  error 'conflitti trovati: nessun file copiato'
  exit 1
fi

if [ "$dry_run" -eq 1 ]; then
  printf '%s\n' 'Dry-run completato: nessuna modifica applicata.'
  exit 0
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
