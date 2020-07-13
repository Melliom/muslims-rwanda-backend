![logo](public/logo-temp.svg)
# MUSLIM RWANDA APP

[![Build Status](https://travis-ci.org/Melliom/muslims-rwanda-backend.svg?branch=develop)](https://travis-ci.org/Melliom/muslims-rwanda-backend)  [![Coverage Status](https://coveralls.io/repos/github/Melliom/muslims-rwanda-backend/badge.svg)](https://coveralls.io/github/Melliom/muslims-rwanda-backend)

The Rwanda Muslim app is a project that aims to make it easy for Muslims in Rwanda to access information about sallat, mosque location, prayer time, and in the future interact with sheikhs within the app and easily organize diverse preaching sessions. 
This is a monolith repo for the backend ( supporting the dashboard and the mobile app)  and the front-end (for the dashboard), the stack used is `ruby`, `Ruby on Rails`, `react`, `redux`, `Postgres`, hosted on `Heroku` and files stored on `cloudinary`

# Contribution

## Development setup and Installation

Make sure you have ruby and node installed
```
Ruby 2.5.3
Rails 5.2.2
```

Clone project

```sh
git clone git@github.com:Melliom/muslims-rwanda-backend.git
```

Move to cloned repo

```sh
cd muslims-rwanda-backend
```

Install dependencies

```sh
bundle && yarn
```

Configuration: Refer to `config/application.template.yml`

1. database user and password
2. sendgrid: `send emails` you need to get your own sendgrid username and secret_key
3. cloudinary: `store images` api key secret and and api_key


Setup db | run migration | seed super admin

 ```sh
 rails db:setup
```

This assumes that you have postgres installed

Run app

 ```sh
 rails server
```

## Usage

The collection of request is shared on postman 

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/125e6e5749fb8ab5962a)  


## Authors

> **Melliom** / **Hadad Dus** -  [@dusmel](https://github.com/dusmel)

> **Melliom** / Twitter: [@dusmel](https://twitter.com/hadad__)

See also the list of [contributors](https://github.com/Melliom/muslims-rwanda-backend/graphs/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](/public/LICENSE.md) file for details


## Contributing

1. Fork it (<https://github.com/Melliom/muslims-rwanda-backend/fork>)
2. Create your feature branch (`git checkout -b story/MRA-20-add-this`) convention 👉🏼 [here][convention-branch]
3. Commit your changes  convention 👉🏼 [here][convention-commit]
4. Push to the branch (`git push origin <branch-name>`)
5. Create a new Pull Request


## ROADMAP 
[![TRELLO][trello-image]][trello-invite-link] 

<!-- Markdown link & img dfn's -->
[convention-branch]: https://github.com/dusmel/engineering-playbook/blob/master/5.%20Developing/Conventions/readme.md#branch-naming
[convention-commit]: https://github.com/dusmel/engineering-playbook/blob/master/5.%20Developing/Conventions/readme.md#commit-message
[trello-image]: https://img.icons8.com/color/30/000000/trello.png
[trello-invite-link]: https://trello.com/invite/b/Ck8B2odp/a4c6ee0b7f691a8eef85f298b9ed6103/muslim-rwanda-app
[npm-image]: https://img.shields.io/npm/v/datadog-metrics.svg?style=flat-square
[npm-url]: https://npmjs.org/package/datadog-metrics
[npm-downloads]: https://img.shields.io/npm/dm/datadog-metrics.svg?style=flat-square
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg?style=flat-square
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
[wiki]: https://github.com/yourname/yourproject/wiki
