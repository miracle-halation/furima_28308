# テーブル設計

## user
| Column | Type | Options |
| ------ | ---- | ------- |
| nickname | string | null: false |
| email | string | null: false|
| password | string | null:false |
| family_name | string | null: false |
| family_name_reading | string | null:false |
| first_name | string | null: false |
| first_name_reading | string | null:false |
| birthday | date | null: false |

### Association
- has_many :products
- has_many :orders
- has_one :address

## product
| Column | Type | Options |
| ------ | ---- | ------- |
| image	 | string | null: false |
|	name 	 | string | null: false |
| price  | integer | null: false |
| description | text | null: false |
| genre_id | integer | null: false |
| status_id | integer | null: false |
| delivery_fee_id | integer | null: false |
| prefecture_id | integer | null: false |
| shipment_id | integer | null: false |
| sold_out | boolean | --- |
| user_id | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :order

## order
| Column | Type | Options |
| ------ | ---- | ------- |
| addresses_id | references | null: false, foreign_key: true |
| product_id | references | null: false, foreign_key: true |
| user_id | references | null: false, foreign_key: true |

### Association
- belongs_to :product
- belongs_to :address
- belongs_to :user

## address
| Column | Type | Options |
| ------ | ---- | ------- |
| postal_code | string | null: false |
| prefecture_id | integer | null: false |
| city | string | null:false |
| house_number | string | null: false |
| building_name | string | null: false |
| phone_number | integer | null: false |
| user_id | references | null: false, foreign_key: true |

### Association
- has_many :order
- belongs_to :user
