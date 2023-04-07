class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :street_address, :building_name, :phone_number, :purchase_id, :item_id, :user_id, :token

  # ここにバリデーションの処理を書く
  with_options presence: true do
  validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)"}
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :city
  validates :street_address
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "Input only number" }
  validates :user_id
  validates :item_id
  validates :token
  end




  def save
    purchase = Purchase.create(item_id: item_id, user_id: user_id)

    Address.create(post_code: post_code, prefecture_id: prefecture_id, city: city, street_address: street_address, building_name: building_name, phone_number: phone_number, purchase_id: purchase.id)
  end
end