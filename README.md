# README

This README would normally document whatever steps are necessary to get the
application up and running.
Things you may want to cover:

- Ruby version
  2.7.1
- System dependencies
  None
- Project Setup
  Open terminal in project's root directory and run `bundle install`
- Database creation
  rails db:create
- Database Migration
  rails db:migrate
- Database Population
  rails db:seed
- Server Instantiation
  Open terminal in project's root directory and run
  `rails server`
  # If it stops generating the information like following on terminal then run yarn install and run `rails server` again
  `Please run yarn install --check-files to update.`
- How to run the test suite
  Open terminal in the project's root directory and run `rspec`
- Services (job queues, cache servers, search engines, etc.)
  None
- Usage & Description
  # Usage
  Each api call is shown in the following postman collection, with method and body to send per request
  https://documenter.getpostman.com/view/12778823/TVKBXHiV
  # Description
  Description for each endpoint is as follows
  # Survivors
      `POST /api/v1/survivors` is the controller call to create the survivor with the params added in the
      requirements.
      `PUT /api/v1/survivors/:id` is the controller call to update the survivor location depending. Any other params passed wont be updated
  # Infection Reports
      `POST /api/v1/infection_reports` is the controller call to report the survivor is infected.
        NOTE:
          1). Reporter can't report himself/herself as infected.
          2). A reporter can't report twice the same survivor.
  # Trade Items
      `POST /api/v1/trades` is the contorller call to trade items betweeen survivor. `Atomicity` also implemented in this  API so if the server down in the middle of a trading operation then nothing occurs.
        NOTE:
          1). Buyer and Receiver both should not be infected.
          2). Buyer should must trade with someone else.
          3). For Trade, both survivors must have items mentioned in trade.
          4). For trade, Quantity of items should be valid for both.
          5). For trade, Items should be of same value commulatively
  # Generate Report
      `GET /api/v1/reports` is the controller call to generate report. It offer the following reports.
        1). Percentage of infected survivors.
        2). Percentage of non-infected survivors.
        3). The average amount of each kind of resource by the survivor.
        4). Points lost because of an infected survivor.
