## Contentful demo app

Synchronizes a local datastore with the remote Contentful datastore.

##TODO
- [ ] add endpoint to trigger a sync that incrementally updates the local data
- [ ] to completely reset the local data by triggering a full initial sync
- [ ] add a `starting_from` parameter to sync so it reads only the new data
- [ ] ensure recursive sync is functional (reduce elements count per request)
- [ ] add FactoryGirl for functional tests
- [ ] sync files
