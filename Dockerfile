from ubuntu:18.10 as builder

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL en_US.UTF-8

# Set the locale
RUN rm -rf rm /var/lib/apt/lists/* && apt-get update && apt-get install -y locales && apt-get clean
RUN locale-gen en_US.UTF-8

RUN apt-get update && apt-get install -y git wget gnupg && apt-get clean
RUN apt-get install -y make && apt-get clean
RUN apt-get install -y texlive-latex-base \
                       texlive-latex-extra  \
                       texlive-fonts-recommended \
                       texlive-fonts-extra \
                       texlive-xetex
RUN apt-get install -y librsvg2-bin
RUN apt-get install -y calibre && apt-get clean
RUN apt-get install -y aspell aspell-en && apt-get clean
RUN apt-get install -y ruby ruby-dev build-essential && apt-get clean
RUN gem install bundler

RUN wget https://github.com/jgm/pandoc/releases/download/2.7.2/pandoc-2.7.2-linux.tar.gz && tar -xvpf pandoc-2.7.2-linux.tar.gz && mv pandoc-2.7.2/bin/pandoc /usr/bin/pandoc && mv pandoc-2.7.2/bin/pandoc-citeproc /usr/bin/pandoc-citeproc && rm -rf pandoc-2.7.2 && rm -f *.tar.gz*
RUN wget https://github.com/owickstrom/pandoc-include-code/releases/download/v1.2.0.2/pandoc-include-code-linux-ghc8-pandoc-1-19.tar.gz && tar -xvpf pandoc-include-code-linux-ghc8-pandoc-1-19.tar.gz && mv ./pandoc-include-code /usr/bin/pandoc-include-code && chmod +x /usr/bin/pandoc-include-code && rm -f *.tar.gz*

RUN wget https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.4.1a/linux-pandoc_2_7_3.tar.gz -O pandoc-crossref.tar.gz && tar -xvpf pandoc-crossref.tar.gz && mv pandoc-crossref* /usr/bin/ && chmod +x /usr/bin/pandoc-crossref* && rm -f *.tar.gz

workdir /app
