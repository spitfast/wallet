# Internal wallet transactional system

This project is implementation of simple wallet.
The main idea is to have polymorphic Wallet model + Walletable concern.
With this you can easily transform any model to be walletable. You just need to include Walletable to your model like this:
```ruby
class SomeModel < ApplicationRecord
  include Walletable
end
```
##Technologies stack
* ruby 2.5.7.
* rails 5.2.4
* Postgres 9.6.2
* React 16.12.0
* Webpack 4.2.2
* Node 12.13.0
* Rspec
* FactoryBot

## Install
````
bundle install
rails db:setup
 ````
## Development
````
rails s
````
## Running tests
````
rspec
````