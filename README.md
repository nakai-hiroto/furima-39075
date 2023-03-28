# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


## users


| Column          | Type   | Options    | 
| --------------- | ------ | ---------- | 
| nickname        | string | null:false | 
| email           | string | null:false | 
| password        | string | null:false | 
| last_name       | string | null:false | 
| first_name      | string | null:false | 
| last_name_kana  | string | null:false | 
| first_name_kana | string | null:false | 
| birthday        | string | null:false | 



### Association
has_many :items
has_many :purchases
belongs_to :addresses



## items

| Column            | Type       | Options                        | 
| ----------------- | ---------- | ------------------------------ | 
| item_name         | string     | null:false                     | 
| production        | text       | null:false                     | 
| category          | text       | null:false                     | 
| condition         | text       | null:false                     | 
| user              | references | null: false, foreign_key: true | 
| shipping_payer_id | integer    | null:false                     | 
| prefecture_id     | integer    | null:false                     | 
| shipping_day_id   | integer    | null:false                     | 
| price             | integer    | null:false                     | 



### Association
belongs_to :purchase
belongs_to :user
belongs_to :address





## purchases

| Column            | Type        | Options                        | 
| ----------------- | ----------- | ------------------------------ | 
| post_code         | integer     |                     null:false | 
| living_prefecture | text        | null:false                     | 
| city              | string      | null:false                     | 
| street_address    | string      | null:false                     | 
| building_name     | string      |                                | 
| phone_number      | integer     | null:false                     | 
| user              | references  | null: false, foreign_key: true |
| item              | references  | null: false, foreign_key: true |


### Association
belongs_to :user
belongs_to :item
has_one :address





## addresses


| Column     | Type       | Options                        | 
| ---------- | ---------- | ------------------------------ | 
| item       | references | null: false, foreign_key: true | 
| purchase   | references | null: false, foreign_key: true | 
| user       | references | null: false, foreign_key: true | 



### Association
belongs_to :purchase
belongs_to :user
belongs_to :item