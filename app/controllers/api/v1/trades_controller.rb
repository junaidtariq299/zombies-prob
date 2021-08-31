class Api::V1::TradesController < ApplicationController
  def create
    begin
      TradeService.new.make_barter_trade trade_params
      render json: { success: true, status: 200 }
    rescue => e
      render json: { error: true, message: e.message }
    end
  end

  private

  def trade_params
    params.require(:trade).permit(:buyer_id, :receiver_id, buyer_items: [:item_id, :quantity], receiver_items: [:item_id, :quantity])
  end
end
