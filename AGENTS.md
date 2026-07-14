# AGENTS.md

## Scopo

Questo file contiene le regole operative minime per lavorare nel repository.

## Fonti autorevoli

Prima di proporre o applicare modifiche, leggere:

1. `requirements/REQ-0001-software-factory.md`
2. `rfcs/RFC-0001-principles.md`
3. gli altri documenti con stato `Active` direttamente pertinenti al task

I documenti con stato `Draft` possono essere usati come materiale di lavoro, ma non costituiscono regole approvate.

I documenti con stato `Archived` non devono essere usati come istruzioni operative.

## Regole obbligatorie

- Applicare i principi definiti in `rfcs/RFC-0001-principles.md`.
- Proporre la soluzione più semplice che soddisfa tutti i requisiti applicabili.
- Non introdurre componenti, documenti, astrazioni o automazioni senza una necessità verificabile.
- Non inventare informazioni mancanti.
- Usare deduzioni solo quando sono chiaramente e logicamente derivabili da fatti disponibili.
- Per ogni deduzione, indicare i fatti di partenza e il passaggio logico.
- Se manca un'informazione necessaria per una decisione rilevante, fermarsi e richiederla.
- Non bloccare il lavoro per informazioni che non influenzano il task.
- Evitare duplicazioni: ogni informazione operativa deve avere una sola fonte autorevole.
- Aggiornare, sostituire o archiviare i documenti resi obsoleti da una modifica.
- Non creare un nuovo documento quando uno esistente può contenere l'informazione senza perdere chiarezza.
- Usare Conventional Commits per commit e titoli delle Pull Request.

## Prima di modificare il repository

Verificare:

1. Quale requisito viene soddisfatto?
2. Quali file sono realmente necessari?
3. Esiste un modo più semplice?
4. La modifica introduce duplicazioni?
5. Quali verifiche dimostreranno che il lavoro è corretto?

## Al termine del lavoro

Fornire:

- riepilogo delle modifiche;
- verifiche eseguite e relativo esito;
- eventuali informazioni mancanti;
- eventuali deduzioni utilizzate, con le rispettive fonti;
- documenti aggiornati, sostituiti o archiviati.

Non dichiarare completato un lavoro quando una verifica obbligatoria ha esito negativo.
