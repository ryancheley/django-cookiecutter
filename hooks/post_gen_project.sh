#!/bin/bash

if [ "{{cookiecutter.sql_database}}" = "Postgres" ]; then
    if psql -lqt | cut -d\| -f 1 | grep -qw {{cookiecutter.database_name}}; then
        echo "The database '{{cookiecutter.database_name}}' already exists."
        echo "No project creation to be done"
        echo "Your directory will rollback to it's previous state"

        cd ..
        rm -rf core
        exit
    else
        echo -e "Creating new Postgres Database {{cookiecutter.database_name}}"

        psql -c "CREATE DATABASE {{cookiecutter.database_name}}"
        psql -c "CREATE USER {{cookiecutter.database_username}} WITH PASSWORD '{{cookiecutter.database_password}}'"
        psql -c "ALTER ROLE {{cookiecutter.database_username}} SET client_encoding TO 'utf8'"
        psql -c "ALTER ROLE {{cookiecutter.database_username}} SET default_transaction_isolation TO 'read committed'"
        psql -c "ALTER ROLE {{cookiecutter.database_username}} SET timezone TO 'UTC'"
        
        echo "Database {{cookiecutter.database_name}} created"
    fi
fi

echo "Rename the example .env file"
mv {{cookiecutter.project_slug}}/.example_env {{cookiecutter.project_slug}}/.env
mv {{cookiecutter.project_slug}}/.prod_example_env {{cookiecutter.project_slug}}/.env_prod

echo "Make the staticfiles directory"
mkdir staticfiles

echo "Install requirements"
pip install -U pip
pip install -r requirements.txt

echo "create your first app"
python manage.py startapp {{cookiecutter.app_name}}
cat urls.template > {{cookiecutter.app_name}}/urls.py
rm urls.template
cat homepage.template > {{cookiecutter.app_name}}/views.py
rm homepage.template

echo "Run migrations"
python manage.py migrate

echo "Load the admin interface themes"
python manage.py loaddata admin_interface_themes.json

echo "Initial Git Repo"
git init