# AGENTS

## Regola generale di governo

Le istruzioni di questo file sono vincolanti per ogni wave, task o decisione eseguita in questo repository e non possono essere bypassate, salvo autorizzazione esplicita.

## Fonte normativa autorevole

La fonte normativa primaria è:

- https://github.com/ignazio-ingenito/agent-os/blob/main/rfcs/RFC-0001-principles.md

Il contenuto completo di questa RFC non deve essere duplicato nel repository locale.

## Regole operative e lifecycle degli artefatti

1. `AGENTS.md` definisce le regole operative e il modello documentale minimo.
2. `docs/README.md` funge da indice di riferimento.
3. `docs/execution/README.md` è il puntatore operativo all’attività esecutiva corrente.
4. Se un documento non è più operativo, viene archiviato solo quando esiste un contenuto reale da spostare.
5. Nessuna directory o regola documentale deve essere introdotta senza un requisito operativo concreto.
6. Le informazioni operative devono avere un unico punto autorevole in questo set, evitando duplicazioni.

## Governo del lavoro attivo

1. Il lavoro attivo si individua solo tramite `docs/execution/README.md`. Quando `status: none`, governa la fonte esplicita indicata nel task corrente. Non si deduce da nome, data o ultima modifica.
2. Una wave `Draft` non autorizza l’esecuzione. Una wave `Active` autorizza solo obiettivo, scope, non-obiettivi, verifiche e condizioni di stop dichiarati nella wave.
3. Non possono essere eseguite più wave incompatibili nello stesso momento. Quando non esiste una wave attiva, governa la fonte esplicita del lavoro corrente.
4. L’autorità della wave cessa alla chiusura. L’integrazione finale resta soggetta all’approvazione richiesta e alle regole di merge applicabili.

## Arresto e prosecuzione

Fermarsi solo quando il lavoro richiede una decisione non documentata, supera lo scope approvato, viola una fonte attiva, comporta conseguenze rilevanti non valutate oppure richiede una verifica obbligatoria che resta ineseguibile dopo ragionevoli tentativi.

Prima di fermarsi, indicare condizione applicabile, fatto osservato e decisione o informazione necessaria.

Non fermarsi per passaggi già approvati, errori locali correggibili, verifiche risolvibili entro lo scope, stato documentale correggibile in modo univoco o fallback già autorizzati. Dati, schema, contratti, dipendenze e architettura non sono stop automatici quando rientrano nello scope approvato.

## Controlli proporzionali

| Tipo di modifica | Controllo minimo |
|---|---|
| Locale, secondo pattern esistente | Ispezione mirata, modifica minima, test pertinenti, review di correttezza e semplificazione. |
| Comportamento o requisito | Confronto con la fonte autorevole. |
| Contratto, API, dati o comportamento condiviso | Analisi di definizioni, riferimenti e impatto. |
| Dipendenza, runtime, generatore o tooling | Necessità, documentazione corrente e fattibilità. |
| Confine architetturale | Conformità alle decisioni applicabili. |
| Decisione difficile da invertire | Decisione durevole esplicita prima dell’implementazione. |

Non rendere obbligatori per ogni modifica nuovi documenti, nuove RFC, pianificazione aggiuntiva, rilettura completa del repository o review non pertinenti.

## Review e chiusura

1. Ogni review deve indicare la revisione esaminata. Se modifiche successive cambiano materialmente la superficie valutata, riesaminare la parte interessata e ripetere le verifiche pertinenti.
2. Alla chiusura della wave, quando applicabile, aggiornare le fonti rese inesatte, registrare una sola volta i fatti durevoli, archiviare gli artefatti esecutivi conclusi, aggiornare lo stato del lavoro attivo, rimuovere istruzioni obsolete e separare lavoro futuro da decisioni ancora aperte.
3. Non archiviare requisiti, decisioni o comportamenti durevoli solo perché la wave è terminata.

## Lingua e qualità editoriale

1. Tutti i testi destinati alla lettura umana devono essere scritti in italiano: wave, piani, issue, pull request, commenti, review, report, checklist, richieste di approvazione e spiegazioni di errori, rischi o blocchi.
2. Restano nella forma originale quando la traduzione riduce precisione o tracciabilità: codice, identificatori, funzioni, tipi, API, comandi, percorsi, nomi di file, output, messaggi di errore e termini tecnici consolidati come `commit`, `branch`, `pull request`, `issue`, `merge`, `build`, `runtime` e `API`.
3. Prima della pubblicazione, ogni testo umano deve passare una revisione tecnica: distingue fatti, deduzioni, decisioni, rischi e azioni; chiarisce cosa cambia o viene richiesto; indica come verificare il risultato; elimina ripetizioni e gergo inutile; non introduce affermazioni non supportate; conserva requisiti, contratti, vincoli e condizioni di stop.
4. Dopo la revisione tecnica, applicare `humanize-writing` quando disponibile. Se non può essere invocata, applicarne manualmente i criteri: eliminare formule da LLM, tono promozionale, enfasi, riempitivi, strutture ripetitive e conclusioni generiche; usare parole concrete; condensare preferendo eliminare ripetizioni e contenuti duplicati, invece di riassumere o fondere concetti distinti, senza perdere fatti, decisioni, vincoli, riferimenti, condizioni o significato tecnico.
5. Il controllo finale verifica che il testo non sia ulteriormente accorciabile senza perdere informazioni utili, che fatti, decisioni, azioni, vincoli e verifiche restino espliciti, e che la sintesi non trasformi deduzioni, incertezze o limiti in affermazioni certe.
6. Il template non è la fonte autorevole. Issue, wave, pull request, report e review devono rimandare alle fonti autorevoli senza duplicarne il contenuto.
