## Contentful demo app

Synchronizes a local datastore with the remote Contentful datastore.

##TODO
- [X] add method to recursively load sync data from Contentful API
- [X] add endpoint to trigger a sync that incrementally updates the local data
- [X] to completely reset the local data by triggering a full initial sync
- [ ] sync deleted / modified and new records only. add a `starting_from` parameter to sync, so it reads only the new data ???
- [ ] ensure recursive sync is functional (reduce elements count per request)
- [ ] add FactoryGirl for functional tests
- [ ] sync files
- [ ] add integration tests
