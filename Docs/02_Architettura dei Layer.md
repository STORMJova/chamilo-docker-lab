## 2. Architettura dei Layer (Analisi del Dockerfile)

Il `Dockerfile` è stato progettato applicando i principi di efficienza e stratificazione dei layer (layer caching) tipici degli ambienti cloud di produzione. Di seguito viene riportata l'analisi ingegneristica delle istruzioni adottate:

* **Immagine di Base e Dipendenze di Sistema:** Si parte da `php:7.4-apache`. I test preliminari condotti con PHP 8.1/8.2 hanno evidenziato incompatibilità bloccanti e conflitti insuperabili nel dependency manager. L'ambiente viene aggiornato per installare librerie grafiche (es. `libpng-dev`, `libjpeg-dev`) indispensabili per la manipolazione di media didattici e avatar degli utenti, oltre a `git` e `unzip` per la pipeline di download.
* **Ottimizzazione PHP ed Estensioni Core:** Le piattaforme LMS gestiscono file di grandi dimensioni e query massive. Le impostazioni standard sono state sovrascritte tramite un file `.ini` personalizzato (`chamilo-optimizations.ini`):
  * `memory_limit = 512M`: Per prevenire crash durante l'elaborazione di report e moduli SCORM pesanti.
  * `max_execution_time = 300`: Estensione del timeout per consentire l'esecuzione di script di installazione lunghi.
  * `upload_max_filesize` e `post_max_size` a `100M`: Indispensabili per permettere il caricamento di video e dispense docenti.
* **Multi-Stage Build per Composer e Codice Sorgente:** Per mantenere l'immagine leggera, viene impiegato un pattern multi-stage copiando l'eseguibile di `composer` direttamente dall'immagine Docker ufficiale (`COPY --from=composer:latest`). Il codice sorgente viene poi clonato direttamente dal branch stabile 1.11.x tramite Git.
* **Dependency Management:** Il comando `composer install --no-dev --optimize-autoloader` risolve tutte le dipendenze software escludendo i pacchetti di sviluppo e ottimizzando l'autoloader per massimizzare le performance.
* **Permessi Sicuri:** Infine, l'intera directory `/var/www/html/` viene assegnata all'utente di sistema `www-data` (il processo Apache) con permessi `755` per garantire la corretta scrittura dei file di cache e configurazione interni senza generare errori.