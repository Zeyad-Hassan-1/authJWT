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

This will create:
- User model and migration
- Authentication controllers (auth, password resets, users)
- Mailers for sending token to reset password
- Serializers for user data

You can customize the generated files as needed for your application.

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/Zeyad-Hassan-1/authJWT](https://github.com/Zeyad-Hassan-1/authJWT). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](LICENSE.txt).

## Code of Conduct

Everyone interacting in the RailsAuthGenerator project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](CODE_OF_CONDUCT.md).
