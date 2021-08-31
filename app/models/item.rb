class Item < ApplicationRecord
    validates_presence_of :name, :points
    validates :points , numericality: { greater_than_or_equal_to: 1}
end
