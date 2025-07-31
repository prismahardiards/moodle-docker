FROM bitnami/moodle:4.3.2

# Install semua dependensi
RUN install_packages \
    wget git make gcc g++ autoconf libtool clisp \
    python3 python3-dev texinfo libssl-dev \
    libncurses5-dev libsqlite3-dev libbz2-dev zlib1g-dev

# Install Maxima with CLISP
WORKDIR /tmp
RUN wget https://netix.dl.sourceforge.net/project/maxima/Maxima-source/5.45.1-source/maxima-5.45.1.tar.gz \
    && tar xvf maxima-5.45.1.tar.gz \
    && cd maxima-5.45.1 \
    && ./configure --prefix=/usr --with-clisp \
    && make \
    && make install \
    && rm -rf /tmp/maxima-5.45.1*
    
CMD ["/start-services.sh"]