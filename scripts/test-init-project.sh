#!/bin/sh
set -eu

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
root_dir=$(CDPATH= cd -- "$script_dir/.." && pwd -P)
init_script="$root_dir/scripts/init-project.sh"
template_dir="$root_dir/templates/project"
tmp_dir=$(mktemp -d)
trap 'rm -rf "$tmp_dir"' EXIT HUP INT TERM

fail() {
  printf 'ERROR %s\n' "$1" >&2
  exit 1
}

make_repo() {
  dir=$1
  mkdir -p "$dir"
  git -C "$dir" init -q
}

assert_empty_find() {
  dir=$1
  count=$(find "$dir" -mindepth 1 -not -path "$dir/.git" -not -path "$dir/.git/*" | wc -l | tr -d ' ')
  [ "$count" = 0 ] || fail "dry-run ha modificato la destinazione"
}

assert_same_tree() {
  dir=$1
  expected=$tmp_dir/expected.list
  actual=$tmp_dir/actual.list
  (cd "$template_dir" && find . -type f | sort) > "$expected"
  (cd "$dir" && find . -type f -not -path './.git/*' | sort) > "$actual"
  cmp -s "$expected" "$actual" || fail "lista file generata diversa da templates/project"
  while IFS= read -r rel; do
    rel=${rel#./}
    cmp -s "$template_dir/$rel" "$dir/$rel" || fail "contenuto diverso: $rel"
  done < "$expected"
}

repo_dry=$tmp_dir/repo-dry
make_repo "$repo_dry"
"$init_script" --dry-run "$repo_dry" > "$tmp_dir/dry.out"
grep '^CREATE AGENTS.md$' "$tmp_dir/dry.out" >/dev/null || fail 'dry-run non mostra CREATE AGENTS.md'
assert_empty_find "$repo_dry"
printf '%s\n' 'OK dry-run su repository Git vuoto'

repo_init=$tmp_dir/repo-init
make_repo "$repo_init"
"$init_script" "$repo_init" > "$tmp_dir/init.out"
assert_same_tree "$repo_init"
printf '%s\n' 'OK inizializzazione reale'

"$init_script" "$repo_init" > "$tmp_dir/second.out"
grep '^UNCHANGED AGENTS.md$' "$tmp_dir/second.out" >/dev/null || fail 'seconda esecuzione non riporta file identici'
assert_same_tree "$repo_init"
printf '%s\n' 'OK seconda inizializzazione idempotente'

repo_conflict=$tmp_dir/repo-conflict
make_repo "$repo_conflict"
mkdir -p "$repo_conflict/docs"
printf '%s\n' 'contenuto diverso' > "$repo_conflict/docs/README.md"
if "$init_script" "$repo_conflict" > "$tmp_dir/conflict.out" 2> "$tmp_dir/conflict.err"; then
  fail 'conflitto non ha prodotto errore'
fi
grep '^CONFLICT docs/README.md$' "$tmp_dir/conflict.out" >/dev/null || fail 'conflitto non riportato'
[ ! -e "$repo_conflict/AGENTS.md" ] || fail 'conflitto ha prodotto copia parziale'
printf '%s\n' 'OK conflitto senza copia parziale'

not_git=$tmp_dir/not-git
mkdir -p "$not_git"
if "$init_script" "$not_git" > "$tmp_dir/not-git.out" 2> "$tmp_dir/not-git.err"; then
  fail 'destinazione non Git accettata'
fi
grep '^ERROR la destinazione non è un repository Git:' "$tmp_dir/not-git.err" >/dev/null || fail 'errore non Git non riportato'
printf '%s\n' 'OK destinazione non Git'

repo_subdir=$tmp_dir/repo-subdir
make_repo "$repo_subdir"
mkdir -p "$repo_subdir/subdir"
if "$init_script" "$repo_subdir/subdir" > "$tmp_dir/subdir.out" 2> "$tmp_dir/subdir.err"; then
  fail 'sottocartella repository Git accettata'
fi
grep '^ERROR la destinazione non è la root del repository Git:' "$tmp_dir/subdir.err" >/dev/null || fail 'errore root repository non riportato'
assert_empty_find "$repo_subdir/subdir"
printf '%s\n' 'OK sottocartella repository Git rifiutata'

repo_other=$tmp_dir/repo-other
make_repo "$repo_other"
(cd /tmp && "$init_script" "$repo_other") > "$tmp_dir/other.out"
assert_same_tree "$repo_other"
printf '%s\n' 'OK esecuzione da directory diversa'

printf '%s\n' 'OK test init-project completati'
