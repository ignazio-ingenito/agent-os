# Review REQ-0001

**Stato:** Draft
**Data:** 2026-07-14

## Artefatto revisionato

- `requirements/REQ-0001-software-factory.md`

## Lenti applicate

Le lenti sono state applicate nella sequenza indicata da `backlog/decision-review-process.md`:

1. Challenge Me
2. Critique
3. Review
4. Operationalize
5. Minimalism Review
6. Legal / Precision Review

## Tabella consolidata delle osservazioni

| Osservazione | Decisione | Motivazione |
|---|---|---|
| Challenge Me - Errore o non conformità: il flusso desiderato poteva essere interpretato come architettura tecnica già decisa, pur dichiarando fuori ambito trigger, polling, webhook e formati definitivi. | Accolta | Fatto: REQ-0001 elenca un flusso in 14 passi e dichiara fuori requisito architettura, formato handoff/review, trigger GitHub e polling/webhook. Deduzione: senza una distinzione esplicita, i passi funzionali potevano essere letti come scelte tecniche. Modifica applicata: aggiunto l'ambito e chiarito che il flusso non prescrive trigger, strumenti di orchestrazione, formati o componenti tecnici. |
| Challenge Me - Miglioramento utile: "ridurre al minimo l'intervento umano" era un obiettivo utile ma non abbastanza preciso per distinguere attività ripetitive da decisioni umane rilevanti. | Accolta | Fatto: l'obiettivo richiede riduzione dell'intervento umano e mantenimento del controllo umano. Deduzione: separare esplicitamente definizione del lavoro, decisioni rilevanti e approvazione finale rende osservabile cosa non deve essere automatizzato. Modifica applicata: l'obiettivo elenca i tre ambiti di controllo umano. |
| Challenge Me - Suggerimento facoltativo: introdurre un modello formale di stati della Pull Request. | Rifiutata | Il task vieta di introdurre processi, modelli o automazioni non necessari. REQ-0001 dichiara fuori ambito le condizioni esatte di merge; un modello di stati sarebbe una decisione successiva. |
| Critique - Errore o non conformità: il vincolo "quando rilevanti" non indicava quando requisiti, decisioni, handoff, review e stato del lavoro devono essere conservati nel repository. | Accolta | Fatto: RFC-0001 richiede una sola fonte autorevole e tracciabilità delle decisioni rilevanti. Deduzione: la rilevanza deve essere collegata a ricostruzione del contesto operativo, motivazione delle decisioni o prosecuzione della wave. Modifica applicata: il vincolo ora indica questi tre casi. |
| Critique - Miglioramento utile: il criterio "senza copia e incolla manuali tra più strumenti" rischiava di essere assoluto e in tensione con l'uso di ChatGPT via web senza API. | Accolta | Fatto: REQ-0001 vieta l'uso di API ChatGPT e l'automazione fragile dell'interfaccia web. Deduzione: il requisito può eliminare il copia e incolla ripetitivo dopo la produzione dell'handoff, ma non può implicare automazioni non supportate della UI web. Modifica applicata: il vincolo e il criterio di successo sono stati precisati sui passaggi ripetitivi successivi alla produzione dell'handoff. |
| Critique - Suggerimento facoltativo: definire subito il formato definitivo dell'handoff. | Rifiutata | REQ-0001 dichiara esplicitamente il formato definitivo dell'handoff fuori dal requisito attuale. Definirlo ora amplierebbe il perimetro. |
| Review - Miglioramento utile: obiettivi, vincoli, flusso desiderato e criteri di successo erano presenti ma mancava una sezione di ambito che delimitasse il documento. | Accolta | Fatto: il task richiede di distinguere chiaramente obiettivi, vincoli, flusso desiderato e criteri di successo ed evitare dettagli architetturali non ancora decisi. Deduzione: una sezione "Ambito" riduce interpretazioni improprie senza introdurre nuove decisioni tecniche. Modifica applicata: aggiunta la sezione "Ambito". |
| Review - Suggerimento facoltativo: promuovere lo stato del requisito da `Draft` ad `Active`. | Rifiutata | Il task vieta esplicitamente di cambiare lo stato da `Draft` ad `Active`; l'attivazione richiede approvazione umana successiva. |
| Operationalize - Errore o non conformità: alcuni criteri di successo non indicavano evidenze osservabili, ad esempio "il Developer Workspace può individuare il task e avviare Codex". | Accolta | Fatto: RFC-0001 richiede verifiche con evidenze osservabili. Deduzione: separare individuazione del task e avvio di Codex sulla branch della Pull Request rende i criteri verificabili separatamente. Modifica applicata: i criteri sono stati scomposti e formulati come capacità osservabili. |
| Operationalize - Miglioramento utile: "verifiche automatiche vengono eseguite e registrate" non specificava che l'esito deve includere evidenze. | Accolta | Fatto: REQ-0001 vincola le verifiche a evidenze osservabili; RFC-0001 richiede esiti verificabili. Deduzione: il criterio di successo deve richiamare esplicitamente la registrazione dell'esito con evidenze osservabili. Modifica applicata: criterio aggiornato. |
| Operationalize - Suggerimento facoltativo: aggiungere una matrice completa di test di accettazione. | Rifiutata | Sarebbe un nuovo artefatto o dettaglio operativo non richiesto. Il requisito deve restare a livello di bisogno e criteri di successo. |
| Minimalism Review - Miglioramento utile: evitare duplicazione tra vincoli, criteri e fuori ambito mantenendo una sola fonte per ogni informazione operativa. | Accolta | Fatto: RFC-0001 vieta duplicazioni evitabili. Deduzione: le modifiche devono precisare frasi esistenti senza aggiungere una seconda definizione degli stessi processi. Modifica applicata: sono state precisate sezioni esistenti senza creare nuovi processi o modelli. |
| Minimalism Review - Suggerimento facoltativo: rimuovere il flusso desiderato perché parzialmente sovrapposto ai criteri di successo. | Rifiutata | Il flusso rappresenta il comportamento desiderato originario e orienta i criteri di successo. Rimuoverlo perderebbe chiarezza sul requisito iniziale. |
| Legal / Precision Review - Errore o non conformità: alcune formulazioni normative erano troppo ampie, in particolare "ridotto al minimo" e "quando rilevanti". | Accolta | Fatto: RFC-0001 richiede precisione, verificabilità e assenza di ipotesi non dichiarate. Deduzione: formule assolute o vaghe devono essere collegate a condizioni osservabili. Modifica applicata: sostituite o precisate le formulazioni vaghe. |
| Legal / Precision Review - Miglioramento utile: esplicitare che il merge richiede sia controlli superati sia approvazione richiesta. | Accolta | Fatto: REQ-0001 vincola le modifiche non approvate a non essere integrate automaticamente. Deduzione: il criterio di successo deve includere approvazione richiesta oltre ai controlli previsti. Modifica applicata: criterio di merge aggiornato. |
| Legal / Precision Review - Suggerimento facoltativo: introdurre definizioni normative di "wave", "handoff", "review" e "Developer Workspace". | Rimandata | Le definizioni possono essere utili, ma il task vieta di introdurre modelli o documenti non necessari. I termini sono sufficienti per validare il requisito corrente; eventuali definizioni operative potranno essere decise insieme ai formati e ai workflow successivi. |

## Modifiche accolte

- Aggiunta una sezione `Ambito` per delimitare il requisito e separarlo da architettura, formati e orchestrazione.
- Precisato l'obiettivo distinguendo il controllo umano su definizione del lavoro, decisioni rilevanti e approvazione finale.
- Chiarito che il flusso desiderato è funzionale e non prescrive componenti tecnici.
- Precisati i vincoli su copia e incolla manuale e conservazione nel repository.
- Resi più osservabili i criteri di successo, separando individuazione del task, avvio di Codex sulla branch corretta, aggiornamento della stessa Pull Request, verifiche con evidenze, ciclo di review e merge con approvazione.

## Osservazioni rimandate

- Definizioni normative di "wave", "handoff", "review" e "Developer Workspace".

## Informazioni mancanti

Nessuna informazione mancante blocca il task.

Informazioni non ancora definite ma non necessarie per questa review:

- architettura tecnica dell'orchestrazione;
- formato definitivo dell'handoff;
- formato definitivo della review;
- trigger GitHub;
- meccanismo di polling o webhook;
- condizioni esatte di merge;
- passaggio automatico alla wave successiva.

Queste informazioni sono già indicate come fuori dal requisito attuale in `requirements/REQ-0001-software-factory.md`.

## Deduzioni utilizzate

| Deduzione | Fatti di partenza | Passaggio logico |
|---|---|---|
| Il flusso desiderato deve essere qualificato come funzionale e non tecnico. | REQ-0001 descrive un flusso in 14 passi; lo stesso documento dichiara fuori ambito architettura, formati, trigger e polling/webhook. | Se un documento contiene sia passi operativi sia esclusioni tecniche, chiarire il livello funzionale evita di trasformare il flusso in una decisione architetturale implicita. |
| Il copia e incolla manuale può essere vietato per i passaggi ripetitivi successivi all'handoff, non come divieto assoluto di ogni azione manuale. | REQ-0001 vieta API ChatGPT e automazioni fragili della UI web; l'utente produce handoff e review tramite ChatGPT web. | Un divieto assoluto potrebbe richiedere automazioni non supportate; limitarlo ai passaggi ripetitivi dopo l'handoff preserva il vincolo originario senza introdurre soluzioni fragili. |
| La conservazione nel repository deve dipendere da tracciabilità, contesto operativo o prosecuzione della wave. | RFC-0001 richiede repository come contesto operativo e una fonte autorevole unica; REQ-0001 richiede conservare requisiti, decisioni, handoff, review e stato del lavoro quando rilevanti. | La rilevanza è verificabile quando l'informazione serve a ricostruire contesto, motivare decisioni o proseguire il lavoro. |
| I criteri di successo devono essere formulati come capacità osservabili. | RFC-0001 richiede verifiche indipendenti con evidenze osservabili; REQ-0001 deve essere pronto per essere proposto come `Active`. | Un requisito proponibile come `Active` deve permettere verifica tramite ispezione, analisi, dimostrazione o test. |

## Checklist RFC-0001

| Verifica | Esito | Evidenza o azione correttiva |
|---|---|---|
| La soluzione soddisfa tutti i requisiti applicabili? | SÌ | Le modifiche riguardano solo `requirements/REQ-0001-software-factory.md` e `reviews/REQ-0001-review.md`, come consentito dal task. |
| Esiste un modo più semplice per ottenere lo stesso risultato? | NO | Sono state precisate sezioni esistenti e creato solo il report richiesto; non sono stati introdotti processi o automazioni. Azione correttiva: nessuna, perché non è stato identificato un approccio più semplice. |
| Ogni complessità introdotta ha una giustificazione verificabile? | SÌ | L'unica nuova sezione, `Ambito`, delimita il requisito per evitare interpretazioni architetturali non approvate. |
| La fattibilità della soluzione è stata verificata? | SÌ | La modifica è documentale e verificabile tramite ispezione del diff e confronto con il task. |
| I fatti utilizzati provengono da fonti verificabili? | SÌ | Fonti usate: `AGENTS.md`, `requirements/REQ-0001-software-factory.md`, `rfcs/RFC-0001-principles.md`, `backlog/decision-review-process.md`, `tasks/WAVE-0001-validate-req-0001.md`. |
| Ogni deduzione cita i fatti e il passaggio logico da cui deriva? | SÌ | Le deduzioni sono elencate nella sezione "Deduzioni utilizzate". |
| Sono presenti ipotesi non dichiarate? | NO | Non sono state usate ipotesi operative oltre alle deduzioni esplicitate. Azione correttiva: nessuna, perché non sono state rilevate ipotesi non dichiarate. |
| Mancano informazioni necessarie per assumere decisioni rilevanti? | NO | Nessuna informazione mancante blocca la review; le informazioni non definite sono già fuori ambito. Azione correttiva: nessuna, perché non risultano informazioni mancanti bloccanti. |
| Le decisioni rilevanti sono tracciabili e contestabili? | SÌ | Ogni osservazione consolidata indica decisione e motivazione verificabile. |
| Ogni informazione operativa ha una sola fonte autorevole? | SÌ | Il requisito resta la fonte del bisogno; il report registra solo l'esito della review richiesta. |
| Sono state introdotte duplicazioni evitabili? | NO | Non sono stati duplicati formati, workflow o condizioni tecniche; sono state precisate formulazioni già presenti. Azione correttiva: nessuna, perché non sono state rilevate duplicazioni evitabili. |
| I documenti interessati hanno uno stato corretto? | SÌ | `REQ-0001` resta `Draft`; questo report è `Draft`. |
| La documentazione attiva rappresenta lo stato corrente del progetto? | NON APPLICABILE | Non risultano documenti con stato `Active` coinvolti nel task. |
| Le verifiche producono evidenze osservabili? | SÌ | Le verifiche finali previste sono ispezione del diff, controllo file modificati e ricerca di dettagli tecnici non approvati. |
