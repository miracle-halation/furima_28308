require 'rails_helper'

RSpec.describe User, type: :model do
	describe "ユーザー新規登録" do
		before do 
			@user = FactoryBot.build(:user)
		end

		it "全ての情報が正しく入力されていれば登録できる" do
			expect(@user).to be_valid
		end
		it "nicknameが空だと登録できない" do
			@user.nickname = nil
			@user.valid?
			expect(@user.errors.full_messages).to include("Nickname can't be blank")
		end
		it "emailが空だと登録できない" do
			@user.email = nil
			@user.valid?
			expect(@user.errors.full_messages).to include("Email can't be blank")
		end
		it "すでに登録されたemailだと登録できない" do
			another_user = FactoryBot.create(:user)
			@user.email = another_user.email
			@user.valid?
			expect(@user.errors.full_messages).to include("Email has already been taken")
		end
		it "emailに@がないと登録できない" do
			@user.email = "example.com"
			@user.valid?
			expect(@user.errors.full_messages).to include("Email is invalid. Input @ character.")
		end
		it "passwordが空だと登録できない" do
			@user.password = nil
			@user.valid?
			expect(@user.errors.full_messages).to include("Password can't be blank")
		end
		it "passwordが6文字以下だと登録できない" do
			@user.password = "a" * 5
			@user.valid?
			expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
		end
		it "passwordが6文字以上だと登録できる" do
			@user.password = "a" * 6
			@user.password_confirmation = @user.password
			expect(@user).to be_valid
		end
		it "passwordが半角英数字混合でないと登録できない" do
			@user.password = "山田太郎"
			@user.valid?
			expect(@user.errors.full_messages).to include("Password is invalid. Input half-width characters.")
		end
		it "password_confirmationがpasswordと一致していないと登録できない" do
			@user.password_confirmation = "a" * 6
			@user.valid?
			expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
		end
		it "family_nameが空だと登録できない" do
			@user.family_name = nil
			@user.valid?
			expect(@user.errors.full_messages).to include("Family name can't be blank")
		end
		it "family_nameが全角日本語出ないと登録できない" do
			@user.family_name = "yamada"
			@user.valid?
			expect(@user.errors.full_messages).to include("Family name is invalid. Input full-width characters.")
		end
		it "family_name_readingが空だと登録できない" do
			@user.family_name_reading = nil
			@user.valid?
			expect(@user.errors.full_messages).to include("Family name reading can't be blank")
		end
		it "family_name_readingがカタカナでないと登録できない" do
			@user.family_name_reading = "山田"
			@user.valid?
			expect(@user.errors.full_messages).to include("Family name reading is invalid. Input full-width katakana characters.")
		end
		it "first_nameが空だと登録できない" do
			@user.first_name = nil
			@user.valid?
			expect(@user.errors.full_messages).to include("First name can't be blank")
		end
		it "first_nameが全角日本語でないと登録できない" do
			@user.first_name = "tarou"
			@user.valid?
			expect(@user.errors.full_messages).to include("First name is invalid. Input full-width characters.")
		end
		it "first_name_readingが空だと登録できない" do
			@user.first_name_reading = nil
			@user.valid?
			expect(@user.errors.full_messages).to include("First name reading can't be blank")
		end
		it "first_name_readingがカタカナでないと登録できない" do
			@user.first_name_reading = "太郎"
			@user.valid?
			expect(@user.errors.full_messages).to include("First name reading is invalid. Input full-width katakana characters.")
		end
		it "birthdayが空だと登録できない" do
			@user.birthday = nil
			@user.valid?
			expect(@user.errors.full_messages).to include("Birthday can't be blank")
		end

	end
end
