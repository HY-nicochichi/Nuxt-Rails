## Nuxt-Rails
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Docker](https://img.shields.io/badge/docker-blue.svg?style=flat&logo=docker&logoColor=white)](https://www.docker.com/)

Nuxt + Rails user auth application  
  
Nuxt: SPA(Composition API & TS, CDN Bootstrap, Pinia state management, unit test)  
http://localhost:8080  
Rails: REST-API(JWT, CORS, ORM, schema validation, unit test, Swagger UI)  
http://localhost:3000  

## How to Run
STEP1: Prepare ./database.env & ./backend.env
```
# ./database.env
POSTGRES_USER="user"
POSTGRES_PASSWORD="password"
POSTGRES_DB="db"
```
```
# ./backend.env
SECRET_KEY_BASE="secret"
DATABASE_URL="postgresql://user:password@database:5432/db"
```
STEP2: Run `$ docker compose up -d --build`
