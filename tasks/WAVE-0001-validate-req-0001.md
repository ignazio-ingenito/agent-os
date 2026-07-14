# WAVE-0001 – Validare REQ-0001

**Stato:** Archived

Nota: wave completata tramite PR #6; il file è conservato esclusivamente come evidenza storica e non costituisce un'istruzione operativa corrente.

## Obiettivo

Revisionare `requirements/REQ-0001-software-factory.md` applicando la sequenza di lenti documentata in `backlog/decision-review-process.md`, decidere quali osservazioni accogliere e aggiornare il requisito solo quando la modifica è giustificata.

Il risultato atteso è un requisito più preciso, verificabile e minimale, pronto per essere proposto come `Active`.

## Fonti autorevoli da leggere

1. `AGENTS.md`
2. `requirements/REQ-0001-software-factory.md`
3. `rfcs/RFC-0001-principles.md`
4. `backlog/decision-review-process.md`

Non usare il branch `archive/agent-os-v1` come fonte operativa.

## Attività

### 1. Verifica preliminare

- Controllare che il task sia eseguibile con le informazioni disponibili.
- Identificare eventuali informazioni mancanti necessarie per assumere decisioni rilevanti.
- Non bloccare il lavoro per informazioni non rilevanti.

### 2. Applicare le lenti in sequenza

Applicare, nell'ordine:

1. Challenge Me
2. Critique
3. Review
4. Operationalize
5. Minimalism Review
6. Legal / Precision Review

Per ogni lente distinguere:

- errore o non conformità;
- miglioramento utile;
- suggerimento facoltativo.

### 3. Consolidare le osservazioni

Produrre una tabella con questo formato:

| Osservazione | Decisione | Motivazione |
|---|---|---|
| Descrizione | Accolta / Rifiutata / Rimandata | Motivazione verificabile |

Le osservazioni duplicate devono essere accorpate.

Le osservazioni non devono essere applicate automaticamente: ogni modifica deve essere coerente con RFC-0001 e avere una motivazione esplicita.

### 4. Aggiornare REQ-0001

Modificare `requirements/REQ-0001-software-factory.md` esclusivamente per le osservazioni accolte.

Il documento aggiornato deve:

- preservare il requisito originario;
- distinguere chiaramente obiettivi, vincoli, flusso desiderato e criteri di successo;
- evitare dettagli architetturali non ancora decisi;
- evitare duplicazioni e formulazioni speculative;
- usare linguaggio normativo coerente;
- contenere criteri verificabili;
- non introdurre ruoli, modelli o automazioni non supportate da decisioni attive.

Non cambiare lo stato da `Draft` a `Active`: l'attivazione richiede approvazione umana successiva.

### 5. Conservare l'esito della review

Creare `reviews/REQ-0001-review.md` contenente:

- data della review;
- lenti applicate;
- tabella consolidata delle osservazioni;
- riepilogo delle modifiche accolte;
- osservazioni rimandate;
- esito della checklist di RFC-0001 con evidenze.

Questo documento deve avere stato `Draft`.

### 6. Verifica finale

Verificare almeno che:

- tutti i requisiti originari siano ancora rappresentati;
- nessuna informazione sia stata inventata;
- ogni deduzione riportata nella review citi i fatti e il passaggio logico;
- il documento non contenga dettagli di soluzione non ancora approvati;
- non siano state introdotte duplicazioni evitabili;
- ogni criterio di successo sia osservabile;
- la checklist obbligatoria di RFC-0001 sia stata compilata.

## File consentiti

Il task può modificare o creare esclusivamente:

- `requirements/REQ-0001-software-factory.md`
- `reviews/REQ-0001-review.md`

Non modificare altri file. Se emerge la necessità di modificarli, documentarla nella review senza applicare la modifica.

## Output richiesto

Al termine:

1. aggiornare i due file consentiti;
2. eseguire le verifiche applicabili;
3. creare commit Conventional Commits;
4. lasciare nella Pull Request un riepilogo con:
   - modifiche effettuate;
   - verifiche eseguite;
   - informazioni mancanti;
   - osservazioni rimandate;
   - eventuali deduzioni con relative fonti.

## Criteri di completamento

Il task è completato quando:

- tutte le sei lenti sono state applicate;
- la tabella decisionale è completa;
- REQ-0001 contiene solo modifiche accolte e motivate;
- `reviews/REQ-0001-review.md` contiene evidenze sufficienti;
- nessun file fuori perimetro è stato modificato;
- non risultano verifiche obbligatorie con esito `NO` prive di azione correttiva.
