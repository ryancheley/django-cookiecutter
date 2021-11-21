#!/bin/bash
echo "Rename the example .env file"
mv {{cookiecutter.project_slug}}/.example_env {{cookiecutter.project_slug}}/.env

mkdir staticfiles