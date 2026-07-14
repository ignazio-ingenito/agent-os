# REQ-0001 – Software Factory per lo sviluppo assistito da AI

**Stato:** Active

## Origine

Questo requisito raccoglie l'esigenza iniziale da cui è nato il progetto.

L'utente utilizza ChatGPT tramite l'interfaccia web, senza API OpenAI, per elaborare handoff e svolgere review. Codex viene invece eseguito nel Developer Workspace e può operare sul repository tramite GitHub.

## Ambito

Questo documento definisce il bisogno da soddisfare, i vincoli e i criteri di successo della Software Factory.

Non definisce l'architettura tecnica, i formati definitivi degli artefatti o i meccanismi di orchestrazione, che devono essere decisi in documenti successivi e coerenti con questo requisito.

## Obiettivo

Realizzare una Software Factory che riduca l'intervento umano ripetitivo nello sviluppo software assistito da AI, mantenendo il controllo umano su:

- definizione del lavoro;
- decisioni rilevanti;
- approvazione finale delle modifiche.

L'automazione deve essere introdotta progressivamente e solo per attività mature, verificabili e realmente implementabili.

## Flusso desiderato

Il flusso seguente descrive il comportamento atteso a livello funzionale. Non prescrive trigger, strumenti di orchestrazione, formati o componenti tecnici specifici.

1. L'utente definisce in ChatGPT una wave di lavoro.
2. ChatGPT produce un handoff strutturato.
3. L'handoff viene salvato nel repository tramite una branch e una Pull Request.
4. Il Developer Workspace rileva la Pull Request.
5. Il Developer Workspace recupera il file di task previsto.
6. Il Developer Workspace avvia Codex sul repository e sulla branch corretti.
7. Codex implementa il task e crea i commit necessari.
8. Vengono eseguite le verifiche automatiche previste dal progetto.
9. ChatGPT esegue la review della Pull Request usando il contesto preparato dal sistema.
10. Se la review richiede modifiche, le osservazioni vengono registrate nella Pull Request.
11. Codex rileva le osservazioni, aggiorna l'implementazione e ripete le verifiche.
12. Il ciclo continua fino all'approvazione.
13. La Pull Request viene integrata quando le verifiche e la review risultano soddisfatte.
14. Se il piano prevede una wave successiva, il sistema prepara il passaggio seguente senza richiedere copia e incolla manuali.

## Vincoli

- ChatGPT non viene invocato tramite API.
- Non deve essere automatizzata in modo non supportato o fragile l'interfaccia web di ChatGPT.
- Il lavoro manuale di copia e incolla tra strumenti deve essere eliminato dai passaggi ripetitivi successivi alla produzione dell'handoff, salvo azioni manuali esplicitamente richieste dal controllo umano.
- Le chat non devono essere usate come memoria permanente del progetto.
- Requisiti, decisioni, handoff, review e stato del lavoro devono essere conservati nel repository quando sono necessari per ricostruire il contesto operativo, motivare una decisione o proseguire una wave successiva.
- Il contesto fornito agli strumenti deve contenere solo le informazioni necessarie e ancora applicabili.
- Codex deve lavorare sulla stessa branch della Pull Request interessata.
- Le verifiche devono produrre evidenze osservabili.
- Le modifiche non approvate non devono essere integrate automaticamente.
- La soluzione deve evitare overengineering, duplicazioni e astrazioni premature.

## Criteri di successo

Il requisito è soddisfatto quando:

- una wave può essere trasformata in una Pull Request contenente l'handoff previsto, senza copia e incolla manuali ripetitivi tra più strumenti dopo la produzione dell'handoff;
- il Developer Workspace può individuare, da una Pull Request, il file di task da eseguire;
- Codex può essere avviato sulla branch della Pull Request interessata;
- Codex può implementare il task e aggiungere aggiornamenti alla stessa Pull Request;
- le verifiche previste dal progetto vengono eseguite e il loro esito viene registrato con evidenze osservabili;
- le osservazioni di review registrate nella Pull Request possono produrre un nuovo ciclo di implementazione sulla stessa branch;
- il merge avviene solo dopo il superamento dei controlli previsti e dell'approvazione richiesta;
- la wave successiva può essere preparata usando il contesto necessario conservato nel repository;
- il processo non dipende dalla lunghezza o dalla persistenza di una singola chat.

## Fuori dal requisito attuale

Questo documento non definisce ancora:

- l'architettura tecnica dell'orchestrazione;
- il formato definitivo dell'handoff;
- il formato definitivo della review;
- i trigger GitHub;
- il meccanismo di polling o webhook;
- le condizioni esatte di merge;
- il passaggio automatico alla wave successiva.

Questi aspetti devono essere definiti successivamente e verificati rispetto a questo requisito e alla RFC-0001.
