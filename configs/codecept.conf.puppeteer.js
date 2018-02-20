exports.config = {
  helpers: {
    Puppeteer: {
      url: process.env.CODECEPT_URL || 'https://google.com',
      show: true,
      restart: false,
    },
  },

  // don't build monolithic configs
  mocha: {},
  includes: {},
  tests: '../tests_puppeteer/*_test.js'
};