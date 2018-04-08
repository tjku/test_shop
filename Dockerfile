# Base image
FROM ruby:2.5.1

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    locales \
    libpq-dev \
    nodejs && \
    locale-gen C.UTF-8 && \
    rm -rf /var/lib/apt/lists/*

# Set encoding
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Set an environment variable where the Rails app is installed to inside of Docker image
ENV RAILS_ROOT /app
RUN mkdir -p $RAILS_ROOT

# Set working directory, where the commands will be ran
WORKDIR $RAILS_ROOT

# Gems
COPY Gemfile ./
RUN bundle install

# Copy the main application
COPY . .

CMD puma -C config/puma.rb
