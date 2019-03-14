# Zendesk FAQs

## Task
Create an application that will list all available articles for the user to select and view in detail. The [front end](https://github.com/devadeka/zd_tickets_fe) application will need to talk to a [proxy API](https://github.com/devadeka/zd_tickets_be) that caches data from Zendesk's FAQs API for an hour.

## Technology Used
The application was developed on `Ubuntu 18.04`

Modules and Libraries used:
- Ruby v2.6.0
- Rails v5.2.2
- [HTTParty](https://github.com/jnunemaker/httparty)
- [Redis](https://github.com/antirez/redis)
- [Rspec](https://github.com/rspec/rspec)

## Installation
First clone repository.

`git clone https://github.com/devadeka/zd_tickets_be.git`

Install dependencies.

`bundle install`

## Testing
After cloning and installing dependencies.
Ensure internet connection is available as the application makes calls to external APIs.

`bundle exec rspec`

## Running
After cloning and installing dependencies.
Ensure internet connection is available as the application makes calls to external APIs.

`rails s`

## Design Decisions
Main design decision came in the form of caching technique. Originally the API was built as a standard CRUD app witha PostgresDB- only allowing the controller action of `index`. The caching mechanism would have been to run a background cron-job to periodically request the data and use the Rails-Models to add/update in Postgres (this can be seen in the cron_caching branch of the repository). This method was abandonned after looking at the number of DB calls the background job would have to make to maintain the near 2000 entries.

The cron-caching method was abondonned in favour of redis-caching. Rails5 has support for Redis caching to the set up was simple. Where the cron-caching method intended to keep 'models' of Articles/FAQs, the redis-caching method stored the JSON response of the page request (which contained the Articles and the metrics - `page` and `page_count`).

A minor design decision was to filter out unecessary fields in the JSON response. Because the purpose of this API was to cache and forward information to the forntend application, knowing exactly what information the frontend utilises allows this API to only return the needed fields. The advantage of this would be to reduce the payload for the frontend. 

Reducing the payload was also a factor in deciding to hardcode (rather than allow the user to select) the `per_page` value when querying Zendesk's FAQs API. The `per_page` value can be set up to 100, but a value of 10 was chosen so that a response will be processed quicker - the user of the frontend application can make multiple small request for page information.

## Improvements
An advantage of the cron-caching method was it could be tested with dummy data without relying on external data source. Better testing strategy is needed for the API to not rely on having internet connection.
