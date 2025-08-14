FROM rocker/verse:4.5.1
RUN apt-get update && apt-get install -y texlive-fonts-extra
WORKDIR /Ibex
COPY . .
RUN apt install -y libgsl-dev
RUN Rscript -e "install.packages('Seurat')"
RUN Rscript -e "remotes::install_deps(dependencies = TRUE)"
RUN Rscript -e "install.packages('keras3'); keras3::install_keras()"
RUN Rscript -e "devtools::document(); devtools::test()"
