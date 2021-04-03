FROM rdmueller/doctoolchain:v1.3.1

# Reinstall any system packages required for runtime of pandoc.
RUN apk --no-cache add \
        gmp \
        libffi \
        lua5.3 \
        lua5.3-lpeg

COPY --from=pandoc/core:2.9 \
    /usr/bin/pandoc \
    /usr/bin/pandoc-citeproc \
    /usr/bin

SHELL ["/bin/bash", "-c"]

WORKDIR /project

VOLUME /project

ENTRYPOINT /bin/bash
