FROM r-base
RUN apt-get update -y
RUN apt-get install -y procps libssl-dev libcurl4-openssl-dev

# Maybe one day ... 
#  RUN apt-get install -y texlive-full

RUN Rscript -e "install.packages('Rserve')"
RUN Rscript -e "install.packages('RSclient')"
RUN Rscript -e "install.packages('pander')"
RUN Rscript -e "install.packages('ggplot2')"
RUN Rscript -e "install.packages('psych')"
RUN Rscript -e "install.packages('Ckmeans.1d.dp')"
RUN Rscript -e "install.packages('ChainLadder')"
RUN Rscript -e "install.packages('knitr', dependencies = TRUE)"

COPY Rserv.conf /etc/Rserv.conf

# The R installation exposes its local library
# and the Rserv listener port to the outer world
# you can use a VOLUME /usr/local/lib/R to make installed packages persistent
EXPOSE 6311

ENTRYPOINT R CMD Rserve --no-save; sleep infinity
