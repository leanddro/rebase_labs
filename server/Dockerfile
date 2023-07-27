FROM ruby:latest

EXPOSE 3000

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundle && bundle install

COPY . .

CMD ["sh", "-c", "sleep 3; rake db:migrate; puma -p 3000"]
