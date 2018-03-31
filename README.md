# Wik

## Wik is an online platform that can be used as an internal tool to allows users to store public and private wikis

## Features

- Users can sign up for a free account to store public wikis
- Users can upgrade their account to premium to store private wikis
- Payments are accepted through a Braintree integration
- Premium users can add collaborators to their wikis
- Wikis can be created through markdown

## Setup and

**Ruby v 2.3.3**
**Rails v 4.2.5**

**Databases:** SQLite (Test, Development), PostgreSQL (Production)

**Gems Used:**

- _Factory Girl_ - Development
- _Bootstrap_ - Styling
- _Bcrypt_ - Data Encryption
- _Figaro_ - Environmental Variables
- _Rspec_ - TDD
- _Devise_ - Authentication
- _Pundit_ - Authorization
- _Faker_ - Seed Data
- _Braintree_ - Payments
- _Dotenv_ - Evnironment
- _Redcarpet_ - Markdown parser

**To run Wik locally:**

1. Clone the repository
2. Run `bundle install`
3. Create and migrate the SQLite database with `rake db:create` and `rake db:migrate`
4. Create a `.env` file in your root directory and fill in your credentials accordingly:

```
BT_ENVIRONMENT='sandbox'
BT_MERCHANT_ID='your braintree merchant id'
BT_PUBLIC_KEY='your braintree public key'
BT_PRIVATE_KEY='your braintree private key'
```

5. Run the app on localhost:3000
