const outputFolder = './output';

exports.config = {
  output: outputFolder,

  multiple: {
    ie: {
      "grep": "@ie",
      "browsers": [
        "internet explorer"
      ],
      "restart": true,
      "keepBrowserState": true,
      "keepCookies": true
    },
    chrome: {
      "grep": "@chrome",
      "browsers": [
        "chrome"
      ],
      "restart": true,
      "keepBrowserState": true,
      "keepCookies": true
    },
  },
  helpers: {
    WebDriverIO: {
      url: 'https://formsviewertest.azurewebsites.net',
      browser: 'chrome',
      windowSize: 'maximize',
    },
    Mochawesome: {
      uniqueScreenshotNames: true,
    },
    FileSystem: {},
  },
  include: {},
  mocha: {
    reporterOptions: {
      'codeceptjs-cli-reporter': {
        stdout: '-',
        options: {
          verbose: false,
          steps: true,
        },
      },

      'mocha-junit-reporter': {
        stdout: '-',
        options: {
          mochaFile: `${outputFolder}/TestReport.xml`,
        },
      },

      mochawesome: {
        stdout: `${outputFolder}/report-stdout.txt`,
        options: {
          reportDir: outputFolder,
          reportTitle: 'My Test Report Title',
          reportFilename: 'TestReport',
          inlineAssets: true,
        },
      },
    },
  },
  bootstrap: false,
  teardown: null,
  hooks: [],
  tests: './tests/*_test.js',
  timeout: 10000,
  name: 'doler-js',
};