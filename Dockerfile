FROM rocker/verse:4.5.1
RUN apt-get update && apt-get install -y libgsl27 libgsl-dev
COPY DESCRIPTION ./DESCRIPTION
RUN Rscript -e "remotes::install_deps(dependencies = TRUE)"
RUN apt-get update && apt-get install -y texlive-fonts-extra
# TODO probably should make basilisk stuff be installed instantly too