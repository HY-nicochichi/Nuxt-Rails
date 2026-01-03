## Nuxt-Rails
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
```
```
# ./backend.env
JWT_SECRET_KEY="secret"
DATABASE_USER="user"
DATABASE_PASSWORD="password"
```
STEP2: Run `$ docker compose up -d --build`
