#!/bin/bash
docker exec -i  nodeONE mysql  < setupdb.sql
docker exec -i -t nodeONE  mysqladmin -u root password
