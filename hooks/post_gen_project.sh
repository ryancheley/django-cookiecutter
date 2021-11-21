#!/bin/bash
echo "Rename the example .env file"
mv {{cookiecutter.project_slug}}/.example_env {{cookiecutter.project_slug}}/.env

mkdir staticfiles

python3 -m venv venv

source venv/bin/activate

python manage.py loaddata admin_interface_themes.json