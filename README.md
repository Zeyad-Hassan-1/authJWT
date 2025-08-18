# RailsAuthGenerator

RailsAuthGenerator provides Rails generators for authentication, user management, password resets, and mailers, streamlining the setup of secure user authentication in Rails applications. It helps you quickly scaffold all necessary models, controllers, mailers, and migrations for a robust authentication system.

## Features

- User model and migration generator
- Authentication controller and password reset controller
- User serializer for API responses
- Mailers for sending token to reset password
- Easy integration with Rails 6.0+

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails_auth_generator', '~> 0.1.0'
```

and then
```bash
bundle install
```

Or install it manually:

```bash
gem install rails_auth_generator
```

If you want to use the latest version from GitHub:

```ruby
gem 'rails_auth_generator', git: 'https://github.com/Zeyad-Hassan-1/authJWT.git'
```

## Usage

Run the generator to scaffold authentication features:

```bash
rails generate auth
```
then:

```bash
bundle install
```

This will create:
- User model and migration
- Authentication controllers (auth, password resets, users)
- Mailers for sending token to reset password
- Serializers for user data

Don't forgot to run migration:
```bash
rails db:migrate
```

You can customize the generated files as needed for your application.
### Additional Setup

1. **Enable CORS**
   - Uncomment the CORS configuration in `config/initializers/cors.rb` to allow cross-origin requests if you are building an API.

2. **Set JWT Secret**
   - Edit your Rails credentials to add a JWT secret:

     ```bash
     VISUAL="code --wait" bin/rails credentials:edit
     ```

   - Add the following to your credentials file:

     ```yaml
     jwt:
       secret: <your_generated_secret>
     ```

   - Generate a secret key by running:

     ```bash
     rails secret
     ```

   - Replace `<your_generated_secret>` with the key you generated.


## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/Zeyad-Hassan-1/authJWT](https://github.com/Zeyad-Hassan-1/authJWT). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](LICENSE.txt).

## Code of Conduct

Everyone interacting in the RailsAuthGenerator project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](CODE_OF_CONDUCT.md).
