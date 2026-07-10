## 4. Piano di Testing e Validazione

Per garantire la stabilità dell'ambiente, sono stati eseguiti con successo i seguenti test operativi:

| Fase di Test | Obiettivo | Metodologia | Esito |
| :--- | :--- | :--- | :--- |
| **Build Isolata** | Verifica risoluzione dipendenze Composer e compilazione estensioni PHP. | Esecuzione di `docker compose build --no-cache`. | ✅ Superato |
| **Connettività Rete** | Verifica comunicazione tra App e Database. | Ispezione log e risoluzione DNS interno (`depends_on`). | ✅ Superato |
| **Out-of-the-Box** | Verifica avvio pulito senza errori 500. | Richiesta HTTP a `http://localhost:8080` post-startup. | ✅ Superato |
| **Persistenza Dati** | Sopravvivenza del database ai riavvii. | Esecuzione `docker compose down -v` simulato e riavvio. | ✅ Superato |