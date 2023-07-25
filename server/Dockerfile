FROM ruby:latest

EXPOSE 3000

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundle && bundle install

COPY . .

ENV RACK_ENV=production

CMD puma -p 3000
