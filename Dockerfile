FROM ruby:2.3

RUN mkdir /blog

WORKDIR /blog

COPY Gemfile /blog/Gemfile
COPY Gemfile.lock /blog/Gemfile.lock

RUN bundle install

EXPOSE 4000:4000

ENTRYPOINT [ "bundle", "exec" ]

CMD [ "jekyll", "serve", "--watch", "--drafts", "--host=0.0.0.0" ]
