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

assert_remote_url() {
  dir=$1
  name=$2
  expected=$3
  actual=$(git -C "$dir" config --get "remote.$name.url")
  [ "$actual" = "$expected" ] || fail "remote $name diverso: $actual"
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
grep 'Vuoi configurare il remote origin' "$tmp_dir/missing-init.out" >/dev/null && fail 'esecuzione non interattiva ha mostrato prompt'
grep '^Nessun remote configurato\.$' "$tmp_dir/missing-init.out" >/dev/null || fail 'default senza remote non riportato'
printf '%s\n' 'OK default non interattivo senza remote'

no_prompt=$tmp_dir/no-prompt
"$init_script" --no-prompt "$no_prompt" > "$tmp_dir/no-prompt.out"
assert_git_repo "$no_prompt"
assert_same_tree "$no_prompt"
assert_no_remote "$no_prompt"
grep 'Vuoi configurare il remote origin' "$tmp_dir/no-prompt.out" >/dev/null && fail '--no-prompt ha mostrato prompt'
printf '%s\n' 'OK --no-prompt senza remote'

remote_project=$tmp_dir/remote-project
ssh_url='git@github.com:utente/progetto.git'
"$init_script" --remote "$ssh_url" "$remote_project" > "$tmp_dir/remote-project.out"
assert_git_repo "$remote_project"
assert_same_tree "$remote_project"
assert_remote_url "$remote_project" origin "$ssh_url"
grep "^REMOTE_ADD origin $ssh_url$" "$tmp_dir/remote-project.out" >/dev/null || fail '--remote non mostra REMOTE_ADD'
printf '%s\n' 'OK --remote su nuovo progetto SSH'

no_prompt_remote=$tmp_dir/no-prompt-remote
https_url='https://github.com/utente/progetto.git'
"$init_script" --no-prompt --remote "$https_url" "$no_prompt_remote" > "$tmp_dir/no-prompt-remote.out"
assert_git_repo "$no_prompt_remote"
assert_same_tree "$no_prompt_remote"
assert_remote_url "$no_prompt_remote" origin "$https_url"
grep 'Vuoi configurare il remote origin' "$tmp_dir/no-prompt-remote.out" >/dev/null && fail '--no-prompt --remote ha mostrato prompt'
printf '%s\n' 'OK --no-prompt --remote HTTPS'

dry_remote=$tmp_dir/dry-remote
"$init_script" --dry-run --remote "$ssh_url" "$dry_remote" > "$tmp_dir/dry-remote.out"
[ ! -e "$dry_remote" ] || fail 'dry-run --remote ha creato la directory'
grep "^REMOTE_ADD origin $ssh_url$" "$tmp_dir/dry-remote.out" >/dev/null || fail 'dry-run --remote non mostra REMOTE_ADD'
printf '%s\n' 'OK dry-run --remote senza modifiche'

dry_sensitive=$tmp_dir/dry-sensitive
sensitive_url='https://token-secret@example.invalid/utente/progetto.git'
"$init_script" --dry-run --remote "$sensitive_url" "$dry_sensitive" > "$tmp_dir/dry-sensitive.out"
grep 'token-secret' "$tmp_dir/dry-sensitive.out" >/dev/null && fail 'URL sensibile stampato integralmente'
grep '^REMOTE_ADD origin https://\*\*\*@example.invalid/utente/progetto.git$' "$tmp_dir/dry-sensitive.out" >/dev/null || fail 'URL sensibile non mascherato'
printf '%s\n' 'OK URL con credenziali mascherato in output'

missing_remote_url=$tmp_dir/missing-remote-url
if "$init_script" "$missing_remote_url" --remote > "$tmp_dir/missing-remote-url.out" 2> "$tmp_dir/missing-remote-url.err"; then
  fail '--remote senza URL accettato'
fi
[ ! -e "$missing_remote_url" ] || fail '--remote senza URL ha modificato la destinazione'
grep '^ERROR opzione --remote senza URL$' "$tmp_dir/missing-remote-url.err" >/dev/null || fail 'errore --remote senza URL non riportato'
printf '%s\n' 'OK --remote senza URL'

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
assert_remote_url "$repo_empty" origin 'git@example.invalid:owner/repo.git'
printf '%s\n' 'OK repository Git vuoto con remote preservato'

repo_origin_conflict=$tmp_dir/repo-origin-conflict
make_repo "$repo_origin_conflict"
git -C "$repo_origin_conflict" remote add origin git@example.invalid:owner/original.git
if "$init_script" --dry-run --remote "$ssh_url" "$repo_origin_conflict" > "$tmp_dir/repo-origin-conflict-dry.out" 2> "$tmp_dir/repo-origin-conflict-dry.err"; then
  fail 'dry-run --remote ha accettato origin esistente'
fi
! grep '^REMOTE_ADD ' "$tmp_dir/repo-origin-conflict-dry.out" >/dev/null || fail 'dry-run mostra REMOTE_ADD con origin esistente'
if "$init_script" --remote "$ssh_url" "$repo_origin_conflict" > "$tmp_dir/repo-origin-conflict.out" 2> "$tmp_dir/repo-origin-conflict.err"; then
  fail '--remote ha sovrascritto origin esistente'
fi
assert_remote_url "$repo_origin_conflict" origin 'git@example.invalid:owner/original.git'
find "$repo_origin_conflict" -mindepth 1 -not -path "$repo_origin_conflict/.git" -not -path "$repo_origin_conflict/.git/*" | grep . >/dev/null && fail 'origin esistente ha prodotto copia file'
grep '^ERROR remote origin già esistente:' "$tmp_dir/repo-origin-conflict.err" >/dev/null || fail 'errore origin esistente non riportato'
printf '%s\n' 'OK --remote rifiuta origin esistente senza copia'

repo_other_remote=$tmp_dir/repo-other-remote
make_repo "$repo_other_remote"
git -C "$repo_other_remote" remote add upstream git@example.invalid:owner/upstream.git
"$init_script" --remote "$https_url" "$repo_other_remote" > "$tmp_dir/repo-other-remote.out"
assert_same_tree "$repo_other_remote"
assert_remote_url "$repo_other_remote" upstream 'git@example.invalid:owner/upstream.git'
assert_remote_url "$repo_other_remote" origin "$https_url"
printf '%s\n' 'OK altri remote preservati e origin aggiunto'

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

"$init_script" "$remote_project" > "$tmp_dir/second-remote.out"
assert_same_tree "$remote_project"
assert_remote_url "$remote_project" origin "$ssh_url"
! grep '^REMOTE_ADD ' "$tmp_dir/second-remote.out" >/dev/null || fail 'seconda esecuzione ha modificato origin'
printf '%s\n' 'OK seconda esecuzione preserva origin'

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

repo_eval=$tmp_dir/repo-eval
eval_url='https://example.invalid/utente/$(touch-eval-non-deve-esistere);progetto.git'
"$init_script" --remote "$eval_url" "$repo_eval" > "$tmp_dir/eval.out"
assert_git_repo "$repo_eval"
assert_same_tree "$repo_eval"
assert_remote_url "$repo_eval" origin "$eval_url"
[ ! -e "$tmp_dir/touch-eval-non-deve-esistere" ] || fail 'URL interpretato tramite eval'
printf '%s\n' 'OK URL remoto passato senza eval'

repo_init=$tmp_dir/repo-init
"$init_script" "$repo_init" > "$tmp_dir/init.out"
assert_same_tree "$repo_init"
assert_git_repo "$repo_init"
assert_no_remote "$repo_init"
printf '%s\n' 'OK nessun remote aggiunto'

printf '%s\n' 'OK test init-project completati'
