FROM ruby:2.7

COPY ./inventarium /app
RUN cd /app && bundle install

ENTRYPOINT ["inventarium"]
