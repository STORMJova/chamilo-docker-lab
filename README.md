# ☁️ Progetto Laboratorio Cloud - Chamilo LMS

![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![PHP](https://img.shields.io/badge/php-%23777BB4.svg?style=for-the-badge&logo=php&logoColor=white)
![MariaDB](https://img.shields.io/badge/MariaDB-003545?style=for-the-badge&logo=mariadb&logoColor=white)
[![Docker Hub](https://img.shields.io/badge/Docker_Hub-jovaxxiii%2Fchamilo_cloud_lab-blue?style=for-the-badge&logo=docker)](https://hub.docker.com/r/jovaxxiii/chamilo-cloud-lab)

Benvenuto nella repository del progetto per il corso di Laboratorio Cloud.

L'obiettivo di questo progetto è la containerizzazione di **Chamilo LMS** (software open-source per l'e-learning) basata su architettura LAMP e il deploy di un ambiente completo, orchestrato e funzionante *out-of-the-box*.

## 🎯 Task del Progetto Completati
- [x] Scelta del software (Chamilo LMS).
- [x] Creazione del `Dockerfile` customizzato con ottimizzazioni PHP.
- [x] Creazione del `docker-compose.yml` per l'orchestrazione con il Database.
- [x] Test di connettività, persistenza e funzionamento dell'ambiente.
- [x] Pubblicazione dell'immagine ufficiale su **Docker Hub**.

## 🛠️ Architettura e Stack
* **Applicativo:** [Chamilo LMS](https://github.com/chamilo/chamilo-lms) (v1.11.x)
* **Base Image Docker:** `php:7.4-apache`
* **Database:** `mariadb:10.11`

## 🚀 Quick Start (Avvio Rapido)

L'immagine è già compilata e distribuita pubblicamente. Per avviare l'infrastruttura è sufficiente utilizzare i due file operativi (`docker-compose.yml` e `init.sql`) forniti in sede di consegna.

1. Posizionarsi nella directory contenente i due file.
2. Avviare l'orchestrazione tramite terminale:
   ```bash
   docker compose up -d

## 📚 Documentazione Tecnica

Tutti i dettagli sull'architettura, le scelte implementative e i protocolli di sicurezza adottati in questo progetto universitario sono consultabili nella cartella dedicata.

👉 **[Esplora la cartella della Documentazione](./Docs)**