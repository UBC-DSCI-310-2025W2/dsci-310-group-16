FROM rocker/tidyverse:4.5.2

WORKDIR /home/rstudio/project

COPY renv.lock renv.lock
COPY .Rprofile .Rprofile
COPY renv/ renv/ 

RUN R -e "install.packages('remotes'); remotes::install_version('renv','1.1.6'); renv::restore()"

COPY . .

