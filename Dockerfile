FROM ruby:2.6.5

ENV GEM_HOME="/usr/local/bundle"
ENV PATH $GEM_HOME/bin:$GEM_HOME/gems/bin:$PATH

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /myapp
WORKDIR /myapp

RUN gem install bundler

COPY .ruby-version /myapp/.ruby-version
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

RUN bundle install

COPY . /myapp

EXPOSE 3000
CMD bundle exec puma -C config/puma.rb

LABEL maintainer="Talal Arshad <talal7860@gmail.com>"
