class InventoryItem < ApplicationRecord
  belongs_to :survivor
  belongs_to :item
  after_initialize :set_default_quantity
  scope :for_infected, -> { includes(:item).joins(:survivor).where("survivors.infected = ?", true) }
  scope :for_not_infected, -> { includes(:item).joins(:survivor).where("survivors.infected = ?", false) }
  scope :not_finished, -> { where(quantity: 1..) }
  before_create :validate_quantity
  
  private
  def set_default_quantity
    self.quantity = 0 unless self.id.present?
  end

  def validate_quantity
    self.errors.add(:quantity, "Must be greater than 0") if self.quantity < 1
  end
end
