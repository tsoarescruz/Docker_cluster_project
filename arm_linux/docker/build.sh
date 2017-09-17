#! /bin/bash

# Cria o build da imagem, executado os containers e cria a seed do banco

docker-compose build
sh startup.sh