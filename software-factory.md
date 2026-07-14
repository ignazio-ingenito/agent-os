# Software Factory Workflow

**Stato:** Draft

## Scopo

Questo documento descrive il workflow funzionale minimo della Software Factory: come il lavoro passa da richiesta a handoff, Pull Request, esecuzione Codex, verifica, review, fix, merge e wave successiva.

Il documento dettaglia il comportamento richiesto a livello funzionale e rimanda a `requirements/REQ-0001-software-factory.md` e `rfcs/RFC-0001-principles.md` come fonti autorevoli per requisito, vincoli e principi.

## Perimetro

Il workflow copre il passaggio operativo tra gli strumenti già presenti: ChatGPT web, GitHub, Developer Workspace e Codex.

Il documento non definisce:

- architettura tecnica dell'orchestrazione;
- formato definitivo dell'handoff;
- formato definitivo della review;
- meccanismo di rilevazione delle Pull Request o dei commenti;
- condizioni tecniche esatte di merge;
- passaggio automatico alla wave successiva.

Queste decisioni restano aperte e devono essere definite in documenti successivi, se necessarie.

## Attori e strumenti effettivamente presenti

- Utente: definisce il lavoro, prende le decisioni rilevanti e approva le modifiche finali.
- ChatGPT web: supporta la preparazione dell'handoff e della review senza essere invocato tramite API.
- GitHub: conserva branch, Pull Request, commit, commenti di review ed evidenze utili al contesto operativo.
- Developer Workspace: ambiente in cui viene eseguito Codex sul repository e sulla branch corretti.
- Codex: implementa il task nel repository, crea i commit necessari e applica eventuali fix richiesti dalla review.

## Workflow funzionale

1. Creazione della wave: l'utente definisce in ChatGPT web una wave di lavoro e mantiene il controllo sulla definizione del lavoro.
2. Creazione dell'handoff: ChatGPT web produce un handoff strutturato. Il formato definitivo dell'handoff non è deciso in questo documento.
3. Apertura della Pull Request: l'handoff viene conservato nel repository tramite una branch e una Pull Request.
4. Individuazione del task: il Developer Workspace deve poter individuare dalla Pull Request il file di task da eseguire. Il meccanismo tecnico resta da definire e verificare.
5. Esecuzione di Codex sulla branch corretta: Codex viene avviato nel Developer Workspace sul repository e sulla branch della Pull Request interessata.
6. Verifiche: vengono eseguite le verifiche previste dal progetto e l'esito viene registrato con evidenze osservabili.
7. Review: ChatGPT web supporta la review della Pull Request usando il contesto preparato e conservato nel repository o nella Pull Request.
8. Ciclo di correzione: se la review richiede modifiche, le osservazioni vengono registrate nella Pull Request; Codex applica i fix sulla stessa branch e le verifiche vengono ripetute.
9. Merge: la Pull Request viene integrata solo dopo il superamento dei controlli previsti e dell'approvazione richiesta.
10. Passaggio alla wave successiva: se il piano prevede una wave successiva, il contesto necessario viene recuperato dal repository per preparare il passaggio seguente senza dipendere dalla persistenza di una singola chat.

## Passaggi umani obbligatori

- Definizione della wave.
- Decisioni rilevanti che modificano comportamento richiesto, architettura, interfacce, sicurezza, dati persistenti, dipendenze, operatività, manutenzione futura o documentazione autorevole.
- Approvazione finale delle modifiche prima del merge.
- Uso di ChatGPT web quando serve produrre o valutare contenuti tramite interfaccia web.

## Passaggi candidati all'automazione

I seguenti passaggi sono candidati all'automazione solo dopo verifica di maturità, implementabilità ed evidenze osservabili:

- conservazione dell'handoff nel repository e apertura della Pull Request;
- individuazione del file di task dalla Pull Request;
- avvio di Codex sul repository e sulla branch corretti;
- registrazione degli esiti delle verifiche con evidenze osservabili;
- recupero delle osservazioni di review dalla Pull Request;
- preparazione del contesto necessario per la wave successiva.

## Condizioni funzionali di completamento

Una wave è funzionalmente completata quando:

- il task definito nell'handoff è stato eseguito sulla branch della Pull Request interessata;
- le verifiche previste dal progetto sono state eseguite e registrate con evidenze osservabili;
- eventuali osservazioni di review bloccanti sono state risolte oppure sono coperte da una deroga esplicitamente approvata e motivata;
- l'approvazione richiesta è presente;
- la Pull Request è stata integrata senza automatizzare modifiche non approvate;
- il contesto necessario per una wave successiva è conservato nel repository quando serve a ricostruire il lavoro, motivare una decisione o proseguire il piano.

## Decisioni ancora aperte

- Formato definitivo dell'handoff.
- Formato definitivo della review.
- Meccanismo tecnico per rilevare Pull Request, file di task e osservazioni di review.
- Meccanismo tecnico per avviare Codex dal Developer Workspace.
- Set concreto di verifiche automatiche previste dal progetto.
- Condizioni tecniche esatte di merge.
- Modalità del passaggio automatico alla wave successiva.
