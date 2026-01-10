FROM ruby:3.4.8-slim AS base

RUN apt update -qq

WORKDIR /src



FROM base AS builder

RUN apt install -y --no-install-recommends build-essential libpq-dev libsqlite3-dev libyaml-dev git && \
    rm -r /var/lib/apt/lists/*

COPY railsapi/Gemfile .
COPY railsapi/Gemfile.lock .

RUN bundle config set --global path "/usr/local/bundle" && \
    bundle install && \
    rm -rf /usr/local/bundle/cache/*.gem

COPY railsapi .



FROM builder AS tester

ARG TEST_MODE=strict
ENV RAILS_ENV=test
ENV DATABASE_URL=sqlite3:/tmp/test.sqlite3
ENV SECRET_KEY_BASE=test-secret

RUN case "$TEST_MODE" in \
        "none") echo "skipped" > /app-test-log.txt ;; \
        "lax") (bundle exec rake db:migrate && bundle exec rspec) > /app-test-log.txt 2>&1 || true ;; \
        "strict") (bundle exec rake db:migrate && bundle exec rspec) && echo "success" > /app-test-log.txt;; \
    esac
RUN rm -r spec



FROM base AS runner

RUN apt install -y --no-install-recommends libpq5 libyaml-0-2 git && \
    rm -r /var/lib/apt/lists/*

RUN groupadd -g 1000 app && \
    useradd -u 1000 -g app -s /sbin/nologin app

COPY --from=tester /usr/local/bundle /usr/local/bundle
COPY --from=tester --chown=app:app /src .
COPY --from=tester /app-test-log.txt /var/log/app-test-log.txt

ENV RAILS_ENV=production
ENV RAILS_LOG_TO_STDOUT=true
ENV BUNDLE_DEPLOYMENT=1
ENV BUNDLE_PATH=/usr/local/bundle
ENV BUNDLE_USER_HOME=/tmp/bundler

USER app

CMD ["sh", "cmd.sh"]
