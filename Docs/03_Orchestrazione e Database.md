## 3. Orchestrazione (Docker Compose)

Il progetto utilizza `docker-compose.yml` per orchestrare il container web insieme a **MariaDB 10.11**. 
I due servizi comunicano tramite la rete virtuale interna di Docker. Per garantire la sicurezza e la persistenza dei dati accademici (corsi, utenti) anche in caso di distruzione dei container, è stato configurato un **volume logico** (`db_data`) che mappa la directory interna di MySQL sull'host.