# VSCode server in docker with environments

The idea behind this repo is to isolate development with vscode inside docker
containers.

This way, jump start any project with any kind of setup for a specific language/framework will be made in seconds.

For example, if you want to start developing in blitz, just add this to `.env`

```
COMPOSE_PROJECT_NAME=greatproject_dev
PROJECT_TYPE=blitzjs
GIT_EMAIL=my@email.com
GIT_USER=god
```

And run `make up`.

After it starts you can connect to vscode server through browser in `localhost:8443` or just open your vscode, go to docker extension, and press right click on the docker you just created and press connect to docker. You will have your own installation of vscode working inside the docker container, with all the needed stuff to run in terminal.

## Considerations

Workspace is the only folder you will care about, is there where your app or software will reside, the rest on the root folder you will use only to start the proper docker instance with the prepared environment. So once you start up the project, just connect to the docker instance and you will be already with terminal in `workspace`, and you can `git clone xxx .` your project, or start a new one there

Containers are prepared to use your host user:group, so you will not need to deal with writting permissions or similar. Even if in terminal inside the docker you see the name as `coder`, your host user id and group id are being used to create the files in the mounted volume `workspace`.

In vscode_configs will reside all the configurations for when you will connect with vscode from host. This folders are mounted into workspace/.vscode, so any change here you can save it with your project, for synchronize between computers.

This project will create a coder base image in your local docker registry of images. This is used as base to add on top each language/framework specific requirements. This way you can have multiple development environments, but only one base image is needed for coder.

## Project types

For the moment this is the project types you can configure in `.env` file:

```
blitzjs
react
nodejs
```

Each one comes with the minimal requirements to have the best experience.

All of them are "extensions" for dockerfiles, so for example blitzjs is using `Dockerfile.blitzjs`. Feel free to make any modification you need in the files to adjust your environment (or send a pull request with improvements).

## How to use

There is a `Makefile` that handles all for your, so the commands are simplier:

```
# build coder base image
make build-coder

# build coder if needed and build project specific configured container
make build

# build if needed and start current configured container
make up

# stop and delete current configured container
make down
```

### Ok, that's cute, but then what i should do with all this commands?

The easy way is just to fill your `.env` file

```
COMPOSE_PROJECT_NAME=greatproject_dev
PROJECT_TYPE=blitzjs
GIT_EMAIL=my@email.com
GIT_USER=god
```

and run

`make up`

This will build all needed stuff and start the docker development instance.

If you want to let it running in background, just

`make up -d`

## Extra

If you find any kind of problem or wathever that can be improved, feel free to open an issue and i will take a look on it, or merge if is a good pull request.