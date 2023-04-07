require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  describe '商品の購入または配送先情報の保存' do
    before do
      item = FactoryBot.create(:item)
      user = FactoryBot.create(:user)
      @purchase_address = FactoryBot.build(:purchase_address, user_id: user.id, item_id: item.id)
    end

    context '商品購入できる場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchase_address).to be_valid
      end
      it '郵便番号が必須であること' do
        @purchase_address.post_code = "111-1111"
        expect(@purchase_address).to be_valid
      end
      it '都道府県の選択は必須であること（---以外）' do
        @purchase_address.prefecture_id = 2
        expect(@purchase_address).to be_valid
      end
      it '市区町村が必須であること' do
        @purchase_address.city = "東京"
        expect(@purchase_address).to be_valid
      end
      it '番地が必須であること' do
        @purchase_address.street_address = "東京"
        expect(@purchase_address).to be_valid
      end
      it '建物名の記入は任意であること' do
        @purchase_address.building_name = ""
        expect(@purchase_address).to be_valid
      end
      it '電話番号が必須であること（半角数字１０桁１１桁以内）' do
        @purchase_address.phone_number = 11111111111
        expect(@purchase_address).to be_valid
      end
      it 'tokenが必須であること' do
        @purchase_address.token = "tok_abcdefghijk00000000000000000"
        expect(@purchase_address).to be_valid
      end

      context '内容に問題がある場合' do
        it '郵便番号が記入されていないと購入できない' do
          @purchase_address.post_code = ''
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("Post code is invalid. Enter it as follows (e.g. 123-4567)")
        end
        it ' 郵便番号は、「3桁ハイフン4桁」の半角文字列のみ保存可能なこと（良い例:123-4567 良くない例:1234567）。' do
          @purchase_address.post_code = '1234567'
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("Post code is invalid. Enter it as follows (e.g. 123-4567)")
        end
        it '都道府県の選択が必須であること' do
          @purchase_address.prefecture_id = nil
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("Prefecture can't be blank")
        end
        it '都道府県の選択が---ではいけないこと' do
          @purchase_address.prefecture_id = 1
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("Prefecture can't be blank")
        end
        it '市区町村が必須であること' do
          @purchase_address.city = nil
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("City can't be blank")
        end
        it '番地が必須であること' do
          @purchase_address.street_address = nil
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("Street address can't be blank")
        end
        it '電話番号は必須であること' do
          @purchase_address.phone_number = nil
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("Phone number can't be blank")
        end
        it '電話番号の入力は、全角数字ではいけないこと' do
          @purchase_address.phone_number = '１１１１１１１１１１１'
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("Phone number Input only number")
        end
        it '電話番号の入力は、10桁以上11桁以内の半角数値のみ保存可能なこと（良い例:09012345678 良くない例:090-1234-5678)' do
          @purchase_address.phone_number = 111-1111111
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("Phone number Input only number")
        end
        it '電話番号の入力は、９桁以下では購入できない' do
          @purchase_address.phone_number = 222222222
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("Phone number Input only number")
        end
        it '電話番号の入力は、12桁以上では購入できない' do
          @purchase_address.phone_number = 222222222222
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("Phone number Input only number")
        end
        it 'userが紐付いていないと保存できないこと' do
          @purchase_address.user_id = nil
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("User can't be blank")
        end
        it 'itemが紐付いていないと保存できないこと' do
          @purchase_address.item_id = nil
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("Item can't be blank")
        end
        it "tokenが空では登録できないこと" do
          @purchase_address.token = nil
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
        end



      end
   end
  end
end
