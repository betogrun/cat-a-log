// playwright.config.js

const config = {
  // Look for test files in the "tests" directory, relative to this configuration file
  testDir: "spec",

  // Each test is given 30 seconds
  timeout: 30000,

  // Forbid test.only on CI
  // forbidOnly: !!process.env.CI,

  // Two retries for each test
  // retries: 2,

  // Limit the number of workers on CI, use default locally
  workers: process.env.CI ? 2 : undefined,

  use: {
    // Configure browser and context here
  },

  webServer: {
    command:
      "RAILS_ENV=test bundle exec rails db:test:prepare && bundle exec rails server -p 3001 -e test",
    port: 3001,
    timeout: 120 * 1000,
    reuseExistingServer: !process.env.CI,
  },
};

module.exports = config;