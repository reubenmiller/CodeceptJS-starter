# Codeceptjs-starter: Getting started

## Dependencies

Make sure the following package are already installed or your system.

1. Java (1.8) (required by selenium)
1. node js 8.9.x

## Installing/Initialising the Project

1. Run `npm install`, in the root project folder (after you have cloned the project)

1. Install selenium standalone server by executing the following command. (Skip step if you are starting selenium manually)
```sh
npm run install:selenium
```
3. Start the selenium standalone server
```sh
npm run start:serverwin

# Or on MacOS
npm run start:serverlinux
```

4. Execute the tests
```sh
npm run test
```


##  Other commands
### Internet Explorer Only Tests
Tests that should only be run against Internet Explorer should have the @ie tag in the scenario description.

Run the Internet Explorer only tests using

```sh
npm run test:multi_ie
```

### Chrome Only Tests
Tests that should only be run against Chrome should have the @chrome tag in the scenario description.

Run the Chrome only tests using

```sh
npm run test:multi_chrome
```

### Run both Chrome and Internet Explorer Tests

The following command will run both sets of tests at the same time (though the each tests will only be executed as above, however the tests will be run at the same time).

```sh
npm run test
```
