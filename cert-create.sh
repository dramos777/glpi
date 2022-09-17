#!/usr/bin/env bash
#Create files.pem needed for webserver

openssl req -newkey rsa:2048 -nodes -keyout ./certificates/privkey.pem -x509 -days 365 -out ./certificates/fullchain.pem && openssl dhparam -out ./certificates/dhparam.pem 2048
chmod -w ./certificates/*
