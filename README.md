# Ambergrease

## Abstract

PHP + MySQL + phpMyAdmin の開発環境を Docker に構築する Docker Compose 等の設定集です。

## Usage

`git clone https://github.com/arm-band/docker_compose_ambergrease.git`

### Usage

1. copy `sample.env` and rename `.env`
2. change parameters in `.env`
3. `docker-compose up -d`
    - 仮想ホストとDBをファイル永続化する場合は `docker-compose -f compose.yml -f compose.volumes.yml up -d`
4. `docker-compose exec web /bin/bash` or `docker-compose exec db /bin/bash` or `docker-compose exec phpmyadmin /bin/bash`

### Finish

1. `docker-compose down`

---

以上