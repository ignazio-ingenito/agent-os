# Software Factory Workflow Review

**Stato:** Draft
**Data:** 2026-07-14

## Artefatto revisionato

- `software-factory.md`

## Osservazioni consolidate

| Lente | Osservazione | Decisione | Motivazione |
|---|---|---|---|
| Zoom-out | Il documento deve restare una descrizione funzionale e non diventare un disegno di orchestrazione. | Accolta | Fatto: REQ-0001 dichiara fuori ambito architettura, trigger, polling, webhook e formati definitivi. Motivazione: il perimetro del documento esclude le decisioni tecniche e le sposta tra le decisioni aperte. |
| Zoom-out | Il workflow deve mostrare l'intero passaggio richiesta, handoff, Pull Request, Codex, verifiche, review, fix, merge e wave successiva. | Accolta | Fatto: il task richiede esplicitamente questa sequenza. Motivazione: la sezione `Workflow funzionale` copre tutti i passaggi senza aggiungere componenti. |
| Challenge Me | La formulazione dei passaggi candidati all'automazione poteva sembrare una promessa di fattibilità già verificata. | Accolta | Fatto: RFC-0001 vieta di presentare come confermata una fattibilità non verificata. Motivazione: la sezione indica che i passaggi sono candidati solo dopo verifica di maturità, implementabilità ed evidenze osservabili. |
| Challenge Me | Il passaggio alla wave successiva poteva implicare un'automazione già decisa. | Accolta | Fatto: REQ-0001 indica il passaggio automatico alla wave successiva fuori dal requisito attuale. Motivazione: il documento limita il passaggio alla preparazione funzionale del contesto e lascia aperta la modalità automatica. |
| Review | Il documento deve distinguere comportamento richiesto, decisioni già attive e decisioni aperte. | Accolta | Fatto: il task richiede questa separazione. Motivazione: `Scopo`, `Workflow funzionale` e `Condizioni funzionali di completamento` descrivono comportamento richiesto; i riferimenti a REQ-0001 e RFC-0001 indicano decisioni attive; `Decisioni ancora aperte` raccoglie ciò che non è deciso. |
| Review | Sarebbe utile definire formalmente i termini wave, handoff e review. | Rimandata | Fatto: `reviews/REQ-0001-review.md` ha già rimandato le definizioni normative di questi termini. Motivazione: introdurle qui amplierebbe il perimetro e rischierebbe duplicazione prima dei formati definitivi. |
| Operationalize | Le condizioni di completamento devono essere verificabili tramite evidenze. | Accolta | Fatto: RFC-0001 richiede verifiche con evidenze osservabili; REQ-0001 richiede esiti registrati. Motivazione: le condizioni richiedono branch della Pull Request, verifiche registrate, review risolte o rimandate, approvazione e contesto conservato quando necessario. |
| Operationalize | Il documento non deve dichiarare capacità non ancora dimostrate come già disponibili. | Accolta | Fatto: REQ-0001 esprime alcune capacità come criteri di successo, non come implementazioni già presenti. Motivazione: il documento usa `deve poter` o qualifica i meccanismi tecnici come da definire e verificare. |
| Minimalism Review | Una tabella di responsabilità o una state machine renderebbe il documento più strutturato. | Rifiutata | Fatto: il task vieta state machine e nuovi modelli; RFC-0001 richiede semplicità. Motivazione: elenco e sezioni richieste sono sufficienti per il workflow funzionale minimo. |
| Minimalism Review | Il documento rischia di duplicare REQ-0001 se ripete tutti i vincoli e criteri. | Accolta | Fatto: RFC-0001 richiede una sola fonte autorevole per ogni informazione operativa. Motivazione: il documento rimanda alle fonti autorevoli e riprende solo gli elementi necessari al workflow funzionale. |
| Legal / Precision Review | L'espressione `automatico` deve essere usata con cautela perché l'automazione progressiva non è ancora progettata. | Accolta | Fatto: REQ-0001 consente automazione solo per attività mature, verificabili e implementabili. Motivazione: i passaggi sono indicati come candidati all'automazione, non come automazioni approvate. |
| Legal / Precision Review | Le condizioni di merge non devono diventare condizioni tecniche esatte. | Accolta | Fatto: REQ-0001 lascia fuori ambito le condizioni esatte di merge. Motivazione: il documento si limita a controlli previsti e approvazione richiesta, rinviando le condizioni tecniche esatte. |

## Deduzioni utilizzate

| Deduzione | Fatti di partenza | Passaggio logico |
|---|---|---|
| Il workflow può essere documentato senza progettare l'orchestrazione. | REQ-0001 contiene un flusso desiderato funzionale e dichiara fuori ambito architettura, trigger, meccanismi di orchestrazione e formati definitivi. | Se il documento descrive solo passaggi funzionali e rinvia le scelte tecniche, soddisfa il bisogno senza introdurre architettura. |
| `software-factory.md` deve restare `Draft`. | RFC-0001 definisce `Draft` come stato non ancora vincolante; il task richiede che il nuovo documento abbia stato `Draft`. | Un nuovo documento funzionale non ancora approvato deve essere marcato `Draft`. |
| Il README deve indicizzare il nuovo documento come Draft. | README contiene una sezione `Documenti in validazione`; il task autorizza l'aggiornamento del README solo se necessario per indicizzare il nuovo documento come `Draft`. | Aggiungere il link nella sezione esistente evita un documento non discoverable senza creare nuove strutture. |

## Checklist RFC-0001

| Verifica | Esito | Evidenza o azione correttiva |
|---|---|---|
| La soluzione soddisfa tutti i requisiti applicabili? | SÌ | Sono stati creati `software-factory.md` e questa review, con aggiornamento del README solo per indicizzare il documento Draft. |
| Esiste un modo più semplice per ottenere lo stesso risultato? | NO | Le sezioni richieste sono presenti senza aggiungere strutture ulteriori. Azione correttiva: nessuna. |
| Ogni complessità introdotta ha una giustificazione verificabile? | SÌ | L'unico nuovo artefatto oltre al workflow è la review richiesta dal task. |
| La fattibilità della soluzione è stata verificata? | SÌ | La modifica è documentale ed è verificabile tramite ispezione del diff e controlli finali. |
| I fatti utilizzati provengono da fonti verificabili? | SÌ | Fonti: `AGENTS.md`, `requirements/REQ-0001-software-factory.md`, `rfcs/RFC-0001-principles.md`, `reviews/REQ-0001-review.md`, `reviews/foundation-activation-review.md`, `backlog/decision-review-process.md`, `README.md`. |
| Ogni deduzione cita i fatti e il passaggio logico da cui deriva? | SÌ | Le deduzioni sono elencate nella sezione `Deduzioni utilizzate`. |
| Sono presenti ipotesi non dichiarate? | NO | Le capacità non verificate sono qualificate come candidate o come decisioni aperte. Azione correttiva: nessuna. |
| Mancano informazioni necessarie per assumere decisioni rilevanti? | NO | Le decisioni tecniche mancanti sono aperte ma non bloccano la definizione funzionale minima. Azione correttiva: nessuna. |
| Le decisioni rilevanti sono tracciabili e contestabili? | SÌ | Le scelte del documento derivano da REQ-0001, RFC-0001 e dal task. |
| Ogni informazione operativa ha una sola fonte autorevole? | SÌ | REQ-0001 e RFC-0001 restano fonti autorevoli; `software-factory.md` descrive solo il workflow funzionale Draft. |
| Sono state introdotte duplicazioni evitabili? | NO | Il documento rimanda alle fonti e non ripete integralmente requisito o principi. Azione correttiva: nessuna. |
| I documenti interessati hanno uno stato corretto? | SÌ | `software-factory.md` e questa review sono `Draft`. |
| La documentazione attiva rappresenta lo stato corrente del progetto? | SÌ | I documenti attivi esistenti non sono stati modificati. |
| Le verifiche producono evidenze osservabili? | SÌ | Le verifiche finali includono `git diff --check`, controllo file modificati, ricerca di marker incompleti e controlli di perimetro. |

## Problemi bloccanti

Nessuno.

## Osservazioni per stato

- Accolte: mantenere il documento funzionale, coprire l'intera sequenza, qualificare automazioni non verificate, distinguere decisioni aperte e condizioni verificabili, evitare duplicazioni.
- Rifiutate: introdurre tabella di responsabilità o state machine.
- Rimandate: definizioni normative di wave, handoff e review.
