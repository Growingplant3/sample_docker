FROM ruby:2.6.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /sample_docker
COPY Gemfile /sample_docker/Gemfile
COPY Gemfile.lock /sample_docker/Gemfile.lock
RUN bundle install
COPY . /sample_docker

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
