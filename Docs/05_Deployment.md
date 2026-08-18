## 🚀 Guida al Deploy

L'immagine ufficiale di questo progetto è stata pubblicata su **Docker Hub**. Non è necessaria alcuna compilazione locale dei file sorgenti.

Per avviare l'ambiente completo "out-of-the-box", è sufficiente creare un file `docker-compose.yml` sul proprio PC con il seguente contenuto:

```yaml
version: '3.8'

services:
  chamilo-app:
    build: .
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
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: ${MYSQL_DATABASE}
      MYSQL_USER: ${MYSQL_USER}
      MYSQL_PASSWORD: ${MYSQL_PASSWORD}
    volumes:
      - db_data:/var/lib/mysql
      - ./init.sql:/docker-entrypoint-initdb.d/init.sql

volumes:
  db_data:
```
Quindi lanciare il comando:

```bash
    docker compose up -d
```