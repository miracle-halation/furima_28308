# テーブル設計

## user
| Column | Type | Options |
| ------ | ---- | ------- |
| nickname | string | null: false |
| email | string | null: false|
| password | string | null:false |
| name | string | null: false |
| name_reading | string | null:false |
| birthday | string | null: false |

### Association
- has_many :products
- has_one :address

## product
| Column | Type | Options |
| ------ | ---- | ------- |
|	name 	 | string | null: false |
| price  | integer | null: false |
| description | text | null: false |
| genre_id | integer | null: false |
| status | integer | null: false |
| delivery_fee | integer | null: false |
| prefecture | integer | null: false |
| shipment | integer | null: false |
| sold_out | boolean | --- |
| user_id | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :order

## order
| Column | Type | Options |
| ------ | ---- | ------- |
| price  | integer | null: false |
| addresses_id | references | null: false, foreign_key: true |
| product_id | references | null: false, foreign_key: true |

### Association
- belongs_to :product
- belongs_to :address

## address
| Column | Type | Options |
| ------ | ---- | ------- |
| postal_code | string | null: false |
| prefecture | integer | null: false |
| city | string | null:false |
| house_number | string | null: false |
| building_name | string | null: false |
| phone_number | integer | null: false |
| user_id | references | null: false, foreign_key: true |

### Association
- has_many :order
- belongs_to :user
