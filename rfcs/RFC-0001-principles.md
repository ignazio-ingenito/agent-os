# RFC-0001 – Principi fondanti della Software Factory

**Stato:** Draft  
**Versione:** 0.1.0  
**Ultima modifica:** 2026-07-14

## Scopo

Questa RFC definisce i principi che governano le decisioni progettuali, implementative e documentali della Software Factory.

I principi si applicano alla Software Factory stessa e agli artefatti prodotti attraverso di essa.

## Definizione

Una **fonte autorevole** è la fonte designata dal progetto come riferimento ufficiale per una determinata informazione.

---

## 1. Semplicità e proporzionalità

La scelta predefinita DEVE essere la soluzione più semplice che soddisfa tutti i requisiti applicabili.

Qualsiasi complessità aggiuntiva DEVE:

- rispondere a un requisito identificabile;
- produrre un beneficio verificabile;
- non poter essere sostituita da una soluzione più semplice con risultati equivalenti.

Prima di aggiungere un componente, un'automazione, un'astrazione, una regola o un documento, si DEVE verificare:

1. Esiste un modo più semplice per ottenere lo stesso risultato?
2. È possibile eliminare o riutilizzare qualcosa invece di aggiungere?
3. Il beneficio giustifica i costi di implementazione, manutenzione, test e documentazione?

La complessità priva di una giustificazione verificabile è overengineering e NON DEVE essere introdotta.

---

## 2. Implementabilità

Devono essere proposte esclusivamente soluzioni realizzabili con gli strumenti, le risorse e le informazioni effettivamente disponibili.

Una proposta NON DEVE essere presentata come soluzione confermata quando la sua fattibilità non è stata verificata.

Quando la fattibilità dipende da una condizione non verificata, tale condizione DEVE essere dichiarata esplicitamente prima di procedere.

---

## 3. Fatti, deduzioni e informazioni mancanti

Ogni affermazione usata per prendere una decisione DEVE essere classificabile come fatto, deduzione o informazione mancante.

### 3.1 Fatto

Un fatto è un'informazione presente:

- nella documentazione autorevole e attiva del progetto;
- nel codice o nella configurazione verificati;
- in una fonte esterna identificabile e verificata.

La fonte DEVE essere indicata quando non è già evidente dal contesto.

### 3.2 Deduzione

Una deduzione è ammessa esclusivamente quando è chiaramente e logicamente derivabile da fatti disponibili.

Ogni deduzione DEVE:

- indicare i fatti da cui deriva;
- rendere esplicito il passaggio logico;
- non dipendere da ipotesi non dichiarate.

Se sono possibili più interpretazioni ragionevoli, la conclusione NON DEVE essere trattata come deduzione certa.

### 3.3 Informazione mancante

Un'informazione è mancante quando i fatti disponibili non consentono di procedere correttamente o di scegliere tra più alternative rilevanti.

In questo caso:

- non si DEVE inventare;
- non si DEVE interpolare;
- non si DEVE presentare un'ipotesi come fatto;
- si DEVE identificare l'informazione necessaria;
- si DEVE richiedere tale informazione prima di assumere una decisione che ne dipende.

La mancanza di informazioni non rilevanti per il task NON DEVE bloccare il lavoro.

---

## 4. Tracciabilità e contestabilità

Ogni decisione rilevante DEVE poter essere ricondotta a:

- un requisito;
- un vincolo verificato;
- una decisione progettuale già attiva;
- oppure una deduzione conforme al principio precedente.

Una decisione è rilevante quando modifica almeno uno dei seguenti elementi:

- comportamento richiesto;
- architettura;
- interfacce;
- sicurezza;
- dati persistenti;
- dipendenze;
- operatività;
- manutenzione futura;
- documentazione autorevole.

Per ogni decisione rilevante DEVE essere possibile rispondere:

1. Quale problema o requisito affronta?
2. Su quali fatti si basa?
3. Esiste una soluzione più semplice?
4. Quale beneficio giustifica la scelta?
5. Quali artefatti devono essere aggiornati?

Una decisione che non supera queste verifiche DEVE essere modificata o scartata.

---

## 5. Repository come contesto operativo

Il repository è la fonte autorevole dello stato corrente del progetto.

Ogni informazione operativa DEVE avere un solo punto autorevole. Eventuali riferimenti DEVONO rimandare a tale fonte senza duplicarne il contenuto.

Ogni documento governato da questa RFC DEVE avere uno dei seguenti stati:

- `Draft`: in elaborazione e non ancora vincolante;
- `Active`: approvato e applicabile al lavoro corrente;
- `Archived`: non più applicabile al lavoro corrente.

Gli esecutori DEVONO usare per impostazione predefinita solo i documenti `Active`.

I documenti `Archived` POSSONO essere consultati per ricostruire una decisione o comprendere il contesto storico, ma NON DEVONO essere trattati come istruzioni operative.

Quando una modifica rende inesatta o superata una fonte autorevole, la stessa modifica DEVE:

- aggiornarla;
- sostituirla indicando la nuova fonte;
- oppure archiviarla.

Un nuovo documento NON DEVE essere creato quando un documento attivo può contenere l'informazione senza perdere chiarezza o coerenza.

---

## 6. Verificabilità operativa

Ogni principio, requisito o regola operativa DEVE poter essere verificato in modo indipendente tramite almeno uno dei seguenti metodi:

- ispezione;
- analisi;
- dimostrazione;
- test.

Ogni verifica DEVE produrre uno dei seguenti esiti:

- `SÌ`;
- `NO`;
- `NON APPLICABILE`.

L'esito DEVE essere accompagnato da un'evidenza o da una motivazione verificabile.

Un esito `NO` DEVE indicare l'azione correttiva necessaria.

Un artefatto che non supera una verifica obbligatoria NON PUÒ diventare `Active` finché la non conformità non viene corretta oppure viene approvata una deroga esplicitamente motivata.

Un principio che non può essere verificato DEVE essere chiarito o riscritto prima di diventare `Active`.

---

## Checklist obbligatoria

Prima di considerare completato un lavoro, verificare:

| Verifica | Esito | Evidenza o azione correttiva |
|---|---|---|
| La soluzione soddisfa tutti i requisiti applicabili? |  |  |
| Esiste un modo più semplice per ottenere lo stesso risultato? |  |  |
| Ogni complessità introdotta ha una giustificazione verificabile? |  |  |
| La fattibilità della soluzione è stata verificata? |  |  |
| I fatti utilizzati provengono da fonti verificabili? |  |  |
| Ogni deduzione cita i fatti e il passaggio logico da cui deriva? |  |  |
| Sono presenti ipotesi non dichiarate? |  |  |
| Mancano informazioni necessarie per assumere decisioni rilevanti? |  |  |
| Le decisioni rilevanti sono tracciabili e contestabili? |  |  |
| Ogni informazione operativa ha una sola fonte autorevole? |  |  |
| Sono state introdotte duplicazioni evitabili? |  |  |
| I documenti interessati hanno uno stato corretto? |  |  |
| La documentazione attiva rappresenta lo stato corrente del progetto? |  |  |
| Le verifiche producono evidenze osservabili? |  |  |
