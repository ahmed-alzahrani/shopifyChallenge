# Shopify Challenge 2019

## Problem / Requirements

__Question 1__: Please design a server-side web API that models the following simple relationship:

- Shops have many Products
- Shops have many Orders
- Products have many Items
- Orders have many Items

(Items refer to any service or product added to an order, along with the quantity and price that pertain to them).

__Requirements per type__:

- Products, Items, and Orders all have a dollar value

- The value of an item should map to the value of the product that the item represents.

- The total value of an order should equal the sum of the value of it's items

__Extra Credit__:

- Supporting full CRUD operations
- Extending the base functionality in interesting ways
- Making your API at least partly secure
- Writing documentation that doesn't suck
- Building the API using GraphQL
- Unit testing

__Extra EXTRA credit__:
- Deploy the web API you have created to a Kubernetes environment that is publicly accessible.

## Context

#### The Store

Imagine for a moment, an apocalyptic future, one in which the various technologies developers and companies use to create software are no longer freely available on the web, but rather hidden behind pay-walls, and only downloadable upon purchase.

Gone are the days of enterprising young programmers toying around freely with the latest web framework, or hybrid mobile application SDK. Rather, there exists a number of authorized software distributors that sell  software to end-users at a price.

As horrible as this reality may seem to those of us with a passion for programming, my sample API is modeled in such a future, and around one such authorized software distributor:

_Peter's Programming Paradise_

![image logo](assets/LogoMakr_1Lvyuu.png)

At Peter's Programming Paradise, various software can be purchased, belonging to the following six categories:

- Mobile
- Web
- Front-end
- Database
- DevOps
- Text Editors/IDEs

In the original problem, it is stated that products have multiple items. I took this to mean that an individual item can represent a variation on the product that it maps to. For example, if a clothing store sold a certain jacket called _The Cool Jacket_, then _The Cool Jacket_ would be the product, and _The Cool Jacket (small)_ , _The Cool Jacket (medium)_, and _The Cool Jacket (large)_ could potentially represent the items that map onto the product.

In this case, since software typically doesn't come in different sizes and colours, line items represent the level of _service_ that Peter's Programming Paradise is willing to sell along with the base product. So, for example, if _Ruby on Rails_ was a web framework that the store offered, then _Ruby on Rails (base)_, _Ruby on Rails (+ 1 year service)_, and _Ruby on Rails (+ 2 year service)_ would represent the various items. In this case, service means that the staff of Peter's Programming Paradise will offer troubleshoot support, help with parsing documentation, and various customer forums where people can have their questions answered (think StackOverflow if it was hidden behind a pay-wall).

#### Technologies Used

For the purposes of this API, I decided to use Ruby on Rails, with the built-in SQLite database. I also used the ruby gem _graphiql_ to offer interactive documentation, but more on that later.

The reason behind choosing Ruby on Rails was simple. As someone who is very comfortable with writing servers using Node.js, the switch to Rails was quite seamless. Ruby is a language that was designed to be read human-first, machine-second, and as such doesn't boast some of the same idiosyncrasies that javascript has. And, as a framework, using Rails and the bundler to manage gem dependencies feels very similar to using npm. Rails keen focus on DRY, convention over implementation, and straight-forward usage of MVC architecture made it a delight to work with as someone with some prior exposure to Ruby via course-work.

Lastly, its important when applying for work to know your audience. Shopify is one of the largest applications in the world built on Rails, and have been a trailblazer as a company in showing the world the power of GraphQL as opposed to the classic REST Api implementation.

What I've discovered is that once you begin using GraphQL, it feels so natural. Long gone are the days of under or over-querying, and then installing some middleware or back-end logic to parse the data and hone in on what the client or end-user desires. With GraphQL, you can simply describe the data you wish to receive, receive it. It's incredibly easy, and satisfying.

## Getting Started

Before you've cloned this repo, you need to ensure that you have the Ruby programming language, as well as Rails and SQLite installed on your machine. Thankfully, [RailsInstaller](http://railsinstaller.org/en) is the quickest way to go from zero to developing Ruby on Rails applications. Regardless of the OS you are working on, follow the instructions at that web-page and you will be ready to work with this API in no time.

Once you have everything installed, simply clone the repo into a fresh directory and then navigate into it and run:

`bundle`

This will install all gem dependencies for this project. Once that is done, run the following two commands to migrate and seed the database with the default schema and records.

`rake db:migrate`
`rake db:seed`

Once this is done, simply fire up the server:

`rails s` or `rails server`

Once the server has started, you can navigate to the following url to ensure that it is working: `http://localhost:3000/`

You should see the following default Rails landing page, as a signal that the server is successfully running

![landing_page](assets/rails_landing_page.png)

## My API

The way in which I decided to model the relations specified in the problem outline can be viewed in this SQL relation diagram.

![sql diagram](assets/SQLite_High_Levle.png)

Apart from showing you what some of the fields that different types have, the relationships shown in the diagram can also be explained as:

##### Store

  - A store has_many (0,...,n) products
  - A store has_many (0,...,n) orders
  - A store belongs_to (via foreign key) a User

#### User

  - A user has_many (0,...,n) orders
  - A user CAN own a store via that store's foreign key

#### Order

  - An order belongs_to (via foreign key) a user
  - An order belongs_to (via foreign key) a store
  - An order has_and_belongs_to_many (via a join table) items, this means that an order has many (1,...,n) items, and an item can belong to many (0,...,n) orders

#### Product

  - A product has_many (1,...,n) items
  - A product belongs_to (via foreign key) a store

#### Item

  - An item belongs_to (via foreign key) a product
  - An item has_and_belongs_to_many (via a join table) orders, this means that an order has many (1,...,n) items, and an item can belong to many (0,...,n) orders

As part of these relations, operations on certain records (a product for example) will also trigger operations on other records (the items that map onto that product for example), these will all be outlined below in the _Full Crud_ section of this README.

### Seed Data

My API is built to model the given relationships within the context of _Peter's Programming Paradise_.

The `db/seeds.rb` file need not be edited, it is set up to automatically look for all seed files in the `seeds` directory and run them alphabetically. For this reason, the naming convention for seed files should be kept as follows:

`a_seed.rb`
`b_seed.rb`
`c_seed.rb`

If you wish to deviate in order to specify what a seed is for, you can keep adhering to the style as such:

`d_special_user_seed.rb`

The seed data is set up such that there exists only the one store, with two default users; Peter, the owner of Peter's Programming Paradise, and an example customer. This is so that out-of-the-box we can test how the different user roles interact with the API.

As far as products, there exist 10 products in each of the 6 aforementioned categories, each with their own 3 item variations, following the style specified in this document. In order to see specifically what is being seeded, please visit the `b_seed.rb` [here](db/seeds/b_seed.rb)


## Full CRUD Operations

CRUD (Create, Read, Update, and Destroy) operations represent the different ways we can read and manipulate data within a database.

This particular API was built using GraphQL, which means that we can interact with our data via _Queries_ and _Mutations_. Both operations do what their name suggests, either query or mutate the data in some way.

Below is a brief overview of the different queries and mutations that can be made to the API. To read about them in more detail, visit the !!!! documentation section of this README and follow the instructions on how to view the API in _Graphiql_.

### Queries

#### stores

Queries the database for all records of type store. This query can be filtered by supplying various optional arguments such as store name, store email address, store order count etc.


#### users

Queries the database for all records of type user. This query can also be filtered by supplying various optional arguments such as user first name, last name, email address etc

_Only owners can query this API for users, more information on user roles can be found in the security section._

#### getMe

A query that takes in an `authentication_token` and returns the user that the token belongs to.


#### orders

Queries the database for all records of type order. This query can also be filtered by supplying various optional arguments such as user id, storeId, as well as how much orders cost.

_Only owners can query this API for orders, more information on user roles can be found in the security section._


#### products

Queries the database for all records of type product. This query can also be filtered by supplying various optional arguments such as name, value, tags, etc.

Querying for products can also return all of the item variations for that product. In this sense, this query serves both products and items, since GraphQL allows you to specify what fields you would like to query.


### Mutations

Below is a brief overview of the different mutations offered by this API. Most of these mutations are available only to owners and not to regular users. For more information on user roles, please visit the security section of this README.

#### createProduct

A mutation that creates a product by taking in as arguments various information that is required to create a Product record in the database.


#### updateProduct

A mutation that creates a product by taking in as arguments various information that is required to create a Product record in the database.












## Hello World

Hello, this is some text to fill in this, [here](#Place-2), is a link to the second place.

## Place 2

Place one has the fun times of linking here, but I can also link back [here](#hello-world).




















- Unit Testing

AFTER SUBMISSION:
- Kubernetes

OTHER WORK:

- Resume Update

- Cover Letter

- Build a store
