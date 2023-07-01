# Base stage for shared settings
FROM ruby:3.1.2 as base

ENV BUNDLE_PATH /usr/local/bundle
WORKDIR /usr/src/cat-a-log

# Install Node.js 18.x and Yarn
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install --global yarn

COPY Gemfile .
COPY Gemfile.lock .
COPY package.json .
COPY yarn.lock .

RUN bundle install
RUN yarn install

# Development stage
FROM base as development

# Add the node_modules/.bin directory to the PATH
ENV PATH /usr/src/cat-a-log/node_modules/.bin:$PATH

ENV RAILS_ENV development

COPY . .

# Install Node.js dependencies
RUN yarn install

ENTRYPOINT ["./entrypoint.sh"]

# Production stage
FROM base as production

ENV RAILS_ENV production
ENV NODE_ENV production

COPY . .

# Run asset precompilation in the production environment
RUN bundle exec rake assets:precompile

ENTRYPOINT ["./entrypoint.sh"]