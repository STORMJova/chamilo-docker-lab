## 1. Obiettivo del Progetto e Scelta del Software

L'obiettivo del progetto è la containerizzazione di una piattaforma web complessa con annesso database, per garantire un deploy "out-of-the-box" tramite Docker e Docker Compose.

Il software selezionato è **Chamilo LMS** (v1.11.x stabile). A differenza di altre opzioni (come ZWS, che usa un'architettura a microservizi divisa tra API, Web e Migrator), Chamilo adotta un'architettura monolitica classica (LAMP). Questo permette di racchiudere tutta la logica applicativa in un singolo `Dockerfile` altamente ottimizzato, affiancandogli un container separato per il database relazionale (MariaDB). È il caso d'uso perfetto per dimostrare l'efficacia dell'orchestrazione cloud.