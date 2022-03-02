#!/bin/bash

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
cat homepage.template > {{cookiecutter.app_name}}/views.py

echo "Run migrations"
python manage.py migrate

echo "Load the admin interface themes"
python manage.py loaddata admin_interface_themes.json

echo "Initial Git Repo"
git init