# Rails on Docker

A simple setup to get you started with rails development on docker.

## Get Started

- Clone repo.
- Cd into the repo directory.
- Run `docker-compose up --build`
To generate a new rails project run.
- Run `docker-compose run --user $(id -u):$(id -g) web rails new . --force --database=postgresql --skip-bundle --no-deps --database=postgresql`.

To link the services and only expose the web app's port to users. I used docker-compose.yml.

- Head over to `config/database.yml` and edit it to have the following.
    ```yml
        default: &default
        adapter: postgresql
        encoding: unicode
        host: db
        username: postgres
        password:
        pool: 5

        development:
        <<: *default
        database: myapp_development

        test:
        <<: *default
        database: myapp_test
    ```

Since the new rails project has populated the gemfile, shut down the services and build the images again.

- Run `docker-compose down`
  
- Run `docker-compose up --build` to boot up the app.
- navigate to http://localhost:3000

ActiveRecord: NoDatabaseError?
Create the database.
In a different terminal;

- Run `docker-compose exec app rails db:create`

## Notes

1. To stop the application:
   `docker-compose down`
2. To restrat the application:
   `docker-compose up`
3. To rebuild the application:
   `docker-compose up --build`

## Permissions