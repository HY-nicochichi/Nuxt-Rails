FROM ruby:3.4.8-slim AS base

RUN apt update -qq

WORKDIR /src



FROM base AS builder

RUN apt install -y --no-install-recommends build-essential libpq-dev libsqlite3-dev libyaml-dev git

COPY railsapi/Gemfile railsapi/Gemfile.lock ./

RUN bundle config set --local path "vendor/bundle" && \
    bundle install

COPY railsapi/ .



FROM builder AS tester

ARG TEST_MODE=strict
ENV RAILS_ENV=test
ENV DATABASE_URL=sqlite3:/tmp/test.sqlite3
ENV JWT_SECRET_KEY=test-secret

RUN case "$TEST_MODE" in \
        "none") echo "skipped" > /rails-test-log.txt ;; \
        "lax") (bundle exec rake db:migrate && bundle exec rspec) > /rails-test-log.txt 2>&1 || true ;; \
        "strict") (bundle exec rake db:migrate && bundle exec rspec) && echo "success" > /rails-test-log.txt;; \
    esac
RUN rm -r spec



FROM base AS runner

RUN apt install -y --no-install-recommends libpq5 libyaml-0-2 git && \
    rm -r /var/lib/apt/lists/*

COPY --from=tester /src .
COPY --from=tester /rails-test-log.txt /var/log/rails-test-log.txt

ENV RAILS_ENV=${RAILS_ENV:-production}
ENV BUNDLE_PATH=/src/vendor/bundle
ENV BUNDLE_DEPLOYMENT=1

CMD ["sh", "cmd.sh"]
