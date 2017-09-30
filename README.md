# Wik

## Wik is an online platform that can be used as an internal tool to allows users to store public and private wikis

## Features
- Users can sign up for a free account to store public wikis
- Users can upgrade their account to premium to store private wikis
- Premium users can add collaborators to their wikis
- Wikis can be created through markdown

## Setup and Configuration
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
- _Stripe_ - Payments
- _Redcarpet_ - Markdown parser

**To run Wik locally:**
1. Clone the repository
2. Run `bundle install`
3. Create and migrate the SQLite database with `rake db:create` and `rake db:migrate`
4. Run the app on localhost:3000
