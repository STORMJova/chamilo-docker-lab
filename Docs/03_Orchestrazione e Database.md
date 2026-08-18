# 03. Orchestrazione e Database

## 1. Architettura dei Container (Docker Compose)
Il sistema è orchestrato tramite **Docker Compose**, definendo un'infrastruttura multi-container isolata ma interconnessa tramite una rete interna dedicata. Questo garantisce la riproducibilità totale dell'ambiente di esecuzione su qualsiasi macchina host (principio *Out-of-the-Box*).

### Servizi Principali:
* **Web App (`chamilo-app`):** Basata su un'immagine personalizzata (tramite `Dockerfile`) che integra il server web Apache, l'interprete PHP e le estensioni necessarie per l'esecuzione di Chamilo LMS.
* **Database (`chamilo-db`):** Basato sull'immagine ufficiale di **MariaDB**, configurato per gestire la persistenza dei dati e l'inizializzazione automatica dello schema relazionale.

---

## 2. Gestione della Sicurezza e Variabili d'Ambiente
Per evitare l'esposizione di dati sensibili nel controllo di versione (Git), la configurazione delle credenziali sfrutta il pattern delle variabili d'ambiente:
* Il file `.env` (escluso tramite `.gitignore`) contiene le credenziali reali locali.
* Il file `.env.example` viene fornito come modello standard per la configurazione iniziale da parte del valutatore.
* Il file di configurazione interno di Chamilo (`configuration.php`) mappa puntualmente i parametri di connessione (`db_host`, `db_port`, `db_user`, `db_password`) puntando direttamente al nome del servizio di rete del database (`chamilo-db`).

---

## 3. Inizializzazione e Persistenza del Database
Il popolamento iniziale delle tabelle relazionali sfrutta il meccanismo nativo di bootstrap di MariaDB:
* Il file di dump SQL (`init.sql`) viene mappato nella cartella di auto-inizializzazione del container del database.
* **Risoluzione delle criticità di codifica:** Il file `init.sql` è rigorosamente codificato in standard **UTF-8** per prevenire errori di lettura dei caratteri speciali e blocchi nell'importazione dei dati da parte del demone SQL.
* **Persistenza:** Lo storage dei dati relazionali è isolato nel volume Docker dedicato (`db_data/`), escluso dal repository Git per mantenere la leggerezza del codice sorgente e garantire la pulizia dei dati persistenti tra un riavvio e l'altro.