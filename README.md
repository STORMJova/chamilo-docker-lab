# ☁️ Progetto Laboratorio Cloud - Chamilo LMS

![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![PHP](https://img.shields.io/badge/php-%23777BB4.svg?style=for-the-badge&logo=php&logoColor=white)
![MariaDB](https://img.shields.io/badge/MariaDB-003545?style=for-the-badge&logo=mariadb&logoColor=white)

Benvenuto nella repository del progetto per il corso di Laboratorio Cloud.

L'obiettivo di questo progetto è la creazione di un'immagine Docker personalizzata per **Chamilo LMS** (software open-source per l'e-learning) e il deploy di un ambiente completo e funzionante *out-of-the-box*.

## 🎯 Task del Progetto
- [x] Scelta del software (Chamilo LMS).
- [x] Creazione del `Dockerfile` customizzato.
- [x] Creazione del `docker-compose.yml` per l'orchestrazione con il Database.
- [x] Test di funzionamento dell'ambiente.
- [ ] Pubblicazione dell'immagine ufficiale su **Docker Hub**.

## 🛠️ Architettura e Stack
* **Applicativo:** [Chamilo LMS](https://github.com/chamilo/chamilo-lms)
* **Base Image Docker:** `php:7.4-apache`
* **Database:** `mariadb:10.11`

## 📚 Documentazione Tecnica

Tutti i dettagli sull'architettura, le scelte implementative e i protocolli di sicurezza adottati in questo progetto universitario sono consultabili nella cartella dedicata.

👉 **[Esplora la cartella della Documentazione](./Docs)**