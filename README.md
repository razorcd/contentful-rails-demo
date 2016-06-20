## Contentful demo app

Synchronizes a local datastore with the remote Contentful datastore.

See [doc_api.md](https://github.com/razorcd/contentful-rails-demo/blob/master/doc_api.md) for all exposed endpoints.

## Development

- install `ruby 2.3.1`
- run `bundle install`
- update `.env.development` and `.env.test` based on `.env.example`

- to run tests: `rspec`
- to clear VCR persisted requests: `rm spec/fixtures/vcr_cassettes/*`

##TODO

- [X] sync Product
- [X] sync Category with Product relation
- [X] sync Assets with Product relation
- [X] download/sync files
- [X] add method to recursively load sync data from Contentful API
- [X] add endpoint to trigger a sync that incrementally updates the local data
- [X] to completely reset the local data by triggering a full initial sync
- [X] sync deleted / modified and new records. Use `nextSyncUrl` to update only the changes
- [X] serialize exposed endpoint data and eager load Product with relations
- [ ] ensure recursive sync (nextPageUrl) is functional (reduce elements count per request)
- [ ] add FactoryGirl for functional tests
- [ ] models: add validations and unit tests
- [ ] add integration tests
- [ ] add CI with Travis and deploy to Heroku

##Comments

- this is a demo app, some implementations are only for demo purposes and would not make it to production. Example: `/products` exposes resources `:id` field, it is for demo readability only.
- In a real life application the `contentful - local sotre` synchronization would be done in a background job to not block the main process by doing external requests (`/sync`).
