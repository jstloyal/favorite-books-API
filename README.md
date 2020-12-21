## Building Ruby on Rails Backend API

<!--
*** Thanks for checking out this README Template. If you have a suggestion that would
*** make this better, please fork the repo and create a pull request or simply open
*** an issue with the tag "enhancement".
*** Thanks again! Now go create something AMAZING! :D
-->

<!-- PROJECT SHIELDS -->

<p align="center">
  This project is part of the Microverse curriculum in Final capstone!
</p>

<!-- TABLE OF CONTENTS -->

## Table of Contents

- [About the Project](#about-the-project)
- [Contributors](#contributors)
- [Acknowledgements](#acknowledgements)
- [License](#license)

### Currently working endpoints for books

- `GET /items` - all items from the database.
- `GET /items/:id` - get items details by id.
- `POST /items/` - create a new item
- `DELETE /items/:id` - find the item by id and delete it from the database

### Current working endpoints for sessions and registrations

- `POST /api/v1/auth` - Create a new user
- `POST /api/v1/auth/sign_in` - Login the user

## Live Link  (Heroku)
[Project live link](https://favbooks-api.herokuapp.com/)

### Built With

This project was built using these technologies.

- Ruby
- Ruby on Rail
- API
- devise_token_auth for login funtionality
- Using AWS S3 with Active Storage for storing item images
- GitHub
- Heroku

### Testing

- RSpec
- Shoulda Matchers gem

## Getting Started

**To get this project set up on your local machine, follow these simple steps:**

**Step 1**<br>
Navigate through the local folder where you want to clone the repository and run
`git clone https://github.com/jstloyal/favorite-books-API`.<br>
**Step 2**<br>
Run `cd favorite-books-API`<br>
**Step 3**<br>
Run `bundle install` to install the gems from the `Gemfile`.<br>
**Step 4**<br>
Run `yarn install` to install the npm packages from the `package.json` file.<br>
**Step 5**<br>
Run `bundle exec figaro install`, this will create a file called `application.yml` in the `config` folder.<br>
**Step 6**<br>
Open `config/application.yml` and add your credenatials for your postgres/[AWS S3](https://aws.amazon.com/console/) accounts like this (click on the above links to find out how to get a key):<br>
`PG_DATABASE_USER: example` <br>
`PG_DATABASE_PASSWORD: password`<br>
`BUCKETEER_AWS_ACCESS_KEY_ID: key`<br>
`BUCKETEER_AWS_SECRET_ACCESS_KEY: key`<br>
`BUCKETEER_AWS_REGION: key-zone`<br>
`BUCKETEER_BUCKET_NAME: key-bucket`<br>
**Step 7**<br>
Run `rails db:create` and `rails db:migrate` to create and migrate the database tabels and associations.<br>
**Step 8**<br>
Run `rails s` to start the rails server.<br>
**Step 9**<br>
You can visit the app at `http://localhost:3000`. Enjoy!<br>

## Contributors

**Author**

​**Adetayo Sunkanmi**

- Github: [jstloyal](https://github.com/jstloyal)
- Twitter: [@jstloyalty](https://twitter.com/jstloyalty)
- Linkedin: [Adetayo Sunkanmi](https://www.linkedin.com/in/jstloyalty)
- E-mail: jstloyalty@gmail.com

<!-- ACKNOWLEDGEMENTS -->

## Acknowledgements

- [Microverse](https://www.microverse.org/)

## License

📝
This project is [MIT](https://opensource.org/licenses/MIT) licensed.

## Show your support

If you've read this far....give us a ⭐️!
