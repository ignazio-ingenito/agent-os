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

assert_git_repo() {
  dir=$1
  git -C "$dir" rev-parse --is-inside-work-tree >/dev/null 2>&1 || fail "repository Git non creato: $dir"
  root=$(git -C "$dir" rev-parse --show-toplevel)
  root=$(CDPATH= cd -- "$root" && pwd -P)
  dir_root=$(CDPATH= cd -- "$dir" && pwd -P)
  [ "$root" = "$dir_root" ] || fail "root Git diversa dalla destinazione: $dir"
}

assert_no_remote() {
  dir=$1
  remotes=$(git -C "$dir" remote)
  [ -z "$remotes" ] || fail "remote inatteso in $dir"
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

assert_tree_unchanged() {
  dir=$1
  before=$2
  after=$tmp_dir/after.list
  (cd "$dir" && find . -mindepth 1 | sort) > "$after"
  cmp -s "$before" "$after" || fail "la destinazione è stata modificata: $dir"
}

missing_dry=$tmp_dir/missing-dry
"$init_script" --dry-run "$missing_dry" > "$tmp_dir/missing-dry.out"
[ ! -e "$missing_dry" ] || fail 'dry-run ha creato la directory'
grep "^CREATE_DIR $missing_dry$" "$tmp_dir/missing-dry.out" >/dev/null || fail 'dry-run non mostra CREATE_DIR'
grep "^GIT_INIT $missing_dry$" "$tmp_dir/missing-dry.out" >/dev/null || fail 'dry-run non mostra GIT_INIT'
grep '^CREATE AGENTS.md$' "$tmp_dir/missing-dry.out" >/dev/null || fail 'dry-run non mostra CREATE AGENTS.md'
printf '%s\n' 'OK dry-run su percorso inesistente'

missing_init=$tmp_dir/missing-init
"$init_script" "$missing_init" > "$tmp_dir/missing-init.out"
[ -d "$missing_init" ] || fail 'inizializzazione non ha creato la directory'
assert_git_repo "$missing_init"
assert_same_tree "$missing_init"
assert_no_remote "$missing_init"
printf '%s\n' 'OK inizializzazione su percorso inesistente'

empty_dir=$tmp_dir/empty-dir
mkdir -p "$empty_dir"
"$init_script" "$empty_dir" > "$tmp_dir/empty-dir.out"
assert_git_repo "$empty_dir"
assert_same_tree "$empty_dir"
assert_no_remote "$empty_dir"
printf '%s\n' 'OK inizializzazione in directory vuota'

repo_empty=$tmp_dir/repo-empty
make_repo "$repo_empty"
git -C "$repo_empty" remote add origin git@example.invalid:owner/repo.git
"$init_script" "$repo_empty" > "$tmp_dir/repo-empty.out"
assert_git_repo "$repo_empty"
assert_same_tree "$repo_empty"
remote_url=$(git -C "$repo_empty" remote get-url origin)
[ "$remote_url" = 'git@example.invalid:owner/repo.git' ] || fail 'remote esistente modificato'
printf '%s\n' 'OK repository Git vuoto con remote preservato'

non_empty=$tmp_dir/non-empty
mkdir -p "$non_empty"
printf '%s\n' 'contenuto esistente' > "$non_empty/file.txt"
(cd "$non_empty" && find . -mindepth 1 | sort) > "$tmp_dir/non-empty.before"
if "$init_script" "$non_empty" > "$tmp_dir/non-empty.out" 2> "$tmp_dir/non-empty.err"; then
  fail 'directory non vuota accettata'
fi
grep '^ERROR destinazione non vuota:' "$tmp_dir/non-empty.err" >/dev/null || fail 'errore directory non vuota non riportato'
assert_tree_unchanged "$non_empty" "$tmp_dir/non-empty.before"
[ ! -d "$non_empty/.git" ] || fail 'directory non vuota ha ricevuto git init'
printf '%s\n' 'OK directory non vuota rifiutata senza modifiche'

"$init_script" "$missing_init" > "$tmp_dir/second.out"
grep '^UNCHANGED AGENTS.md$' "$tmp_dir/second.out" >/dev/null || fail 'seconda esecuzione non riporta file identici'
! grep '^CREATE ' "$tmp_dir/second.out" >/dev/null || fail 'seconda esecuzione crea file'
! grep '^GIT_INIT ' "$tmp_dir/second.out" >/dev/null || fail 'seconda esecuzione reinizializza Git'
assert_same_tree "$missing_init"
assert_no_remote "$missing_init"
printf '%s\n' 'OK seconda inizializzazione idempotente'

repo_conflict=$tmp_dir/repo-conflict
"$init_script" "$repo_conflict" > "$tmp_dir/conflict-init.out"
printf '%s\n' 'contenuto diverso' > "$repo_conflict/docs/README.md"
rm -f "$repo_conflict/AGENTS.md"
(cd "$repo_conflict" && find . -mindepth 1 | sort) > "$tmp_dir/conflict.before"
if "$init_script" "$repo_conflict" > "$tmp_dir/conflict.out" 2> "$tmp_dir/conflict.err"; then
  fail 'conflitto non ha prodotto errore'
fi
grep '^CONFLICT docs/README.md$' "$tmp_dir/conflict.out" >/dev/null || fail 'conflitto non riportato'
[ ! -e "$repo_conflict/AGENTS.md" ] || fail 'conflitto ha prodotto copia parziale'
assert_tree_unchanged "$repo_conflict" "$tmp_dir/conflict.before"
printf '%s\n' 'OK conflitto senza copia parziale'

repo_other=$tmp_dir/repo-other
(cd /tmp && "$init_script" "$repo_other") > "$tmp_dir/other.out"
assert_git_repo "$repo_other"
assert_same_tree "$repo_other"
assert_no_remote "$repo_other"
printf '%s\n' 'OK esecuzione da directory diversa'

repo_spaces="$tmp_dir/progetto con spazi"
"$init_script" "$repo_spaces" > "$tmp_dir/spaces.out"
assert_git_repo "$repo_spaces"
assert_same_tree "$repo_spaces"
assert_no_remote "$repo_spaces"
printf '%s\n' 'OK percorso contenente spazi'

repo_init=$tmp_dir/repo-init
"$init_script" "$repo_init" > "$tmp_dir/init.out"
assert_same_tree "$repo_init"
assert_git_repo "$repo_init"
assert_no_remote "$repo_init"
printf '%s\n' 'OK nessun remote aggiunto'

printf '%s\n' 'OK test init-project completati'
