class Item < ApplicationRecord
  has_one :section_item, dependent: :destroy
  has_one :section, through: :section_item
  has_many :item_modifier_groups, dependent: :destroy
end
