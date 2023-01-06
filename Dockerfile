FROM ruby:3.1.3-alpine
LABEL maintainer="nine.ch <engineering@nine.ch>"

RUN mkdir -p /app /var/lib/gemstash && \
    chmod a+w /var/lib/gemstash
WORKDIR /app

COPY Gemfile Gemfile.lock /app/
RUN apk add --no-cache build-base openssl git sqlite-dev postgresql-dev \
    && bundle lock --add-platform x86_64-linux-musl \
    && bundle install -j2 \
    && apk del build-base git

COPY . /app/

VOLUME /var/lib/gemstash
EXPOSE 9292
CMD [ "/app/bin/start.sh" ]
