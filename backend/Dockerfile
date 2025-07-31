FROM ruby:3.4.4-slim

RUN apt update -qq && \ 
apt install -y build-essential libpq-dev libyaml-dev git

COPY . /
WORKDIR /railsapi

RUN bundle install

CMD ["sh", "/cmd.sh"]
