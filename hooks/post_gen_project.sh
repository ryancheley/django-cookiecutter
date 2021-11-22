#!/bin/bash
echo "Rename the example .env file"
mv {{cookiecutter.project_slug}}/.example_env {{cookiecutter.project_slug}}/.env

echo "Make the staticfiles directory"
mkdir staticfiles

echo "Create the virtual environment"
python3 -m venv venv

echo "Activate the Virtual Environment"
source venv/bin/activate

echo "Install requirements"
pip install -r requirements/local.txt

echo "Load the admin interface themes"
python manage.py loaddata admin_interface_themes.json