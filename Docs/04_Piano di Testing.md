# 04. Piano di Testing e Validazione Ingegneristica

In conformità con le specifiche richieste per validare la stabilità dell'ambiente "out-of-the-box", sono stati formalizzati ed eseguiti i seguenti test operativi:

| Fase di Test | Obiettivo del Test | Metodologia Applicata | Esito del Test |
| :--- | :--- | :--- | :--- |
| **Build Isolata & Dependency Resolution** | Garantire la corretta compilazione delle estensioni PHP e l'integrità dei pacchetti installati da Composer. | Esecuzione del comando `docker compose build --no-cache` per forzare la riesecuzione di tutti i layer. | ✅ **Superato** (Risolto blocco iniziale dovuto a PHP 8.1 grazie al downgrade mirato a PHP 7.4). |
| **Orchestrazione & Connettività di Rete** | Accertarsi che il container applicativo comunichi con il database MariaDB sfruttando il DNS interno di Docker. | Ispezione dei log interni tramite `docker logs` ed esecuzione di test di connettività verso l'host `chamilo-db`. | ✅ **Superato** (I container si avviano nella sequenza corretta rispettando la direttiva `depends_on`). |
| **Verifica Out-of-the-Box (Sanity Check)** | Verificare che l'applicazione web risponda sulla porta esposta senza generare eccezioni o errori HTTP 500. | Richiesta HTTP via browser all'indirizzo `http://localhost:8080` immediatamente dopo lo startup. | ✅ **Superato** (Il server Apache risponde mostrando il wizard grafico di Chamilo). |
| **Persistenza dello Stato dei Dati** | Garantire che i dati inseriti nel database non siano volatili e sopravvivano al ciclo di vita dei container. | Esecuzione della sequenza distruttiva `docker compose down` seguita da un riavvio tramite `docker compose up -d`. | ✅ **Superato** (Il volume nominale `db_data` preserva intatta l'alberatura del database relazionale). |