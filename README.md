## Result Analyzer - Rails App

### Introduction

This application works with test results and perform EOD and monthly calculations on the test results received.
* Students give online tests.
* A third party service, submits the test results to our rails app when a test is submitted by a student.
* We store these test results.
* Every day at 6 PM, our app performs the following EOD tasks:
    - Aggregates all the collected results for a day and calculates daily result stats.
    - If today is Monday of week of third Wednesday then it calculates monthly result averages.

### Prerequisites

To run the application in development environment you need to have following software installed.
```
* Ruby 2.7.2
* Rails '~> 5.2.5'
* MySQL database 8.0.29
* Git 2.x.x
```

### Installation

Clone the repo using below commands.
```
$ git clone
$ cd result_analyzer
$ bundle install
$ rails db:prepare
```

### Services

Run cron job to compute EOD tasks.
```
$ whenever --update-crontab
```

### Run dev server

```
bundle exec rails s
```

### Sample curl request to submit test results

```
curl --location 'localhost:3000/api/results_data' \
--header 'Content-Type: application/json' \
--data '{
    "subject": "Science",
    "timestamp": "2023-07-27 16:26:29.15896",
    "marks": 90.25
}'
```

### Test Coverage

```
rspec spec -fd
open spec/coverage/index.html
```

### Additional Information

* Whenever gem is used to compute EOD tasks via cron job.
* To view all current cron jobs use: ```crontab -l```
* You can also clear your crontab by running this: ```whenever --clear-crontab```












Things you may want to cover:
Add repo url also above
