FROM rocker/verse:4.5.1
# FIXME: ImportError: /usr/lib/x86_64-linux-gnu/libcrypto.so.3: version `OPENSSL_3.3.0' not found (required by /root/.cache/R/basilisk/1.20.0/Ibex/0.99.12/IbexEnv/lib/python3.9/lib-dynload/_ssl.cpython-39-x86_64-linux-gnu.so)
RUN apt-get update && apt-get install -y libgsl27 libgsl-dev
RUN apt-get update && apt-get install -y texlive-fonts-extra
WORKDIR /Ibex
COPY . .
RUN Rscript -e "remotes::install_deps(dependencies = TRUE)"
RUN Rscript -e "devtools::document(); devtools::test()"
