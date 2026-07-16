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

Per applicarlo a un repository Git esistente:

```bash
./scripts/init-project.sh /percorso/progetto
```

Per vedere cosa verrebbe creato senza modificare la destinazione:

```bash
./scripts/init-project.sh --dry-run /percorso/progetto
```

Lo script copia solo i file mancanti, lascia invariati quelli identici e si ferma prima di qualsiasi copia se trova un file esistente con contenuto diverso. Non crea commit, branch, remote o configurazioni Git nel progetto di destinazione.

Dopo l'inizializzazione, i file copiati appartengono al nuovo repository. Le modifiche future a `templates/project/` valgono solo per nuove inizializzazioni e non sincronizzano automaticamente i progetti già creati.
