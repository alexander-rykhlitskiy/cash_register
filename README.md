# README

## Set up and run

```bash
bundle install
rails db:setup
rails s
```

## Run tests

#### All tests
First, set up and run the app. Then
```bash
bin/test
```

#### Only unit tests
```bash
rspec
```

#### Only E2E tests
First, set up and run the app. Then
```bash
yarn run playwright test
yarn run playwright show-trace trace.zip # to see how it was running
```

## TODO

* Configure E2E test environment with docker-compose
