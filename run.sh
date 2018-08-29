#!/bin/bash

set -e

docker build --file wordpress/Dockerfile -t wordpress:centos6 .
WP_CID=$(docker run --name wordpress -d -p 80 -p 22 wordpress:centos6)
export WP_CID
WP_PORT=$(docker port "$WP_CID" 80)
export MYSQL_DATA
export WP_PORT

docker run --name keycloak1 -e KEYCLOAK_USER=admin -e KEYCLOAK_PASSWORD=admin -p 8080:8080 -d jboss/keycloak
docker run --name keycloak2 -e KEYCLOAK_USER=admin -e KEYCLOAK_PASSWORD=admin -p 8181:8080 -d jboss/keycloak
echo "Wordpress: http://$WP_PORT"
echo "Keycloak1: http://0.0.0.0:8080"
echo "Keycloak2: http://0.0.0.0:8181"
