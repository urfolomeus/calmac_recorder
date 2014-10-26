# CalMac ferry recorder

A tool that pulls service information from the CalMac website and records whether or not a ferry sailed.


## Development

The majority of the code is located in the `lib` folder, with tests in the `spec` folder. Please be sure to cover any code you write with tests to make it easier for me to know what the intent of your code is and whether it works with everything else. :)


## Database

In order to use the database you will need to have postgres installed. Create a .env file and then add the following:

```bash
DATABASE_URL="postgres://<user>:<password>@<host>/<schema>"
```

Then create the schema (if it doesn't already exist) like so:

```bash
createdb <schema>
```

And make sure that the named user has access to do everything on that schema:

```bash
psql
GRANT ALL PRIVILEGES ON DATABASE <schema> TO <user>
```

If you run into difficulties then GIYF ;)


## Tests

```bash
bundle
bin/rspec
```


## Contributing

Please fork the repo, make your changes and then submit them as a Pull Request back to this repo. If you have any questions, please contact alan at armoin dot com.

