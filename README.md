# Software Factory

Questo repository definisce e valida un processo per lo sviluppo software assistito da AI.

L'obiettivo è ridurre il lavoro manuale ripetitivo, mantenere le decisioni nel repository e automatizzare progressivamente solo le attività sufficientemente mature, verificabili e realmente implementabili.

## Documenti attivi

- [`requirements/REQ-0001-software-factory.md`](requirements/REQ-0001-software-factory.md)  
  Requisito originario del progetto.

- [`rfcs/RFC-0001-principles.md`](rfcs/RFC-0001-principles.md)  
  Principi fondanti che governano il progetto.

## Documenti in validazione

- [`software-factory.md`](software-factory.md)
  Workflow funzionale minimo della Software Factory.

- [`backlog/decision-review-process.md`](backlog/decision-review-process.md)  
  Ipotesi di processo di review da validare su ulteriori casi d'uso.

## Regole operative

Le istruzioni per lavorare nel repository sono definite in [`AGENTS.md`](AGENTS.md).

Il repository deve rimanere essenziale. Nuovi documenti, cartelle, workflow o automazioni devono essere introdotti solo quando rispondono a un'esigenza reale e non possono essere evitati o accorpati.

## Scheletro iniziale per nuovi repository

Lo scheletro iniziale dei progetti vive in `templates/project/`. Contiene le regole operative minime, l'indice documentale, il puntatore allo stato esecutivo e i template per issue, pull request e wave.

```text
agent-os
      │ scripts/init-project.sh
      ▼
nuovo progetto locale
      ├── crea directory (se necessaria)
      ├── git init
      ├── copia templates/project/
      └── progetto autonomo
                └── origin (facoltativo)
```

Il bootstrap crea un punto di partenza comune, non un collegamento permanente con Agent OS.

Per creare un nuovo progetto locale a partire dallo scheletro:

```bash
./scripts/init-project.sh /percorso/progetto
./scripts/init-project.sh --no-prompt /percorso/progetto
./scripts/init-project.sh --remote git@github.com:utente/progetto.git /percorso/progetto
```

Per vedere cosa verrebbe creato senza modificare la destinazione:

```bash
./scripts/init-project.sh --dry-run /percorso/progetto
./scripts/init-project.sh --dry-run --remote git@github.com:utente/progetto.git /percorso/progetto
```

Lo script crea la directory quando manca, esegue `git init` se la destinazione non è già un repository Git autonomo e copia integralmente i file da `templates/project/`.

La destinazione viene accettata solo quando non esiste, è vuota, contiene soltanto `.git`, oppure è un progetto già inizializzato con gli stessi file dello scheletro. In caso di contenuti diversi o file aggiuntivi, lo script termina con `ERROR` prima di modificare la destinazione.

Il remote è facoltativo. Il default è nessun remote; in un terminale interattivo lo script può proporre di configurare `origin`. `--no-prompt` disabilita ogni domanda. `--remote` configura direttamente `origin` con l'URL indicato, senza creare il repository remoto e senza eseguire push. L'utente può configurare `origin` anche in seguito con i normali comandi Git.

Lo script non crea commit o branch, non esegue push e non modifica configurazioni Git globali. Eventuali remote già presenti in un repository Git vuoto restano invariati.

Dopo l'inizializzazione, i file copiati appartengono al nuovo repository. Le modifiche future a `templates/project/` valgono solo per nuove inizializzazioni e non sincronizzano automaticamente i progetti già creati.
