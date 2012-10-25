#!/bin/bash

echo "drop database "$1"; create database "$1" ;" | mysql -u root -p

