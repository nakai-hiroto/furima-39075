FactoryBot.define do
  factory :purchase_address do

    post_code          {'123-4567'}
    prefecture_id      {2}
    city               {"東京"}
    street_address     {"東京"}
    building_name      {"東京"}
    phone_number       {11111111111}
    token              {"tok_abcdefghijk00000000000000000"}
    
  end
end
