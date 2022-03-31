# docker-image for docToolchain

sources and issue tracker: https://github.com/docToolchain/docker-image
docker hub: https://hub.docker.com/r/rdmueller/doctoolchain/builds

## how to use

create a bash script within the root of your project like this one:

doctoolchain.sh
```bash
#!/usr/bin/env bash
docker run --rm -it --entrypoint /bin/bash -v ${PWD}:/project rdmueller/doctoolchain:v2.0.0-rc14c \
-c "doctoolchain . $1 $2 $3 $4 $5 $6 $7 $8 $9 -PinputPath=src/main/asciidoc -PmainConfigFile=config/docToolchain.groovy && exit"
```

As you can see, this command will pull the container, run it, mount your project folder and execute docToolchain.

You can overrride the docToolchain version to use and some parameters like the location of the config file.

With this script, you use docToolchain on your project like this:

    ./doctoolchain.sh generateHTML

## Windows

on windows, the following batch script does the same:

```
docker run --rm --entrypoint /bin/bash -it -v %cd%:/project rdmueller/doctoolchain:v2.0.0-rc14c -c "doctoolchain . %1 %2 %3 %4 %5 %6 %7 %8 %9 -PinputPath=src/main/asciidoc -PmainConfigFile=config/docToolchain.groovy && exit"
```

## Development / Deployment

New builds of the image are automatically triggered when (this repository is changed | a new Tag is created).
The resulting docker image is then available through the docker hub.
