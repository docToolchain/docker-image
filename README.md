# docker-image for docToolchain

sources and issue tracker: https://github.com/docToolchain/docker-image
docker hub: https://hub.docker.com/r/rdmueller/doctoolchain/tags

version will be updated with each release of: https://github.com/docToolchain/doctoolchain.github.io/blob/master/dtcw#L12

**NOTE**: Most of the following currently works only for `jenkins-ssh-agent`!

## Set respective build environment

Align this with your personal settings/preferences.

```bash
: ${DOCKERHUB_USERNAME:="doctoolchain"}
: ${DTC_VERSION:="v2.2.1"}
# Export is not necessary as long as these variables are only used for local shell calls
```

## Build Docker image(s)

```bash
docker build \
  -t ${DOCKERHUB_USERNAME}/doctoolchain-jenkins-ssh-agent:${DTC_VERSION} \
  --build-arg DTC_VERSION=${DTC_VERSION} \
  jenkins-ssh-agent
```


## Test Docker image(s)

**Note**: This is only a smoke test (more elaborated test cases should be provided in the future).

```bash
docker run \
  --rm \
  -v ${PWD}/test:/workspace \
  -w /workspace \
  ${DOCKERHUB_USERNAME}/doctoolchain-jenkins-ssh-agent:${DCT_VERSION} \
  doctoolchain . tasks
```

## how to use

create a bash script within the root of your project like this one:

doctoolchain.sh
```bash
#!/usr/bin/env bash
docker run --rm -it --entrypoint /bin/bash -v ${PWD}:/project doctoolchain/doctoolchain:v2.2.1 \
-c "doctoolchain . $1 $2 $3 $4 $5 $6 $7 $8 $9 -PinputPath=src/main/asciidoc -PmainConfigFile=config/docToolchain.groovy && exit"
```

As you can see, this command will pull the container, run it, mount your project folder and execute docToolchain.

You can overrride the docToolchain version to use and some parameters like the location of the config file.

With this script, you use docToolchain on your project like this:

    ./doctoolchain.sh generateHTML

## Windows

on windows, the following batch script does the same:

```
docker run --rm --entrypoint /bin/bash -it -v %cd%:/project doctoolchain/doctoolchain:v2.2.1 -c "doctoolchain . %1 %2 %3 %4 %5 %6 %7 %8 %9 -PinputPath=src/main/asciidoc -PmainConfigFile=config/docToolchain.groovy && exit"
```

## Development / Deployment

New builds of the image are automatically triggered when (this repository is changed | a new Tag is created).
The resulting docker image is then available through the docker hub.

## Set up Github Actions for Continuous Integration

In order to automatically build and push new images via [Github Actions](https://docs.github.com/en/actions) the following steps are necessary.

* [Activate Github Actions](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/enabling-features-for-your-repository/managing-github-actions-settings-for-a-repository#managing-github-actions-permissions-for-your-repository) for your repository
* Create [secrets for your repository](https://docs.github.com/en/actions/security-guides/encrypted-secrets#creating-encrypted-secrets-for-a-repository)
  * `DOCKERHUB_USERNAME`: Your Docker Hub username (or of your organization), e.g., `doctoolchain`.
  * `DOCKERHUB_TOKEN`: **Caution**: Do not store your password here but [generate a suitable token](https://hub.docker.com/settings/security?generateToken=true) (Read/Write should be sufficient).