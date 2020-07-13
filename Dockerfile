FROM ruby:2.6.4

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y build-essential nodejs yarn

WORKDIR /app

RUN gem install bundler:2.1.2
COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install

COPY . .
RUN yarn install --check-files
RUN bundle exec rake app:update:bin
RUN bin/rails db:migrate

EXPOSE 3000

CMD bin/rails server -b 0.0.0.0
