## 2. Architettura dei Layer (Analisi del Dockerfile)

Il `Dockerfile` è stato strutturato applicando i principi di *layer caching* per massimizzare l'efficienza. Ecco le scelte ingegneristiche principali:

* **Base Image & Dipendenze:** Si parte da `php:7.4-apache`. Chamilo 1.11.x richiede specificamente PHP 7.4 per evitare conflitti di dipendenze (errori 500) causati da versioni più recenti. Vengono installate librerie di sistema (es. `libpng-dev`, `libzip-dev`) necessarie a PHP per manipolare immagini e archivi.
* **Ottimizzazione PHP:** Tramite l'iniezione di un file `.ini` personalizzato, sono state ampliate le risorse (es. `memory_limit = 512M`, `upload_max_filesize = 100M`) fondamentali per un LMS che deve gestire caricamenti di file video e dispense.
* **Multi-Stage Build per Composer:** L'eseguibile di `composer` viene copiato direttamente dall'immagine ufficiale (`COPY --from=composer:latest`), evitando lunghe installazioni manuali.
* **Dependency Management:** Il comando `composer install --no-dev` scarica solo le librerie di produzione, mantenendo l'immagine leggera.
* **Permessi Sicuri:** L'intera cartella `/var/www/html` viene assegnata all'utente `www-data` per consentire ad Apache di scrivere i log e i file di configurazione senza errori di permessi.