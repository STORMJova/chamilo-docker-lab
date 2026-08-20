# 03. Orchestrazione e Database

## 1. Architettura dei Container (Docker Compose)
Il sistema è orchestrato tramite **Docker Compose**, che isola lo strato applicativo da quello dei dati strutturando una rete virtuale interna privata. Questo approccio garantisce la riproducibilità totale dell'ambiente di esecuzione su qualsiasi macchina host, rispettando rigorosamente il principio del deploy *Out-of-the-Box*.

### Servizi Principali:
* **Web App (`chamilo-app`):** Basata sull'immagine personalizzata (compilata tramite `Dockerfile`) che integra il server web Apache, l'interprete PHP e le estensioni necessarie per l'esecuzione di Chamilo LMS. Comunica con il database sfruttando la risoluzione DNS interna di Docker.
* **Database (`chamilo-db`):** Basato sull'immagine ufficiale **MariaDB 10.11**, pienamente compatibile con Chamilo, configurata per gestire la persistenza e l'inizializzazione automatica dello schema relazionale.

---

## 2. Gestione della Sicurezza e Connettività
Durante l'ingegnerizzazione, la configurazione ha adottato il pattern delle variabili d'ambiente per isolare i dati sensibili dal controllo di versione:
* Il file `.env` (escluso tramite `.gitignore`) ha gestito in sicurezza le credenziali di sviluppo.
* Il file di configurazione interno di Chamilo (`configuration.php`) è stato sincronizzato per mappare i parametri di connessione (`db_host`, `db_user`, `db_password`) puntando direttamente al nome host del servizio database (`chamilo-db`). Questo allineamento ha risolto criticità architetturali, prevenendo loop infiniti di tentativi di connessione e conseguenti saturazioni di memoria (memory leak).
* *Nota per il Deployment Finale:* Al fine di soddisfare la richiesta di avvio immediato con un singolo comando, il file `docker-compose.yml` distribuito per la valutazione incorpora le variabili di test essenziali.

---

## 3. Inizializzazione e Persistenza del Database
Il popolamento iniziale delle tabelle relazionali sfrutta il meccanismo nativo di bootstrap di MariaDB:
* Il file di dump SQL (`init.sql`) viene mappato nella cartella di auto-inizializzazione del container del database.
* **Risoluzione delle criticità di codifica:** Il file `init.sql` è rigorosamente codificato in standard **UTF-8** per prevenire errori di lettura dei caratteri speciali e blocchi irreversibili nell'importazione da parte del demone SQL.
* **Persistenza:** Lo storage dei dati relazionali è isolato e garantito dal volume logico Docker dedicato `db_data` (legato alla directory nativa `/var/lib/mysql`). Questo assicura che lo spegnimento o la distruzione dei container non comporti la perdita degli utenti e dei corsi creati.