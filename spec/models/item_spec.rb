require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品の出品' do
    context "商品が出品できる場合" do
      it "画像、商品名、商品説明、カテゴリー、商品の状態、配送料の負担、発送元の地域、発送までの地域が正しく記入または選択されていれば出品できる" do
        expect(@item).to be_valid
      end
      it "商品名が記入されていれば出品できる" do
        @item.item_name = '山田田中'
        expect(@item).to be_valid
      end
      it "商品の説明が記入されていれば出品できる" do
        @item.production = '山田田中'
        expect(@item).to be_valid
      end
      it "カテゴリーが’---’以外を選択されていれば出品できる" do
        @item.category_id = 2
        expect(@item).to be_valid
      end
      it "商品の状態が’---’以外を選択されていれば出品できる" do
        @item.condition_id = 2
        expect(@item).to be_valid
      end
      it "配送料の負担が’---’以外を選択されていれば出品できる" do
        @item.shipping_payer_id = 2
        expect(@item).to be_valid
      end
      it "発送元の地域が’---’以外を選択されていれば出品できる" do
        @item.prefecture_id = 2
        expect(@item).to be_valid
      end
      it "発送までの日数が’---’以外を選択されていれば出品できる" do
        @item.shipping_day_id = 2
        expect(@item).to be_valid
      end
      it "価格に整数が記入されていて、なおかつ300以上ならば出品できる" do
        @item.price = 300
        expect(@item).to be_valid
      end
      it "価格に整数が記入されていて、なおかつ9.999.999以下ならば出品できる" do
        @item.price = 9999999
        expect(@item).to be_valid
      end
    end
    context "商品が出品できない場合" do
      it "商品画像が未選択ならば出品できない" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end     
      it "商品名が未記入ならば出品できない" do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end     
      it "商品説明が未記入ならば出品できない" do
        @item.production = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Production can't be blank")
      end
      it "カテゴリーが'---'を選択していれば出品できない" do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it "商品の状態が'---'を選択していれば出品できない" do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end
      it "配送料の負担が'---'を選択していれば出品できない" do
        @item.shipping_payer_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping payer can't be blank")
      end
      it "発送元の地域が'---'を選択していれば出品できない" do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it "発送までの日数が'---'を選択していれば出品できない" do
        @item.shipping_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping day can't be blank")
      end
      it "価格が空欄では出品できない" do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it "価格に整数以外を記入すると出品できない" do
        @item.price = 'aaaa'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it "価格に300以下の整数を記入すると出品できない" do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end
      it "価格に9.999.999以上の整数を記入すると出品できない" do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end
    end
  end
end
