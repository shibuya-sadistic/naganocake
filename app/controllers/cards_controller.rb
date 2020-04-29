class CardsController < ApplicationController
require "payjp"
  before_action :set_card

  def new # カードの登録画面。送信ボタンを押すとcreateアクションへ。
    card = Card.where(customer_id: current_customer.id).first
    redirect_to action: "index" if card.present?
  end

  def create #PayjpとCardのデータベースを作成
    Payjp.api_key = 'sk_test_295da8063897432c9e337c5b' #秘密鍵

    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      # トークンが正常に発行されていたら、顧客情報をPAY.JPに登録します。
      customer2 = Payjp::Customer.create(
        description: 'test', # 無くてもOK。PAY.JPの顧客情報に表示する概要です。
        email: current_customer.email,
        card: params['payjp-token'], # 直前のnewアクションで発行され、送られてくるトークンをここで顧客に紐付けて永久保存します。
        metadata: {customer_id: current_customer.id} # 無くてもOK。
      )
      @card = Card.new(customer_id: current_customer.id, user_id: customer2.id, card_id: customer2.default_card)
      if @card.save
        redirect_to action: "index"
      else
        redirect_to action: "create"
      end
    end
  end

  def index #CardのデータをPayjpに送って情報を取り出す
    if @card.present?
      Payjp.api_key = "sk_test_295da8063897432c9e337c5b" #秘密鍵
      user = Payjp::Customer.retrieve(@card.user_id)
      @card_information = user.cards.retrieve(@card.card_id)

      # 《＋α》 登録しているカード会社のブランドアイコンを表示するためのコードです。---------
      @card_brand = @card_information.brand
      case @card_brand
      when "Visa"
        @card_src = "visa.jpg"
      when "JCB"
        @card_src = "jcb.jpg"
      when "MasterCard"
        @card_src = "master.jpg"
      when "American Express"
        @card_src = "american.png"
      when "Diners Club"
        @card_src = "diners.jpg"
      when "Discover"
        @card_src = "discover.jpg"
      end
      # ---------------------------------------------------------------

    end
  end

  def destroy #PayjpとCardのデータベースを削除
    Payjp.api_key = "sk_test_295da8063897432c9e337c5b"
    user = Payjp::User.retrieve(@card.customer_id)
    customer.delete
    if @card.destroy #削除に成功した時にポップアップを表示します。
      redirect_to action: "index", notice: "削除しました"
    else #削除に失敗した時にアラートを表示します。
      redirect_to action: "index", alert: "削除できませんでした"
    end
  end

  private

  def set_card
    @card = Card.where(customer_id: current_customer.id).first if Card.where(customer_id: current_customer.id).present?
  end
end