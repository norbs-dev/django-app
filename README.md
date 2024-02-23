Just a quick example of how to deploy a Django app with Docker and Docker compose.

## Pre requisites
- Docker
- Docker compose

## Development
### Envioroment variavbles
Create a `dontenv_files` folder at root of the repo and then create a `.env` file with the following variables:
```
SECRET_KEY=""
DEBUG=""
ALLOWED_HOSTS=""
DB_ENGINE=""
POSTGRES_DB=""
POSTGRES_USER=""
POSTGRES_PASSWORD=""
POSTGRES_HOST=""
POSTGRES_PORT=""
```

### Start app
`docker-compose up -d`
