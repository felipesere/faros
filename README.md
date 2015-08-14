# Lighthouse

[![Circle CI](https://circleci.com/gh/felipesere/lighthouse/tree/master.svg?style=svg)](https://circleci.com/gh/felipesere/lighthouse/tree/master)

An app to share books, blogs, conferences, events or pretty much any other resource
for learning.

### Up and running

To install the dependencies and setup the database run the following commands:

```
mix deps.get
mix ecto.create
mix ecto.migrate
```

To start the server:

```
mix phoenix.server
```

### Todo
1. Be able to retrieve a single book by 'slug'
   - A Book should have "isbn", "title", "slug", "description", "link"
2. Be able to list all books in the DB
3. List all books currently in the system
4. Add a new book to the system
5. Edit a books details in some kind of edit mode
    - Add a tag to a book
6. Add a review to a book (outside of edit?)
7. Get all books that have a specific tag
