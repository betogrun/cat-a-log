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

# Update package lists
RUN apt-get update

# Install dependencies required for Playwright
RUN apt-get install -y libnss3 libnspr4 libatk1.0-0 libatk-bridge2.0-0 libcups2 libdrm2 libdbus-1-3 \
    libxkbcommon0 libatspi2.0-0 libxcomposite1 libxdamage1 libxfixes3 libxrandr2 libgbm1 libasound2

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