#!/usr/bin/make

SHELL = /bin/sh

USER_ID := $(shell id -u)
GROUP_ID := $(shell id -g)

export USER_ID
export GROUP_ID

build-coder:
	docker build -t coder-base-image .

build: build-coder
	docker-compose build

up: build
	docker-compose up

down:	
	docker-compose stop && docker-compose rm
