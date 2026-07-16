#!/bin/sh
set -eu

usage() {
  printf '%s\n' 'Uso: ./scripts/init-project.sh [--dry-run] [--no-prompt] [--remote URL] /percorso/progetto'
}

error() {
  printf 'ERROR %s\n' "$1" >&2
}

redact_url() {
  url=$1
  case "$url" in
    *://*@*)
      scheme=${url%%://*}
      rest=${url#*://}
      host_path=${rest##*@}
      printf '%s://***@%s\n' "$scheme" "$host_path"
      ;;
    *)
      printf '%s\n' "$url"
      ;;
  esac
}

prompt_remote_url() {
  printf '%s ' 'Vuoi configurare il remote origin? [s/N]'
  IFS= read -r reply || return 1
  case "$reply" in
    s|S|si|SI|sì|SÌ)
      printf '%s ' 'URL del remote origin:'
      IFS= read -r prompted_url || return 1
      if [ -z "$prompted_url" ]; then
        printf '%s\n' 'Remote origin non configurato: URL vuoto.'
        return 1
      fi
      remote_url=$prompted_url
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

dry_run=0
no_prompt=0
remote_url=
remote_requested=0
dest=

while [ "$#" -gt 0 ]; do
  case "$1" in
    --dry-run)
      dry_run=1
      shift
      ;;
    --no-prompt)
      no_prompt=1
      shift
      ;;
    --remote)
      shift
      if [ "$#" -eq 0 ]; then
        error 'opzione --remote senza URL'
        exit 2
      fi
      if [ -z "$1" ]; then
        error 'opzione --remote senza URL'
        exit 2
      fi
      remote_url=$1
      remote_requested=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    --)
      shift
      break
      ;;
    -*)
      error "opzione non riconosciuta: $1"
      usage >&2
      exit 2
      ;;
    *)
      if [ -n "$dest" ]; then
        usage >&2
        exit 2
      fi
      dest=$1
      shift
      ;;
  esac
done

if [ "$#" -gt 0 ]; then
  if [ -n "$dest" ]; then
    usage >&2
    exit 2
  fi
  dest=$1
  shift
fi

if [ "$#" -ne 0 ] || [ -z "$dest" ]; then
  usage >&2
  exit 2
fi

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
origin_exists=0

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
      if git -C "$dest" remote get-url origin >/dev/null 2>&1; then
        origin_exists=1
      fi
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

if [ "$remote_requested" -eq 1 ] && [ "$origin_exists" -eq 1 ]; then
  error 'remote origin già esistente: nessuna modifica applicata'
  exit 1
fi

if [ -s "$conflict_list" ]; then
  error 'conflitti trovati: nessun file copiato'
  exit 1
fi

if [ "$dry_run" -eq 1 ] && [ "$remote_requested" -eq 1 ]; then
  safe_remote_url=$(redact_url "$remote_url")
  printf 'REMOTE_ADD origin %s\n' "$safe_remote_url"
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

remote_added=0
if [ "$remote_requested" -eq 0 ] && [ "$no_prompt" -eq 0 ] && [ "$origin_exists" -eq 0 ] && [ -t 0 ] && [ -t 1 ]; then
  if prompt_remote_url; then
    remote_requested=1
  fi
fi

if [ "$remote_requested" -eq 1 ]; then
  if git -C "$dest" remote get-url origin >/dev/null 2>&1; then
    error 'remote origin già esistente: nessuna modifica applicata'
    exit 1
  fi
  git -C "$dest" remote add origin "$remote_url"
  safe_remote_url=$(redact_url "$remote_url")
  printf 'REMOTE_ADD origin %s\n' "$safe_remote_url"
  remote_added=1
fi

printf '%s\n' 'Inizializzazione completata.'
if [ "$remote_added" -eq 0 ]; then
  printf '%s\n' 'Nessun remote configurato.'
fi
