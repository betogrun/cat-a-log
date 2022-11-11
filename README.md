# Cat-a-log

Simple CRUD application to manage cats using the [u-case](https://github.com/serradura/u-case) gem.

### Getting started

Follow the steps below to get a development environment running

Clone the project
```
git clone git@github.com:betogrun/cat-a-log.git && cd cat-a-log
```

Create the database and run the migrations

```
docker-compose run --rm web bundle exec rails db:create db:migrate db:seed
```

### Running
```
docker-compose up
```

## Debugging

Get the web container id

```
docker ps
```

Attach your terminal to the container

```
docker attach container_id
```
