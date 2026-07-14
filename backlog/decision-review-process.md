# Decision Review Process

**Stato:** Da validare

## Obiettivo

Verificare se il processo di review usato per RFC-0001 è sufficientemente generale da poter essere applicato anche ad altri artefatti decisionali, in particolare:

- analisi funzionali;
- decisioni di prodotto;
- RFC;
- decisioni architetturali;
- workflow;
- istruzioni operative;
- prompt strategici.

Il processo NON costituisce ancora uno standard del progetto.

Deve essere formalizzato solo dopo essere stato applicato con successo ad almeno un secondo caso d'uso reale senza richiedere modifiche sostanziali.

## Sequenza di lenti usata per RFC-0001

Questa sequenza viene conservata esclusivamente per poterla riutilizzare durante la validazione:

1. **Challenge Me**  
   Cerca contraddizioni, casi limite, assunzioni implicite e conseguenze indesiderate.

2. **Critique**  
   Cerca ambiguità, debolezze, incoerenze e punti tecnicamente migliorabili.

3. **Review**  
   Valuta coerenza, completezza, struttura e qualità complessiva dell'artefatto.

4. **Operationalize**  
   Verifica che principi, requisiti e decisioni siano traducibili in controlli oggettivi, con evidenze osservabili.

5. **Minimalism Review**  
   Cerca elementi eliminabili, duplicazioni, ridondanze e complessità non necessaria.

6. **Legal / Precision Review**  
   Verifica precisione terminologica, linguaggio normativo, coerenza degli obblighi e assenza di interpretazioni multiple.

## Modalità di applicazione

Le lenti devono essere applicate in sequenza.

Ogni lente deve distinguere:

- errori o non conformità;
- miglioramenti utili;
- suggerimenti facoltativi.

Le osservazioni non devono essere applicate automaticamente.

## Output della review

La review deve produrre una tabella decisionale:

| Osservazione | Decisione | Motivazione |
|---|---|---|
| Descrizione dell'osservazione | Accolta / Rifiutata / Rimandata | Motivo della decisione |

La decisione finale rimane umana fino a quando il processo non sarà stato validato e formalizzato.

## Criterio di validazione

Il processo può essere proposto come standard solo quando:

- è stato applicato ad almeno un secondo caso d'uso reale;
- non ha richiesto nuove lenti o modifiche sostanziali alla sequenza;
- ha prodotto osservazioni utili e non prevalentemente ridondanti;
- il costo della review è risultato proporzionato al valore dell'artefatto;
- l'output ha consentito decisioni tracciabili e contestabili.

Fino ad allora, questo documento resta una nota di backlog e non costituisce una regola operativa.
