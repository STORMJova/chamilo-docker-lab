# 05. Guida al Deploy Finale

Come espressamente richiesto dalla consegna, l'immagine finale è stata compilata, taggata e pubblicata nel registro pubblico di Docker Hub. Questo consente al docente di testare l'infrastruttura completa "out-of-the-box" eseguendo un singolo comando, senza la necessità di possedere i file sorgenti del codice o rieseguire lunghe fasi di build locali.

## 1. Prerequisiti
Per avviare l'ambiente completo, è sufficiente posizionare all'interno di una singola cartella i seguenti due file (forniti in sede di consegna):
* Il file `docker-compose.yml`
* Il file `init.sql` (indispensabile per il bootstrap automatico del database)

## 2. File di Orchestrazione
Il file `docker-compose.yml` finale che il docente dovrà utilizzare per il pull immediato è strutturato come segue (l'istruzione di compilazione locale viene sostituita dall'immagine remota distribuita su Docker Hub):

```yaml
version: '3.8'

services:
  chamilo-app:
    image: jovaxxiii/chamilo-cloud-lab:latest
    container_name: chamilo_web_app
    ports:
      - "8080:80"
    environment:
      - DB_HOST=chamilo-db
    depends_on:
      - chamilo-db
    restart: always

  chamilo-db:
    image: mariadb:10.11
    container_name: chamilo_database
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: root_password
      MYSQL_DATABASE: chamilo_db
      MYSQL_USER: chamilo_user
      MYSQL_PASSWORD: chamilo_pass
    volumes:
      - db_data:/var/lib/mysql
      - ./init.sql:/docker-entrypoint-initdb.d/init.sql

volumes:
  db_data:
```
Quindi lanciare il comando:

```bash
    docker compose up -d --build
```