# RailsAuthGenerator

**RailsAuthGenerator** is a Rails generator that scaffolds a **JWT-based authentication system** with user management, password resets, refresh token rotation, and secure cookie handling. It saves you weeks of setup by providing all the models, controllers, serializers, and mailers you need for a robust, production-ready authentication flow.

---

## ✨ Features

- 🔑 **JWT Authentication**
  - Access tokens (short-lived, default 15 min)
  - Refresh tokens (stored securely in HttpOnly cookies)
  - Token rotation + reuse detection
  - Logout everywhere
- 👤 **User management**
  - User model with secure password
  - Role support (admin, user)
- ✉️ **Password reset**
  - Password reset tokens sent via email
- 🛠️ **Rails Generators**
  - User model + migrations
  - Auth controllers (`auth`, `users`, `password_resets`)
  - Serializers and mailers
- ⚡ Works with **Rails 6.0+**

---

## 📦 Installation

Add this line to your application's Gemfile:  
`gem 'rails_auth_generator', '~> 0.2.1'`  

and then run:  
`bundle install`  

Or install it manually:  
`gem install rails_auth_generator`  

If you want the latest version from GitHub:  
`gem 'rails_auth_generator', git: 'https://github.com/Zeyad-Hassan-1/authJWT.git'`

---

## 🚀 Usage

Generate the full authentication system:  
`rails generate auth`  

Then run:  
`bundle install`  
`rails db:migrate`  

This scaffolds:
- User model & migrations
- Controllers for authentication, users, and password resets
- Mailers for password reset
- Serializers for user data  

You can freely customize the generated files to match your app’s requirements.

---

## 🔧 Additional Setup

### 1. Enable CORS
Uncomment the CORS config in `config/initializers/cors.rb` if building an API:

`Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true
  end
end`

### 2. Set JWT Secret
Edit your Rails credentials:  
`VISUAL="code --wait" bin/rails credentials:edit`  

Add:

`jwt:
  secret: <your_generated_secret>`

Generate a secret key:  
`rails secret`  

Replace `<your_generated_secret>` with the generated key.

---

## 📚 API Overview

| Route             | Method | Description |
|-------------------|--------|-------------|
| `/signup`         | POST   | Create a new user |
| `/login`          | POST   | Authenticate user, return JWT + set refresh cookie |
| `/me`             | GET    | Get current logged-in user |
| `/refresh`        | POST   | Rotate refresh token + issue new JWT |
| `/logout`         | DELETE | Revoke refresh token + clear cookie |
| `/password_resets`| POST   | Request a password reset |
| `/password_resets` | PUT | Reset password with token |

---

## 🧪 Example Usage

1. Sign up:  
`curl -X POST http://localhost:3000/signup -H "Content-Type: application/json" -d '{"user": {"email":"test@example.com","password":"secret123"}}'`

2. Login:  
`curl -X POST http://localhost:3000/login -H "Content-Type: application/json" -d '{"email":"test@example.com","password":"secret123"}'`  
➡️ Returns `{ "token": "...", "user": {...} }`  
Refresh token is stored in an **HttpOnly cookie**.

3. Access protected route:  
`curl -H "Authorization: Bearer <your_token>" http://localhost:3000/me`

4. Refresh token:  
`curl -X POST http://localhost:3000/refresh`  
➡️ Returns new access token, rotates refresh cookie.

5. Logout:  
`curl -X DELETE http://localhost:3000/logout`  
➡️ Revokes refresh token + clears cookie.

---

## 🛡️ Security Defaults

- Access tokens expire after **15 minutes**  
- Refresh tokens expire after **7 days**  
- Refresh tokens are **rotated on every use**  
- Reused tokens trigger **global logout**  

---

## 🤝 Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/Zeyad-Hassan-1/authJWT](https://github.com/Zeyad-Hassan-1/authJWT).  

This project follows a [Code of Conduct](CODE_OF_CONDUCT.md). Please respect it in all interactions.

---

## 📄 License

This gem is available as open source under the terms of the [MIT License](LICENSE.txt).
