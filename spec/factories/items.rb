FactoryBot.define do
  factory :item do
    association :user

    item_name           {'オムライス'}
    production          {'美味しいよ'}
    category_id         {2}
    condition_id        {2}
    shipping_payer_id   {2}
    prefecture_id       {2}
    shipping_day_id     {2}
    price               {500}

    
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
    
  end
end
