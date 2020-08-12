FROM circleci/ruby:2.6.0-node-browsers

ENV PORT 4000

WORKDIR /usr/src/developers.italia.it

USER root

RUN apt-get install -y --no-install-recommends rsync \
  && apt-get clean \
  && rm -fr /var/lib/apt/lists/*

USER ${RUNAS}

# Copy useful files inside the workdir
COPY .well-known .well-known
COPY _data _data
COPY _includes _includes
COPY _layouts _layouts
COPY _pages _pages
COPY _platforms _platforms
COPY _plugins _plugins
COPY _posts _posts
COPY _sass _sass
COPY _templates _templates
COPY assets assets
COPY en en
COPY it it
COPY swagger swagger
COPY 403.html .
COPY 404.html .
COPY 500.html .
COPY _config.yml .
COPY favicon.ico .
COPY Gemfile .
COPY Gemfile.lock .
COPY LICENSE .
COPY Makefile .
COPY package-lock.json .
COPY package.json .

RUN make include-npm-deps
RUN make build-bundle
RUN make download-data
RUN make build-swagger

EXPOSE 4000

CMD ["make", "local"]
