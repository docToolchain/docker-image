# docker-image for docToolchain

sources and issue tracker: https://github.com/docToolchain/docker-image

## how to use

create a bash script within the root of your project like this one:

```bash
docker run --rm -it --entrypoint /bin/bash -v ${PWD}:/project rdmueller/doctoolchain:rc-1.0.0 \
-c "doctoolchain . $1 $2 $3 $4 $5 $6 $7 $8 $9 -PmainConfigFile=config/docToolchain.groovy && exit"
```

As you can see, this command will pull the container, run it, mount your project folder and execute docToolchain.

You can overrride the docToolchain version to use and some parameters like the location of the config file.

