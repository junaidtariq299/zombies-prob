class TradeService
  def make_barter_trade trade_params
    @trade_params = trade_params
    load_buyer_and_receiver
    is_trade_legit?
    execute_trade
  end

  private

  def execute_trade
    ActiveRecord::Base.transaction do
      update_items_for @receiver, @buyer, receiver_items
      update_items_for @buyer, @receiver, buyer_items
    end
  end

  def update_items_for receiver, buyer, items
    items.each do |item|
      receiver_inventory_item = receiver.inventory_items.find_by item_id: item[:item_id]
      receiver_inventory_item.quantity -= item[:quantity]
      buyer_inventory_item = buyer.inventory_items.find_or_initialize_by item_id: item[:item_id]
      buyer_inventory_item.quantity += item[:quantity]
      receiver_inventory_item.save!
      buyer_inventory_item.save!
    end
  end

  def load_buyer_and_receiver
    @buyer = Survivor.find @trade_params[:buyer_id]
    @receiver = Survivor.find @trade_params[:receiver_id]
  end

  def is_trade_legit?
    raise "Buyer and Receiver both should not be infected"  if @buyer.infected? || @receiver.infected
    raise "Buyer should must trade with someone else"  if @buyer == @receiver
    raise "For Trade, both survivors must have items mentioned in trade"  if are_items_unavaiable?
    raise "For trade, Quantity of items should be valid for both."  if is_quantity_invalid?
    raise "For trade, Items should be of same value commulatively."  if are_points_different?
  end


  def are_points_different?
    points_for(buyer_items) != points_for(receiver_items)
  end

  def points_for items
    points = 0

    items.each do |inventory_item|
      item = Item.find inventory_item[:item_id]
      points += item.points * inventory_item[:quantity]
    end
    points
  end

  def are_items_unavaiable?
    (item_ids_for(buyer_items) - item_ids_owned_by(@buyer)).present? ||
    (item_ids_for(receiver_items) - item_ids_owned_by(@receiver)).present?
  end

  def item_ids_for items
    items.pluck :item_id
  end

  def item_ids_owned_by survivor
    survivor.inventory_items.pluck :item_id
  end

  def are_items_not_of_same_value?
    survivor.inventory_items.pluck :item_id
  end

  def is_quantity_invalid?
    is_quantity_valid_for?(buyer_items, @buyer) && is_quantity_valid_for?(receiver_items, @receiver)
  end

  def is_quantity_valid_for? items, survivor
    valid = false
    items.each do |item|
      valid = survivor.inventory_items.where(item_id: item[:item_id], quantity: item[:quantity]..).nil?
      break unless valid
    end
    valid
  end

  def buyer_items
    @trade_params[:buyer_items]
  end

  def receiver_items
    @trade_params[:receiver_items]
  end

  def find_item id
    Item.find id
  end
end