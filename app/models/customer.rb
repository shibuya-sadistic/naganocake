class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items
  has_many :addresses
  has_many :orders

  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
       params.delete(:password)
       params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

  with_options presence: true do
    validates :last_name
    validates :first_name
  end

  validates :last_name_kana, presence: true,
                             format: {
                             with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/,
                             message: "は全角カタカナのみで入力してください"
                            }
  validates :first_name_kana, presence: true,
                              format: {
                              with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/,
                              message: "は全角カタカナのみで入力してください"
                            }
  validates :postcode, presence: true,
                        format: {
                          with: /\A[0-9]{7}\z/,
                          message: "は半角数字のみで入力してください"} # 郵便番号（ハイフンなし7桁）


  validates :address, presence: true
  validates :tel, presence: true,
                        format: {
                          with: /\A\d{10,11}\z/,
                          message: "は半角数字のみで入力してください"} # 携帯番号(ハイフンなし10桁or11桁)




end