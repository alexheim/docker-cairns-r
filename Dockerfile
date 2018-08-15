FROM r-base
RUN apt-get update -y
RUN apt-get install -y procps
RUN apt-get install -y libssl-dev
RUN apt-get install -y libcurl4-openssl-dev
# https://stackoverflow.com/questions/50410289/running-r-script-from-java-rconnection-eval-exception/50622263#50622263
# RUN Rscript -e "install.packages('Rserve')"
RUN Rscript -e "install.packages('https://www.rforge.net/Rserve/snapshot/Rserve_1.8-6.tar.gz')"
RUN Rscript -e "install.packages('RSclient')"
RUN Rscript -e "install.packages('pander')"
RUN Rscript -e "install.packages(c('ggplot2', 'plotly', 'plyr'))"
RUN Rscript -e "install.packages('psych')"
RUN Rscript -e "install.packages('Ckmeans.1d.dp')"
RUN Rscript -e "install.packages('ChainLadder')"
RUN Rscript -e "install.packages('knitr', dependencies = TRUE)"
RUN Rscript -e "install.packages('flexdashboard')"
RUN Rscript -e "install.packages('formattable')"
RUN Rscript -e "install.packages('webshot')"
RUN Rscript -e "library(webshot); webshot::install_phantomjs()"
COPY Rserv.conf /etc/Rserv.conf

# The R installation exposes its local library
# and the Rserv listener port to the outer world
# you can use a VOLUME /usr/local/lib/R to make installed packages persistent
EXPOSE 6311

ENTRYPOINT R CMD Rserve --no-save; sleep infinity
