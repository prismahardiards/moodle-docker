# Gunakan image dasar yang spesifik untuk stabilitas
FROM bitnami/moodle:latest

# Perbarui package manager dan instal dependensi yang lebih lengkap
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget git make gcc g++ autoconf libtool sbcl \
    python3 python3-dev texinfo libssl-dev \
    libncurses5-dev libsqlite3-dev libbz2-dev zlib1g-dev \
    libgmp-dev \
    && rm -rf /var/lib/apt/lists/*

# Pindah ke direktori temporer dan unduh serta kompilasi Maxima
WORKDIR /tmp
RUN wget https://netix.dl.sourceforge.net/project/maxima/Maxima-source/5.48.0-source/maxima-5.48.0.tar.gz \
    && tar xvf maxima-5.48.0.tar.gz \
    && cd maxima-5.48.0 \
    && ./configure --prefix=/usr --with-sbcl \
    && make -j$(nproc) \
    && make install \
    && cd / \
    && rm -rf /tmp/maxima-5.48.0*